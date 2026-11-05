/*
 * QGIS Server map viewer (OpenLayers, plain JavaScript)
 *
 *  1. Reads GetCapabilities   -> builds the panel + metadata
 *  2. "Data" section: one choice per indicator (e.g. Population). The indicator is a QGIS group with
 *     10 km / 1 km / 100 m layers; QGIS Server picks the right one for the zoom level by itself.
 *  3. "Boundaries" section: normal on/off layers (NUTS, LAU)
 *  4. Legends (GetLegendGraphic) and click info (GetFeatureInfo, JSON)
 *
 * All requests go to our own .NET proxy (gis.ashx), never directly to QGIS Server.
 */
(function () {
    'use strict';

    // ---------- Settings ----------
    const WMS_URL = 'gis.ashx';
    const WMS_VERSION = '1.3.0';
    const OGC_PIXEL_SIZE = 0.00028;     // metres per pixel, OGC standard (used to calculate the scale)
    const THEME_OPACITY = 0.8;          // indicators slightly transparent, so streets stay visible

    // How to show a clicked raster value, per indicator (group short name in QGIS)
    const THEME_VALUE = {
        population: (v) => fmt(v, 0) + ' inhabitants in this cell',
        share_under18: (v) => fmt(v, 1) + ' %',
        share_over65: (v) => fmt(v, 1) + ' %',
        living_space_per_capita: (v) => fmt(v, 1) + ' m² per person'
    };

    // Readable labels for vector fields, in case the server returns raw field names
    const FIELD_LABELS = {
        NUTS_ID: 'NUTS code', NAME_LATN: 'Name', NAME_ENGL: 'Name (English)',
        URBN_TYPE: 'Urban type', COAST_TYPE: 'Coastal type', MOUNT_TYPE: 'Mountain type',
        GISCO_ID: 'LAU code', LAU_NAME: 'Municipality', POP_2024: 'Population (2024)',
        POP_DENS_2: 'Density (per km²)', AREA_KM2: 'Area (km²)'
    };
    const HIDDEN_FIELDS = ['fid'];
    const NODATA = -9999;

    // ---------- Helpers ----------
    const $ = (id) => document.getElementById(id);
    const el = (tag, text) => {
        const e = document.createElement(tag);
        if (text != null) e.textContent = text;
        return e;
    };
    const wmsUrl = (params) =>
        WMS_URL + '?' + new URLSearchParams({ SERVICE: 'WMS', VERSION: WMS_VERSION, ...params });
    const fmt = (v, digits = 2) =>
        Number(v).toLocaleString(undefined, { maximumFractionDigits: digits });

    // Boundary layers: name -> { olLayer, info, li }   (Map keeps panel order)
    const vectorLayers = new Map();
    // Indicators: name -> { info, children, li }
    const themes = new Map();
    let activeTheme = null;

    // A "theme" is a group whose layers are named <group>_<resolution>, e.g. population_1km
    const isTheme = (g) => g.Layer && g.Layer.length &&
        g.Layer.every((c) => !c.Layer && c.Name && c.Name.startsWith(g.Name + '_'));
    const isThemeCollection = (g) => g.Layer && g.Layer.length && g.Layer.every(isTheme);

    // ---------- Projection ----------
    // The map uses ETRS89-LAEA (EPSG:3035), the projection of the census grid (like atlas.zensus2022.de):
    // grid cells are exact squares and their outlines are straight lines.
    // Axis order is north-east, as WMS 1.3.0 expects for this projection.
    proj4.defs('EPSG:3035', '+proj=laea +lat_0=52 +lon_0=10 +x_0=4321000 +y_0=3210000 +ellps=GRS80 ' +
        '+towgs84=0,0,0,0,0,0,0 +units=m +no_defs');
    const PROJECTION = new ol.proj.Projection({
        code: 'EPSG:3035', units: 'm', axisOrientation: 'neu',
        extent: [1507846.05, 1896628.62, 6829874.45, 4662111.45]
    });
    ol.proj.addProjection(PROJECTION);
    ol.proj.proj4.register(proj4);
    const VIEW_EXTENT = [3700000, 2400000, 5000000, 3800000];   // Germany + neighbours (= basemap data area)

    // Web-map zoom level for a resolution at German latitudes; the Natural Earth zoom levels (z) use this scale
    const WEB_RES_ZOOM0 = 156543.03 * Math.cos(51 * Math.PI / 180);
    const webZoom = (resolution) => Math.log2(WEB_RES_ZOOM0 / resolution);

    // ---------- Map ----------
    // Light background drawn by ourselves (no tile service): country borders and coastline below the data,
    // rivers, lakes and city names on top. Data: Natural Earth 10m, clipped to Germany (json/gisBasemap.json).
    // Each feature has k = border | coast | river | lake | city, n = name, z = first zoom level to show it.
    const BASEMAP_URL = 'json/gisBasemap.json';
    const CITY_ZOOM_BIAS = 0.3;        // show a city slightly before its Natural Earth zoom level

    const basemapSource = new ol.source.Vector({
        url: BASEMAP_URL,
        format: new ol.format.GeoJSON(),
        attributions: 'Made with <a href="https://www.naturalearthdata.com/">Natural Earth</a>'
    });

    const S = ol.style;
    const stroke = (color, width, lineDash) => new S.Stroke({ color, width, lineDash });
    const BASE_STYLES = {
        border: new S.Style({ stroke: stroke('#9a9a9a', 0.8) }),
        coast: new S.Style({ stroke: stroke('#7f8c96', 1) }),
        lake: new S.Style({ fill: new S.Fill({ color: '#a8d8f0' }), stroke: stroke('#5aa0d0', 0.8) }),
        river: new S.Style({ stroke: stroke('#4a7fd8', 1.3) })
    };
    const haloText = (opts) => new S.Text({
        stroke: stroke('#ffffff', 3),
        ...opts
    });

    // Below the indicator: borders and coast (the NUTS borders from QGIS take over inside Germany)
    const backgroundLayer = new ol.layer.Vector({
        source: basemapSource,
        zIndex: 0,
        style: (f) => BASE_STYLES[f.get('k')] && (f.get('k') === 'border' || f.get('k') === 'coast')
            ? BASE_STYLES[f.get('k')] : null
    });

    // Above the indicator: rivers and lakes, more of them as you zoom in
    const waterLayer = new ol.layer.Vector({
        source: basemapSource,
        zIndex: 900,
        declutter: 'water',
        style: (f, res) => {
            const k = f.get('k');
            if (k !== 'river' && k !== 'lake') return null;
            const zoom = webZoom(res);
            if (f.get('z') != null && zoom < f.get('z')) return null;
            if (k === 'lake' || !f.get('n') || zoom < (f.get('lz') || 99)) return BASE_STYLES[k];
            return [BASE_STYLES.river, new S.Style({
                text: haloText({
                    text: f.get('n'), placement: 'line', font: 'italic 11px sans-serif',
                    fill: new S.Fill({ color: '#2f5fb3' })
                })
            })];
        }
    });

    // On top of everything: main cities only, smaller ones appear when zooming in
    const cityDot = new S.Circle({
        radius: 3.5, fill: new S.Fill({ color: '#e00000' }), stroke: stroke('#ffffff', 1)
    });
    const labelsLayer = new ol.layer.Vector({
        source: basemapSource,
        zIndex: 1000,
        declutter: 'labels',
        style: (f, res) => {
            if (f.get('k') !== 'city' || webZoom(res) < f.get('z') - CITY_ZOOM_BIAS) return null;
            return new S.Style({
                image: cityDot,
                text: haloText({
                    text: f.get('n'), textAlign: 'left', offsetX: 6, offsetY: -6,
                    font: (f.get('cap') ? 'bold 13px' : 'bold 11px') + ' sans-serif',
                    fill: new S.Fill({ color: '#000000' })
                })
            });
        }
    });

    const map = new ol.Map({
        target: 'map',
        layers: [backgroundLayer, waterLayer, labelsLayer],
        view: new ol.View({
            projection: PROJECTION,
            center: ol.proj.fromLonLat([10.4, 51.1], PROJECTION),
            resolution: 1500,
            extent: VIEW_EXTENT
        })
    });
    $('labels-toggle').addEventListener('change', (e) => labelsLayer.setVisible(e.target.checked));
    $('water-toggle').addEventListener('change', (e) => waterLayer.setVisible(e.target.checked));

    // One map layer for the selected indicator; we only change its LAYERS parameter
    const themeLayer = new ol.layer.Tile({
        source: new ol.source.TileWMS({
            url: WMS_URL,
            params: { LAYERS: '', VERSION: WMS_VERSION, FORMAT: 'image/png', TRANSPARENT: true, STYLES: '' },
            transition: 0
        }),
        opacity: THEME_OPACITY,
        visible: false,
        zIndex: 1,
        className: 'theme-layer'     // own canvas, so the grid below is drawn only on this layer's cells
    });
    map.addLayer(themeLayer);

    // ---------- Grid cell outlines (like atlas.zensus2022.de) ----------
    // Thin lines on the census grid (multiples of 10 km / 1 km / 100 m in EPSG:3035), drawn onto the indicator
    // layer with "source-atop", so they appear only on cells that have data. The cell size follows the
    // resolution QGIS currently shows (layer name ends in _10km, _1km, _100m).
    const GRID_MIN_CELL_PX = 4;              // cells smaller than this on screen: no outlines (would be a grey blur)
    const GRID_COLOR = 'rgba(0, 0, 0, 0.5)';
    const cellSizeOf = (child) => {
        const m = /_(\d+)(km|m)$/.exec(child.Name);
        return m ? Number(m[1]) * (m[2] === 'km' ? 1000 : 1) : null;
    };

    themeLayer.on('postrender', (event) => {
        const child = $('grid-toggle').checked && activeChild(activeTheme);
        const cell = child && cellSizeOf(child);
        if (!cell || cell / event.frameState.viewState.resolution < GRID_MIN_CELL_PX) return;

        const [minX, minY, maxX, maxY] = event.frameState.extent;
        const px = (x, y) => ol.render.getRenderPixel(event, map.getPixelFromCoordinate([x, y]))
            .map((v) => Math.round(v) + 0.5);    // on pixel centres -> crisp 1 px lines
        const ctx = event.context;
        ctx.save();
        ctx.globalCompositeOperation = 'source-atop';
        ctx.strokeStyle = GRID_COLOR;
        ctx.lineWidth = 1;
        ctx.beginPath();
        for (let x = Math.ceil(minX / cell) * cell; x <= maxX; x += cell) {
            ctx.moveTo(...px(x, minY)); ctx.lineTo(...px(x, maxY));
        }
        for (let y = Math.ceil(minY / cell) * cell; y <= maxY; y += cell) {
            ctx.moveTo(...px(minX, y)); ctx.lineTo(...px(maxX, y));
        }
        ctx.stroke();
        ctx.restore();
    });
    $('grid-toggle').addEventListener('change', () => map.render());

    const popup = new ol.Overlay({
        element: $('popup'),
        positioning: 'bottom-center',
        offset: [0, -12],
        autoPan: { animation: { duration: 200 } }
    });
    map.addOverlay(popup);
    $('popup-close').addEventListener('click', () => popup.setPosition(undefined));
    $('meta-close').addEventListener('click', () => $('meta-dialog').close());

    // Panel toggle (starts closed on small screens)
    const app = $('app');
    if (window.matchMedia('(max-width: 700px)').matches) app.classList.add('is-collapsed');
    $('sidebar-toggle').addEventListener('click', () => {
        app.classList.toggle('is-collapsed');
        setTimeout(() => map.updateSize(), 220);
    });

    init();

    // ---------- 1. GetCapabilities ----------
    async function init() {
        setStatus('Loading layers…');
        try {
            const res = await fetch(wmsUrl({ REQUEST: 'GetCapabilities' }));
            if (!res.ok) {
                // our proxy (gis.ashx) explains configuration problems in plain text
                const isText = (res.headers.get('content-type') || '').startsWith('text/plain');
                throw new Error('HTTP ' + res.status + (isText ? ': ' + (await res.text()).slice(0, 200) : ''));
            }
            const caps = new ol.format.WMSCapabilities().read(await res.text());
            buildFromCapabilities(caps);
            setStatus('');
        } catch (err) {
            console.error(err);
            setStatus('Could not load the map service (' + err.message + '). Is QGIS Server running?', true);
        }
    }

    function buildFromCapabilities(caps) {
        const root = caps.Capability.Layer;
        $('service-title').textContent = caps.Service.Title || root.Title || 'Map';
        $('service-abstract').textContent = caps.Service.Abstract || '';

        (root.Layer || []).forEach((node) => {
            if (isThemeCollection(node)) renderThemeCollection(node);
            else if (isTheme(node)) renderThemeCollection({ Layer: [node] });
            else $('layer-tree').appendChild(renderNode(node));
        });

        // Boundaries above the indicator; top of the list is drawn on top
        const all = [...vectorLayers.values()];
        all.forEach(({ olLayer }, i) => olLayer.setZIndex(2 + all.length - i));

        if (themes.size) selectTheme(themes.keys().next().value);   // first indicator on by default
        if (root.EX_GeographicBoundingBox) zoomTo(root.EX_GeographicBoundingBox, 0);
        updateScaleState();
        updateLegend();
    }

    // ---------- 2. Indicators (one at a time) ----------
    function renderThemeCollection(collection) {
        const list = $('theme-list');
        if (!list.children.length) list.appendChild(themeRow(null, 'None'));
        collection.Layer.forEach((g) => list.appendChild(themeRow(g)));
    }

    function themeRow(info, label) {
        const li = el('li');
        li.className = 'theme';
        li.innerHTML = `
      <div class="layer__row">
        <label class="layer__label"><input type="radio" name="theme"><span></span></label>
      </div>
      <p class="theme__res muted" hidden></p>`;
        li.querySelector('span').textContent = label || info.Title || info.Name;
        const radio = li.querySelector('input');
        radio.value = info ? info.Name : '';
        radio.addEventListener('change', () => selectTheme(radio.value || null));

        if (info) {
            const btn = el('button', 'i');
            btn.type = 'button';
            btn.className = 'icon-btn';
            btn.title = btn.ariaLabel = 'Layer information';
            btn.addEventListener('click', () => showMetadata(info, info.Layer));
            li.querySelector('.layer__row').appendChild(btn);
            themes.set(info.Name, { info, children: info.Layer, li });
        } else {
            radio.checked = true;
        }
        return li;
    }

    function selectTheme(name) {
        activeTheme = name ? themes.get(name) : null;
        themeLayer.getSource().updateParams({ LAYERS: name || '' });
        themeLayer.setVisible(!!name);
        document.querySelectorAll('#theme-list input[name=theme]')
            .forEach((r) => { r.checked = r.value === (name || ''); });
        $('theme-opacity').hidden = !name;
        updateScaleState();
        updateLegend();
    }

    $('theme-opacity-input').value = THEME_OPACITY * 100;
    $('theme-opacity-input').addEventListener('input', (e) => themeLayer.setOpacity(e.target.value / 100));

    // Which resolution (child layer) QGIS draws at the current zoom
    function activeChild(theme) {
        return theme && (theme.children.find((c) => !isOutOfScale(c)) || null);
    }

    // ---------- 3. Boundaries (on/off layers) ----------
    function renderNode(info) {
        const li = el('li');

        if (info.Layer && info.Layer.length) {
            li.className = 'tree__group';
            const title = el('label');
            title.className = 'tree__group-title';
            const cb = el('input');
            cb.type = 'checkbox';
            cb.checked = true;
            cb.addEventListener('change', () => {
                li.querySelectorAll('input.layer-toggle').forEach((c) => {
                    c.checked = cb.checked;
                    c.dispatchEvent(new Event('change'));
                });
            });
            title.append(cb, el('span', info.Title || info.Name));
            const ul = el('ul');
            info.Layer.forEach((child) => ul.appendChild(renderNode(child)));
            li.append(title, ul);
            return li;
        }

        const olLayer = new ol.layer.Tile({
            source: new ol.source.TileWMS({
                url: WMS_URL,
                params: { LAYERS: info.Name, VERSION: WMS_VERSION, FORMAT: 'image/png', TRANSPARENT: true, STYLES: '' },
                transition: 0
            })
        });
        map.addLayer(olLayer);
        vectorLayers.set(info.Name, { olLayer, info, li });

        li.className = 'tree__layer';
        li.innerHTML = `
      <div class="layer__row">
        <label class="layer__label"><input type="checkbox" class="layer-toggle" checked><span></span></label>
        <button type="button" class="icon-btn" title="Layer information" aria-label="Layer information">i</button>
      </div>
      <div class="layer__opacity"><input type="range" min="0" max="100" value="100" aria-label="Opacity"></div>
      <p class="layer__hint muted" hidden>Zoom in to see this layer</p>`;
        li.querySelector('.layer__label span').textContent = info.Title || info.Name;
        li.querySelector('.layer-toggle').addEventListener('change', (e) => {
            olLayer.setVisible(e.target.checked);
            updateLegend();
        });
        li.querySelector('input[type=range]').addEventListener('input', (e) => olLayer.setOpacity(e.target.value / 100));
        li.querySelector('.icon-btn').addEventListener('click', () => showMetadata(info));
        return li;
    }

    // ---------- Zoom-dependent layers ----------
    // WMS: MaxScaleDenominator = most zoomed-out scale where a layer is drawn, MinScaleDenominator = most zoomed-in
    function currentScale() {
        return map.getView().getResolution() / OGC_PIXEL_SIZE;
    }
    function isOutOfScale(info) {
        const s = currentScale();
        return !!((info.MaxScaleDenominator && s > info.MaxScaleDenominator) ||
            (info.MinScaleDenominator && s < info.MinScaleDenominator));
    }
    function updateScaleState() {
        vectorLayers.forEach(({ info, li }) => {
            const out = isOutOfScale(info);
            li.classList.toggle('is-out-of-scale', out);
            li.querySelector('.layer__hint').hidden = !out;
        });
        themes.forEach((t) => { t.li.querySelector('.theme__res').hidden = true; });
        if (activeTheme) {
            const child = activeChild(activeTheme);
            const p = activeTheme.li.querySelector('.theme__res');
            p.textContent = child ? 'Showing: ' + resolutionLabel(child) + ' (changes with zoom)' : 'Not available at this zoom';
            p.hidden = false;
        }
    }
    map.getView().on('change:resolution', updateScaleState);

    // "Population – 1 km grid" -> "1 km grid";  fallback: the layer name suffix
    function resolutionLabel(child) {
        const t = child.Title || '';
        return t.includes('–') ? t.split('–').pop().trim() : child.Name.split('_').pop();
    }

    // ---------- 4a. Legend ----------
    function legendFigure(title, layerName) {
        const fig = el('figure');
        const img = new Image();
        img.alt = 'Legend for ' + title;
        img.loading = 'lazy';
        img.src = wmsUrl({
            REQUEST: 'GetLegendGraphic', LAYER: layerName, FORMAT: 'image/png',
            TRANSPARENT: 'true', LAYERTITLE: 'false'
        });
        fig.append(el('figcaption', title), img);
        return fig;
    }

    function updateLegend() {
        const box = $('legend');
        box.replaceChildren();
        if (activeTheme) {   // all resolutions share one legend, so the first child is enough
            box.appendChild(legendFigure(activeTheme.info.Title || activeTheme.info.Name, activeTheme.children[0].Name));
        }
        vectorLayers.forEach(({ olLayer, info }) => {
            if (olLayer.getVisible()) box.appendChild(legendFigure(info.Title || info.Name, info.Name));
        });
        if (!box.children.length) box.appendChild(el('p', 'No visible layers')).className = 'muted';
    }

    // ---------- Metadata card ----------
    function showMetadata(info, children) {
        const box = $('meta-content');
        box.replaceChildren(el('h3', info.Title || info.Name));

        const bbox = info.EX_GeographicBoundingBox || (children && children[0].EX_GeographicBoundingBox);
        const rows = [
            ['Description', info.Abstract],
            ['Keywords', (info.KeywordList || []).join(', ')],
            ['Resolutions', children && children.map(resolutionLabel).join(', ')],
            ['Layer name', info.Name],
            ['Extent (lon/lat)', bbox && bbox.map((v) => v.toFixed(2)).join(', ')],
            ['Visible from', !children && info.MaxScaleDenominator && '1:' + Math.round(info.MaxScaleDenominator).toLocaleString()],
            ['Attribution', info.Attribution && info.Attribution.Title]
        ].filter(([, value]) => value);

        const dl = el('dl');
        rows.forEach(([key, value]) => dl.append(el('dt', key), el('dd', value)));
        box.appendChild(dl);

        if (bbox) {
            const btn = el('button', 'Zoom to layer');
            btn.type = 'button';
            btn.className = 'btn';
            btn.style.marginRight = '8px';
            btn.addEventListener('click', () => { zoomTo(bbox); $('meta-dialog').close(); });
            box.appendChild(btn);
        }
        $('meta-dialog').showModal();
    }

    function zoomTo(lonLatBbox, duration = 300) {
        const extent = ol.proj.transformExtent(lonLatBbox, 'EPSG:4326', map.getView().getProjection());
        map.getView().fit(extent, { padding: [40, 40, 40, 40], duration });
    }

    // ---------- 4b. Click -> GetFeatureInfo ----------
    function featureInfoUrl(coordinate, names) {
        return themeLayer.getSource().getFeatureInfoUrl(coordinate, map.getView().getResolution(),
            map.getView().getProjection(), {
            INFO_FORMAT: 'application/json',
            LAYERS: names.join(','),
            QUERY_LAYERS: names.join(','),
            FEATURE_COUNT: 10,
            WITH_GEOMETRY: 'false',
            FI_POINT_TOLERANCE: 8,
            FI_LINE_TOLERANCE: 4,
            FI_POLYGON_TOLERANCE: 2
        });
    }

    async function getJson(url) {
        const res = await fetch(url);
        if (!res.ok) throw new Error('HTTP ' + res.status);
        return res.json();
    }

    map.on('singleclick', async (evt) => {
        const child = activeChild(activeTheme);
        const vectorNames = [...vectorLayers.values()]
            .filter(({ olLayer, info }) => olLayer.getVisible() && info.queryable && !isOutOfScale(info))
            .map(({ info }) => info.Name);
        if (!child && !vectorNames.length) return;

        const content = $('popup-content');
        content.replaceChildren(el('p', 'Loading…'));
        popup.setPosition(evt.coordinate);

        // Two requests in parallel: the indicator cell value, and the boundary features
        const [rasterRes, vectorRes] = await Promise.allSettled([
            child ? getJson(featureInfoUrl(evt.coordinate, [child.Name])) : null,
            vectorNames.length ? getJson(featureInfoUrl(evt.coordinate, vectorNames)) : null
        ]);

        content.replaceChildren();
        if (child && rasterRes.status === 'fulfilled') renderRasterValue(child, rasterRes.value);
        if (vectorRes.status === 'fulfilled' && vectorRes.value) renderFeatures(vectorRes.value.features || []);
        if (rasterRes.status === 'rejected' || vectorRes.status === 'rejected') {
            console.error(rasterRes.reason || vectorRes.reason);
        }
        if (!content.children.length) popup.setPosition(undefined);
    });

    // Raster answer: the first number in the first feature's properties is the cell value
    function renderRasterValue(child, data) {
        const f = data && (data.features || [])[0];
        let value = null;
        if (f && f.properties) {
            for (const v of Object.values(f.properties)) {
                const n = typeof v === 'number' ? v : parseFloat(String(v).replace(',', '.'));
                if (Number.isFinite(n) && n !== NODATA) { value = n; break; }
            }
        }
        const format = THEME_VALUE[activeTheme.info.Name] || ((v) => fmt(v));
        content().appendChild(el('h3', (activeTheme.info.Title || activeTheme.info.Name) + ' · ' + resolutionLabel(child)));
        content().appendChild(el('p', value === null ? 'No data for this cell' : format(value))).className = 'popup__value';
    }

    function renderFeatures(features) {
        features.forEach((f) => {
            // QGIS feature ids look like "nuts3.123" -> layer name before the dot
            const layerName = String(f.id || '').split('.')[0];
            const entry = vectorLayers.get(layerName);
            content().appendChild(el('h3', entry ? (entry.info.Title || layerName) : 'Feature'));

            const table = el('table');
            Object.entries(f.properties || {}).forEach(([key, value]) => {
                if (HIDDEN_FIELDS.includes(key) || value === null || value === '') return;
                const tr = el('tr');
                tr.append(el('th', FIELD_LABELS[key] || key), el('td', typeof value === 'number' ? fmt(value) : String(value)));
                table.appendChild(tr);
            });
            content().appendChild(table);
        });
    }

    function content() { return $('popup-content'); }

    // ---------- Status message ----------
    function setStatus(message, isError) {
        const s = $('status');
        s.textContent = message;
        s.hidden = !message;
        s.classList.toggle('is-error', !!isError);
    }
})();