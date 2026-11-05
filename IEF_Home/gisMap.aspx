<%@ Page Title="Map" Language="C#" MasterPageFile="~/Site1.Master" %>
<script runat="server">
    protected string Versioned(string path)
    {
        var stamp = System.IO.File.GetLastWriteTimeUtc(Server.MapPath(path)).Ticks;
        return ResolveUrl(path) + "?v=" + stamp;
    }
</script>
<asp:Content ID="MapContent" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">

    <!-- OpenLayers (map library) -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/ol@10.2.1/ol.css" />
    <script src="https://cdn.jsdelivr.net/npm/ol@10.2.1/dist/ol.js"></script>

    <!-- Our map code (?v= changes when the file changes, so browsers never use an old cached copy) -->
    <link rel="stylesheet" href="<%= Versioned("~/css/gisMap.css") %>" />
    <script src="<%= Versioned("~/js/gisMap.js") %>" defer></script>

    <div class="app" id="app">

        <!-- Left panel: service info, layers, legend -->
        <aside class="sidebar" id="sidebar">
            <header class="sidebar__header">
                <h1 id="service-title">Map</h1>
                <p id="service-abstract" class="muted"></p>
            </header>

            <section class="sidebar__section">
                <h2>Data</h2>
                <ul id="theme-list" class="tree"></ul>
                <div id="theme-opacity" class="layer__opacity" hidden>
                    <input id="theme-opacity-input" type="range" min="0" max="100" aria-label="Indicator opacity" />
                </div>
            </section>

            <section class="sidebar__section">
                <h2>Boundaries</h2>
                <ul id="layer-tree" class="tree"></ul>
            </section>

            <section class="sidebar__section">
                <h2>Basemap</h2>
                <label class="layer__label">
                    <input type="checkbox" id="labels-toggle" checked /><span>City names</span>
                </label>
                <label class="layer__label">
                    <input type="checkbox" id="water-toggle" checked /><span>Rivers &amp; lakes</span>
                </label>
            </section>

            <section class="sidebar__section">
                <h2>Legend</h2>
                <div id="legend" class="legend"></div>
            </section>
        </aside>

        <!-- Map area -->
        <main class="map-wrap">
            <button id="sidebar-toggle" class="sidebar-toggle" type="button" aria-label="Show or hide panel">&#9776;</button>
            <div id="map" class="map"></div>
            <div id="status" class="status" hidden></div>

            <!-- Click popup (positioned by OpenLayers) -->
            <div id="popup" class="popup">
                <button id="popup-close" class="popup__close" type="button" aria-label="Close">&times;</button>
                <div id="popup-content"></div>
            </div>
        </main>
    </div>

    <!-- Metadata card -->
    <dialog id="meta-dialog" class="dialog">
        <div id="meta-content"></div>
        <button type="button" id="meta-close" class="btn btn--ghost">Close</button>
    </dialog>

</asp:Content>