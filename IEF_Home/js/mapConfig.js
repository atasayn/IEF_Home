document.addEventListener("DOMContentLoaded", function () {
    var idValue = "svgMap-map-country-DE";
    var lastHoveredCountry = "de";

    new svgMap({
        targetElementID: 'svgMap',
        noDataText: "",
        initialZoom: 1.1,
        initialPan: { x: 400, y: 0 },
        data: {
            data: {
                value: {
                    name: "Value",
                    format: "{0}",
                    thousandSeparator: ",",
                    thresholdMax: 100,
                    thresholdMin: 0
                }
            },
            applyData: "value",
            values: { DE: { value: 1 } }
        },
        onGetTooltip: function (tooltipDiv, countryID, countryValues) {
            // do NOT return tooltipDiv
        }
    });

    // ---------------------------------------------------------------
    // MOUSEMOVE + elementFromPoint — this combo works in Chrome
    // elementFromPoint on mousemove correctly finds country paths,
    // so we store the result and use it when click fires
    // ---------------------------------------------------------------
    document.getElementById('svgMap').addEventListener('mousemove', function (e) {
        var el = document.elementFromPoint(e.clientX, e.clientY);
        var target = el;
        var hoveredCountry = null;
        while (target) {
            if (target.id && target.id.startsWith('svgMap-map-country-')) {
                hoveredCountry = target.id.replace('svgMap-map-country-', '').toLowerCase();
                break;
            }
            target = target.parentElement;
        }
        lastHoveredCountry = hoveredCountry;
    }, true);

    // ---------------------------------------------------------------
    // CLICK HANDLER — uses lastHoveredCountry set by mousemove above
    // ---------------------------------------------------------------
    document.getElementById('svgMap').addEventListener('mousedown', function (e) {
        if (lastHoveredCountry) {
            handleCountryClick(lastHoveredCountry);
        }
    }, true);

    // ---------------------------------------------------------------
    // ALL COUNTRY CLICK LOGIC
    // ---------------------------------------------------------------
    function handleCountryClick(countryID) {

        var url = [];

        // Highlight the selected country
        var newIdValue = "svgMap-map-country-" + countryID.toUpperCase();
        var prevEl = document.getElementById(idValue);
        if (prevEl) prevEl.classList.remove('svgMap-selected');
        idValue = newIdValue;
        var newEl = document.getElementById(idValue);
        if (newEl) newEl.classList.add('svgMap-selected');

        // Reset steel/GHG value spans
        function removeBoldTags(container) {
            var boldTags = container.getElementsByTagName("b");
            while (boldTags.length > 0) {
                boldTags[0].parentNode.removeChild(boldTags[0]);
            }
        }
        removeBoldTags(document.getElementById("steelUpperValue"));
        removeBoldTags(document.getElementById("GhGUpperValue"));
        removeBoldTags(document.getElementById("steelLowerValue"));
        removeBoldTags(document.getElementById("GhGLowerValue"));

        document.getElementById("proxyWarning").innerHTML = "";

        // Fetch JSON for ISO codes
        fetch("json/countryProxy.json")
            .then(response => response.json())
            .then(function (response) {
                var countryInfoCountryName = document.getElementById("countryInfoCountryName");
                var warningDisplay = document.getElementById("warningDisplay");
                var proxyNameEl = document.getElementById("proxyName");
                var findFlagAndData = response.find(obj => obj.ISO === countryID.toUpperCase());
                var name = svgMap.prototype.countries[countryID.toUpperCase()];

                if (findFlagAndData.Flag == true) {
                    document.getElementById("countryFlagSpan").innerHTML = name + " (" + findFlagAndData.Data + ")";
                    document.getElementById("countryFlagSpanLower").innerHTML = document.getElementById("countryFlagSpan").innerHTML;
                    var region = findFlagAndData.Data;
                    document.getElementById("proxyWarning").innerHTML =
                        "Sorry, no data for <span style='color:#ba1a1a'>" + name +
                        "</span>, here, the data for the proxy region<span style='color:green'> " +
                        findFlagAndData.Data + "</span> are shown";
                    countryInfoCountryName.innerHTML = name;
                    proxyNameEl.innerHTML = "Proxy name: " + findFlagAndData.Data;
                    warningDisplay.style.display = "block";
                    return { region: region, findFlagAndDataPNG: findFlagAndData.Png };
                } else {
                    document.getElementById("countryFlagSpan").innerHTML = name;
                    document.getElementById("countryFlagSpanLower").innerHTML = name;
                    countryInfoCountryName.innerHTML = name;
                    proxyNameEl.innerHTML = "";
                    warningDisplay.style.display = "none";
                    return { region: findFlagAndData.Data, findFlagAndDataPNG: findFlagAndData.Png };
                }
            })
            .then(function (regionObj) {
                var mapArea = document.getElementById("mapArea");
                mapArea.style.filter = "blur(8px)";
                mapArea.style.pointerEvents = "none";

                var imgElement = document.getElementById("singleCountryImg");
                var imgElementLower = document.getElementById("singleCountryImgLower");
                var energyServicePNG = document.getElementById("energyServiceCascadePNG");
                var decouplingService = document.getElementById("ecdDecouplingPNG");

                var region = regionObj.region;
                var findFlagAndDataPNG = regionObj.findFlagAndDataPNG;

                imgElement.src = "resources/countryFlags/" + countryID + ".png";
                imgElementLower.src = imgElement.src;

                const url1 = "https://api.worldbank.org/v2/country/" + countryID + "/indicators/SP.POP.TOTL?format=json";
                const url2 = "https://api.worldbank.org/v2/country/" + countryID + "/indicators/NY.GDP.PCAP.CD?format=json";
                const url3 = "https://api.worldbank.org/v2/country/" + countryID + "/indicators/EN.POP.DNST?format=json";
                url.push(url1, url2, url3);
                var popSpan = document.getElementById("population");
                var gdpSpan = document.getElementById("gdp");
                var populationDensitySpan = document.getElementById("populationDensity");
                url.forEach(el => fetchCountryData(el, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3));

                var scenario = "SSP2";
                var startYear = 2020;
                var endYear = 2060;
                var sectorTemp = $('#DropDownListSector').val();
                var material = $('#DropDownListMaterial').val();

                if (region == "R32CHN" && sectorTemp == "Residential building") {
                    $('#ChinaTeaser').css('display', 'grid');
                } else {
                    $('#ChinaTeaser').css('display', 'none');
                }

                if (sectorTemp == "Residential building") {
                    energyServicePNG.src = "Content/ReccPlots/" + findFlagAndDataPNG;
                    decouplingService.src = "Content/ReccPlots/ECD_Decoupling_Overview.png";
                } else {
                    energyServicePNG.src = "";
                    decouplingService.src = "";
                }

                $('.loader2').css("display", "block");
                fetch("circomodService.svc/Classification_ResultItemPopulation", {
                    method: "POST",
                    headers: { "Content-Type": "application/json; charset=utf-8" },
                    body: JSON.stringify({ SELECTedRegion: region }),
                })
                    .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
                    .then(result => { $('.loader2').hide(); if (region !== "") displayGraph(result.d, "line-plot2", "Total Population by scenario (million)", "Total Population"); })
                    .catch(err => console.error(err));

                $('.loader4').css("display", "block");
                fetch("circomodService.svc/Classification_ResultAreaStacked", {
                    method: "POST",
                    headers: { "Content-Type": "application/json; charset=utf-8" },
                    body: JSON.stringify({ selectedRegion: region, selectedSector: sectorTemp }),
                })
                    .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
                    .then(result => { $('.loader4').hide(); if (region !== "") stackedAreaChart(result, "line-plot4", region, sectorTemp); })
                    .catch(err => console.error(err));

                $('.loader3').css("display", "block");
                fetch("circomodService.svc/Classification_Result1stAnd2ndProd", {
                    method: "POST",
                    headers: { "Content-Type": "application/json; charset=utf-8" },
                    body: JSON.stringify({ selectedRegion: region, selectedSector: sectorTemp, selectedMaterial: material }),
                })
                    .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
                    .then(result => {
                        $('.loader3').hide();
                        if (region !== "") {
                            barChart(result, "line-plot3", region, sectorTemp, material);
                            mapArea.style.filter = "none";
                            mapArea.style.pointerEvents = "auto";
                        }
                    })
                    .catch(err => console.error(err));

                $('.loader5').css("display", "block");
                fetch("circomodService.svc/Classification_ResultGHG", {
                    method: "POST",
                    headers: { "Content-Type": "application/json; charset=utf-8" },
                    body: JSON.stringify({ selectedRegion: region, selectedSector: sectorTemp }),
                })
                    .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
                    .then(result => { $('.loader5').hide(); if (region !== "") ghgChart(result, "line-plot5", region, sectorTemp); })
                    .catch(err => console.error(err));

                var canvasElement = document.getElementById("NoDataline-plot1");
                var countriesAvailable = ["France", "Germany", "Italy", "Spain", "UK", "Poland", "Oth_R32EU15", "Oth_R32EU12-H", "R32EU12-M"];

                if (sectorTemp == "Residential building" && countriesAvailable.includes(region)) {
                    canvasElement.style.display = "none";
                    $('.loader1').css("display", "block");
                    fetch("circomodService.svc/Classification_ResultItemBuildingRes", {
                        method: "POST",
                        headers: { "Content-Type": "application/json; charset=utf-8" },
                        body: JSON.stringify({ selectedRegion: region }),
                    })
                        .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
                        .then(result => { $('.loader1').hide(); if (region !== "") displayGraph(result.d, "line-plot1", "Per Capita Service Level", "m2/cap"); })
                        .catch(err => console.error(err));

                } else if (sectorTemp == "Passenger vehicles") {
                    $('.loader1').css("display", "block");
                    fetch("circomodService.svc/Classification_ResultItem", {
                        method: "POST",
                        headers: { "Content-Type": "application/json; charset=utf-8" },
                        body: JSON.stringify({ SELECTedRegion: region }),
                    })
                        .then(r => r.json())
                        .then(result => { document.querySelector('.loader1').style.display = 'none'; if (region !== "") displayGraph(result.d, "line-plot1", "Per Capita Service Level", "Annual pkm by passenger cars"); })
                        .catch(err => console.error(err));

                } else {
                    const existingChart = Chart.getChart("line-plot1");
                    if (existingChart) existingChart.destroy();
                    canvasElement.style.display = "flex";
                }

                document.getElementById('sankeyDivsAll').innerHTML = "";
                document.getElementById('sankeyDivsAllFullCE').innerHTML = "";
                document.getElementById("scenerioSpan").innerHTML = scenario;
                document.getElementById("sectorSpan").innerHTML = "Steel";
                document.getElementById("yearSpan").innerHTML = startYear + "-" + endYear;
                document.getElementById("strategySpan").innerHTML = "Baseline";
                document.getElementById("materialSpan").innerHTML = material;

                if (document.getElementById("sankeyDivsAll").style.display === "")
                    document.getElementById("sankeyDivsAll").style.display = 'block';

                var sankeyDiv = document.getElementById("sankeyDivsAll");

                for (let year = startYear; year <= endYear; year += 10) {

                    var buttonDiv = document.createElement("div");
                    buttonDiv.style.position = "absolute";
                    var previousLink = document.createElement("button");
                    previousLink.className = "button"; previousLink.type = "button";
                    previousLink.textContent = ">>"; previousLink.setAttribute("onclick", "navigateFront()");
                    var nextLink = document.createElement("button");
                    nextLink.className = "button"; nextLink.type = "button";
                    nextLink.textContent = "<<"; nextLink.setAttribute("onclick", "navigateBack()");
                    buttonDiv.appendChild(previousLink);
                    buttonDiv.appendChild(nextLink);

                    var newDiv = document.createElement("div");
                    newDiv.id = "div_svg" + year; newDiv.style.position = 'absolute';
                    var chartParagraph = document.createElement("p");
                    chartParagraph.id = "chart" + year;
                    newDiv.appendChild(chartParagraph);
                    sankeyDiv.appendChild(newDiv);

                    var spanDiv = document.createElement("div");
                    var newSpan = document.createElement("span");
                    newSpan.id = "span_svg" + year; newSpan.innerHTML = "SSP2-" + year;
                    newSpan.style.position = "absolute"; newSpan.style.bottom = 0;
                    spanDiv.appendChild(newSpan);
                    sankeyDiv.appendChild(spanDiv);

                    newDiv.style.visibility = (newDiv.id === "div_svg" + startYear) ? "visible" : "hidden";
                    newSpan.style.visibility = (newSpan.id === "span_svg" + startYear) ? "visible" : "hidden";

                    const svgEl = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                    svgEl.setAttribute("id", "target_svg" + year);
                    chartParagraph.appendChild(svgEl);

                    let divId = "target_svg" + year;
                    let divSvg = newDiv.id;
                    let divChart = chartParagraph.id;

                    $('.loader').css("display", "block");
                    fetch("circomodService.svc/Classification_SankeyItem", {
                        method: "POST",
                        headers: { "Content-Type": "application/json; charset=utf-8" },
                        body: JSON.stringify({
                            SELECTedRegion: region, SELECTedScenario: "SSP2",
                            SELECTedSector: sectorTemp, SELECTedYear: year,
                            SELECTedStrategy: "Baseline", SELECTedMaterial: "steel"
                        }),
                    })
                        .then(r => r.json())
                        .then(data => {
                            $('.loader').hide();
                            var res = new Map(data["d"].map(obj => [obj.Key, obj.Value.replace(",", ".")]));
                            var flowarea = $("#input_flow_data").val();
                            var text = flowarea;
                            text = text.replace("F_a", res.get("query_Fa"));
                            text = text.replace("F_b", Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh"))));
                            var container = document.getElementById('steelUpperValue');
                            var Fb = Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh")));
                            var spans = "<b><span id='steelUpper_span" + year + "' style='display:none'>" + parseFloat(Fb.toFixed(1)) + " Mt/yr</span></b>";
                            if (year == startYear) spans = spans.replace("display:none", "display:block");
                            container.innerHTML += spans;
                            text = text.replace("F_c", res.get("query_Fc"));
                            text = text.replace("F_d", res.get("query_Fc"));
                            text = text.replace("F_e", res.get("query_Fc"));
                            text = text.replace("F_f", res.get("query_Ff"));
                            text = text.replace("F_g", Math.abs(parseFloat(res.get("query_Ff")) - parseFloat(res.get("query_Fh"))));
                            text = text.replace("F_h", res.get("query_Fh"));
                            text = text.replace("F_i", res.get("query_Fh"));
                            text = text.replace("F_j", res.get("query_Fh"));
                            text = text.replace("F_k", res.get("query_Fk") / 50);
                            text = text.replace("F_l", res.get("query_Fl") / 50);
                            text = text.replace("F_m", res.get("query_Fm") / 50);
                            var ghgContainer = document.getElementById('GhGUpperValue');
                            var Fm = res.get("query_Fm") / 50;
                            var ghgSpans = "<b><span id='ghgUpper_span" + year + "' style='display:none'>" + parseFloat(Fm.toFixed(1)) + " Mt/yr</span></b>";
                            if (year == startYear) ghgSpans = ghgSpans.replace("display:none", "display:block");
                            ghgContainer.innerHTML += ghgSpans;
                            text = text.replace("F_n", res.get("query_Fn"));
                            text = text.replace("F_o", res.get("query_Fn"));
                            text = text.replace("F_p", res.get("query_Fn"));
                            $("#input_flow_data").val(text);
                            process_sankey(divId, divSvg, divChart);
                            $("#input_flow_data").val(flowarea);
                        })
                        .catch(err => console.error(err));

                    sankeyDiv.appendChild(buttonDiv);

                    document.getElementById("scenerioSpanLower").innerHTML = "LED";
                    document.getElementById("sectorSpanLower").innerHTML = "Steel";
                    document.getElementById("yearSpanLower").innerHTML = startYear + "-" + endYear;
                    document.getElementById("strategySpanLower").innerHTML = "Full CE";
                    document.getElementById("materialSpanLower").innerHTML = material;

                    if (document.getElementById("sankeyDivsAllFullCE").style.display === "")
                        document.getElementById("sankeyDivsAllFullCE").style.display = 'block';

                    var sankeyDivLower = document.getElementById("sankeyDivsAllFullCE");

                    var buttonDivLower = document.createElement("div");
                    buttonDivLower.style.position = "absolute";
                    var prevLinkLower = document.createElement("button");
                    prevLinkLower.className = "button"; prevLinkLower.type = "button";
                    prevLinkLower.textContent = ">>"; prevLinkLower.setAttribute("onclick", "navigateFrontLower()");
                    var nextLinkLower = document.createElement("button");
                    nextLinkLower.className = "button"; nextLinkLower.type = "button";
                    nextLinkLower.textContent = "<<"; nextLinkLower.setAttribute("onclick", "navigateBackLower()");
                    buttonDivLower.appendChild(prevLinkLower);
                    buttonDivLower.appendChild(nextLinkLower);

                    var newDivLower = document.createElement("div");
                    newDivLower.id = "Lowerdiv_svg" + year; newDivLower.style.position = 'absolute';
                    var chartParagraphLower = document.createElement("p");
                    chartParagraphLower.id = "Lowerchart" + year;
                    newDivLower.appendChild(chartParagraphLower);
                    sankeyDivLower.appendChild(newDivLower);

                    var spanDivLower = document.createElement("div");
                    var newSpanLower = document.createElement("span");
                    newSpanLower.id = "Lowerspan_svg" + year; newSpanLower.innerHTML = "LED-" + year;
                    newSpanLower.style.position = "absolute"; newSpanLower.style.bottom = 0;
                    spanDivLower.appendChild(newSpanLower);
                    sankeyDivLower.appendChild(spanDivLower);

                    newDivLower.style.visibility = (newDivLower.id === "Lowerdiv_svg" + startYear) ? "visible" : "hidden";
                    newSpanLower.style.visibility = (newSpanLower.id === "Lowerspan_svg" + startYear) ? "visible" : "hidden";

                    const svgElLower = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                    svgElLower.setAttribute("id", "Lowertarget_svg" + year);
                    chartParagraphLower.appendChild(svgElLower);

                    let divIdLower = "Lowertarget_svg" + year;
                    let divSvgLower = newDivLower.id;
                    let divChartLower = chartParagraphLower.id;

                    $('.loader6').css("display", "block");
                    fetch("circomodService.svc/Classification_SankeyItem", {
                        method: "POST",
                        headers: { "Content-Type": "application/json; charset=utf-8" },
                        body: JSON.stringify({
                            SELECTedRegion: region, SELECTedScenario: "LED",
                            SELECTedSector: sectorTemp, SELECTedYear: year,
                            SELECTedStrategy: "Full CE", SELECTedMaterial: "steel"
                        }),
                    })
                        .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
                        .then(data => {
                            $('.loader6').hide();
                            var res = new Map(data.d.map(obj => [obj.Key, obj.Value.replace(",", ".")]));
                            var flowarea = $("#input_flow_data").val();
                            var text = flowarea;
                            text = text.replace("F_a", res.get("query_Fa"));
                            text = text.replace("F_b", Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh"))));
                            var containerLower = document.getElementById('steelLowerValue');
                            var FbLower = Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh")));
                            var spansLower = "<b><span id='steelLower_span" + year + "' style='display:none'>" + parseFloat(FbLower.toFixed(1)) + " Mt/yr</span></b>";
                            if (year == startYear) spansLower = spansLower.replace("display:none", "display:block");
                            containerLower.innerHTML += spansLower;
                            text = text.replace("F_c", res.get("query_Fc"));
                            text = text.replace("F_d", res.get("query_Fc"));
                            text = text.replace("F_e", res.get("query_Fc"));
                            text = text.replace("F_f", res.get("query_Ff"));
                            text = text.replace("F_g", Math.abs(parseFloat(res.get("query_Ff")) - parseFloat(res.get("query_Fh"))));
                            text = text.replace("F_h", res.get("query_Fh"));
                            text = text.replace("F_i", res.get("query_Fh"));
                            text = text.replace("F_j", res.get("query_Fh"));
                            text = text.replace("F_k", res.get("query_Fk") / 50);
                            text = text.replace("F_l", res.get("query_Fl") / 50);
                            text = text.replace("F_m", res.get("query_Fm") / 50);
                            var ghgContainerLower = document.getElementById('GhGLowerValue');
                            var FmLower = res.get("query_Fm") / 50;
                            var ghgSpansLower = "<b><span id='ghgLower_span" + year + "' style='display:none'>" + parseFloat(FmLower.toFixed(1)) + " Mt/yr</span></b>";
                            if (year == startYear) ghgSpansLower = ghgSpansLower.replace("display:none", "display:block");
                            ghgContainerLower.innerHTML += ghgSpansLower;
                            text = text.replace("F_n", res.get("query_Fn"));
                            text = text.replace("F_o", res.get("query_Fn"));
                            text = text.replace("F_p", res.get("query_Fn"));
                            $("#input_flow_data").val(text);
                            process_sankey(divIdLower, divSvgLower, divChartLower);
                            $("#input_flow_data").val(flowarea);
                        })
                        .catch(err => console.error(err));

                    sankeyDivLower.appendChild(buttonDivLower);
                }
            });
    }
});

// ---------------------------------------------------------------
// WINDOW LOAD — default Germany on page load
// ---------------------------------------------------------------
$(window).on('load', function () {

    var countryInfoCountryName = document.getElementById("countryInfoCountryName");

    fetch("json/countryProxy.json")
        .then(response => response.json())
        .then(function (response) {
            var findFlagAndData = response.find(obj => obj.ISO === "DE");
            document.getElementById("energyServiceCascadePNG").src = "Content/ReccPlots/" + findFlagAndData.Png;
            document.getElementById("ecdDecouplingPNG").src = "Content/ReccPlots/ECD_Decoupling_Overview.png";
        });

    var region = "Germany";
    var scenario = "SSP2";
    var sector = "Residential building";
    var startYear = 2020;
    var endYear = 2030;
    var strategy = "Baseline";
    var material = "steel";
    var countryCode = "de";

    countryInfoCountryName.innerHTML = region;

    $('.loader2').css("display", "block");
    fetch("circomodService.svc/Classification_ResultItemPopulation", {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify({ SELECTedRegion: region }),
    })
        .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
        .then(result => { $('.loader2').hide(); if (region !== "") displayGraph(result.d, "line-plot2", "Total Population by scenario (million)", "Total Population"); })
        .catch(err => console.error(err));

    $('.loader1').css("display", "block");
    fetch("circomodService.svc/Classification_ResultItemBuildingRes", {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify({ selectedRegion: region }),
    })
        .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
        .then(result => { $('.loader1').hide(); if (region !== "") displayGraph(result.d, "line-plot1", "Per Capita Service Level", "m2/cap"); })
        .catch(err => console.error(err));

    $('.loader3').css("display", "block");
    fetch("circomodService.svc/Classification_Result1stAnd2ndProd", {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify({ selectedRegion: region, selectedSector: sector, selectedMaterial: material }),
    })
        .then(r => r.json())
        .then(result => { document.querySelector('.loader3').style.display = 'none'; if (region !== "") barChart(result, "line-plot3", region, sector, material); });

    $('.loader4').css("display", "block");
    fetch("circomodService.svc/Classification_ResultAreaStacked", {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify({ selectedRegion: region, selectedSector: sector }),
    })
        .then(r => r.json())
        .then(result => { document.querySelector('.loader4').style.display = 'none'; if (region !== "") stackedAreaChart(result, "line-plot4", region, sector); });

    $('.loader5').css("display", "block");
    fetch("circomodService.svc/Classification_ResultGHG", {
        method: "POST",
        headers: { "Content-Type": "application/json; charset=utf-8" },
        body: JSON.stringify({ selectedRegion: region, selectedSector: sector }),
    })
        .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
        .then(result => { $('.loader5').hide(); if (region !== "") ghgChart(result, 'line-plot5', region, sector); })
        .catch(err => console.error(err));

    document.getElementById("scenerioSpan").innerHTML = scenario;
    document.getElementById("sectorSpan").innerHTML = sector;
    document.getElementById("yearSpan").innerHTML = startYear + "-" + endYear;
    document.getElementById("strategySpan").innerHTML = strategy;
    document.getElementById("materialSpan").innerHTML = material;

    if (document.getElementById("sankeyDivsAll").style.display === "")
        document.getElementById("sankeyDivsAll").style.display = 'block';

    var sankeyDiv = document.getElementById("sankeyDivsAll");

    for (let year = startYear; year <= endYear; year += 10) {

        var buttonDiv = document.createElement("div");
        buttonDiv.style.position = "absolute";
        var previousLink = document.createElement("button");
        previousLink.className = "button"; previousLink.type = "button";
        previousLink.textContent = ">>"; previousLink.setAttribute("onclick", "navigateFront()");
        var nextLink = document.createElement("button");
        nextLink.className = "button"; nextLink.type = "button";
        nextLink.textContent = "<<"; nextLink.setAttribute("onclick", "navigateBack()");
        buttonDiv.appendChild(previousLink);
        buttonDiv.appendChild(nextLink);

        var newDiv = document.createElement("div");
        newDiv.id = "div_svg" + year; newDiv.style.position = 'absolute';
        var chartParagraph = document.createElement("p");
        chartParagraph.id = "chart" + year;
        newDiv.appendChild(chartParagraph);
        sankeyDiv.appendChild(newDiv);

        var spanDiv = document.createElement("div");
        var newSpan = document.createElement("span");
        newSpan.id = "span_svg" + year; newSpan.innerHTML = "SSP2-" + year;
        newSpan.style.position = "absolute"; newSpan.style.bottom = 0;
        spanDiv.appendChild(newSpan);
        sankeyDiv.appendChild(spanDiv);

        newDiv.style.visibility = (newDiv.id === "div_svg" + startYear) ? "visible" : "hidden";
        newSpan.style.visibility = (newSpan.id === "span_svg" + startYear) ? "visible" : "hidden";

        const svgEl = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svgEl.setAttribute("id", "target_svg" + year);
        chartParagraph.appendChild(svgEl);

        let divId = "target_svg" + year;
        let divSvg = newDiv.id;
        let divChart = chartParagraph.id;

        $('.loader').css("display", "block");
        fetch("circomodService.svc/Classification_SankeyItem", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({
                SELECTedRegion: region, SELECTedScenario: scenario,
                SELECTedSector: sector, SELECTedYear: year,
                SELECTedStrategy: strategy, SELECTedMaterial: material
            }),
        })
            .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
            .then(data => {
                $('.loader').hide();
                var res = new Map(data.d.map(obj => [obj.Key, obj.Value.replace(",", ".")]));
                var flowarea = $("#input_flow_data").val();
                var text = flowarea;
                text = text.replace("F_a", res.get("query_Fa"));
                text = text.replace("F_b", Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh"))));
                var container = document.getElementById('steelUpperValue');
                var Fb = Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh")));
                var spans = "<b><span id='steelUpper_span" + year + "' style='display:none'>" + parseFloat(Fb.toFixed(1)) + " Mt/yr</span></b>";
                if (year == startYear) spans = spans.replace("display:none", "display:block");
                container.innerHTML += spans;
                text = text.replace("F_c", res.get("query_Fc"));
                text = text.replace("F_d", res.get("query_Fc"));
                text = text.replace("F_e", res.get("query_Fc"));
                text = text.replace("F_f", res.get("query_Ff"));
                text = text.replace("F_g", Math.abs(parseFloat(res.get("query_Ff")) - parseFloat(res.get("query_Fh"))));
                text = text.replace("F_h", res.get("query_Fh"));
                text = text.replace("F_i", res.get("query_Fh"));
                text = text.replace("F_j", res.get("query_Fh"));
                text = text.replace("F_k", res.get("query_Fk") / 50);
                text = text.replace("F_l", res.get("query_Fl") / 50);
                text = text.replace("F_m", res.get("query_Fm") / 50);
                var ghgContainer = document.getElementById('GhGUpperValue');
                var Fm = res.get("query_Fm") / 50;
                var ghgSpans = "<b><span id='ghgUpper_span" + year + "' style='display:none'>" + parseFloat(Fm.toFixed(1)) + " Mt/yr</span></b>";
                if (year == startYear) ghgSpans = ghgSpans.replace("display:none", "display:block");
                ghgContainer.innerHTML += ghgSpans;
                text = text.replace("F_n", res.get("query_Fn"));
                text = text.replace("F_o", res.get("query_Fn"));
                text = text.replace("F_p", res.get("query_Fn"));
                $("#input_flow_data").val(text);
                process_sankey(divId, divSvg, divChart);
                $("#input_flow_data").val(flowarea);
            })
            .catch(err => console.error(err));

        sankeyDiv.appendChild(buttonDiv);

        var imgElement = document.getElementById("singleCountryImg");
        var countryName = document.getElementById("countryFlagSpan");
        imgElement.src = "resources/countryFlags/de.png";
        imgElement.setAttribute("height", 30);
        imgElement.style.border = "outset";
        countryName.innerText = "Germany";

        document.getElementById("scenerioSpanLower").innerHTML = "LED";
        document.getElementById("sectorSpanLower").innerHTML = sector;
        document.getElementById("yearSpanLower").innerHTML = startYear + "-" + endYear;
        document.getElementById("strategySpanLower").innerHTML = "Full CE";
        document.getElementById("materialSpanLower").innerHTML = material;

        if (document.getElementById("sankeyDivsAllFullCE").style.display === "")
            document.getElementById("sankeyDivsAllFullCE").style.display = 'block';

        var sankeyDivLower = document.getElementById("sankeyDivsAllFullCE");

        var buttonDivLower = document.createElement("div");
        buttonDivLower.style.position = "absolute";
        var prevLinkLower = document.createElement("button");
        prevLinkLower.className = "button"; prevLinkLower.type = "button";
        prevLinkLower.textContent = ">>"; prevLinkLower.setAttribute("onclick", "navigateFrontLower()");
        var nextLinkLower = document.createElement("button");
        nextLinkLower.className = "button"; nextLinkLower.type = "button";
        nextLinkLower.textContent = "<<"; nextLinkLower.setAttribute("onclick", "navigateBackLower()");
        buttonDivLower.appendChild(prevLinkLower);
        buttonDivLower.appendChild(nextLinkLower);

        var newDivLower = document.createElement("div");
        newDivLower.id = "Lowerdiv_svg" + year; newDivLower.style.position = 'absolute';
        var chartParagraphLower = document.createElement("p");
        chartParagraphLower.id = "Lowerchart" + year;
        newDivLower.appendChild(chartParagraphLower);
        sankeyDivLower.appendChild(newDivLower);

        var spanDivLower = document.createElement("div");
        var newSpanLower = document.createElement("span");
        newSpanLower.id = "Lowerspan_svg" + year; newSpanLower.innerHTML = "LED-" + year;
        newSpanLower.style.position = "absolute"; newSpanLower.style.bottom = 0;
        spanDivLower.appendChild(newSpanLower);
        sankeyDivLower.appendChild(spanDivLower);

        newDivLower.style.visibility = (newDivLower.id === "Lowerdiv_svg" + startYear) ? "visible" : "hidden";
        newSpanLower.style.visibility = (newSpanLower.id === "Lowerspan_svg" + startYear) ? "visible" : "hidden";

        const svgElLower = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svgElLower.setAttribute("id", "Lowertarget_svg" + year);
        chartParagraphLower.appendChild(svgElLower);

        let divIdLower = "Lowertarget_svg" + year;
        let divSvgLower = newDivLower.id;
        let divChartLower = chartParagraphLower.id;

        $('.loader6').css("display", "block");
        fetch("circomodService.svc/Classification_SankeyItem", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({
                SELECTedRegion: region, SELECTedScenario: "LED",
                SELECTedSector: sector, SELECTedYear: year,
                SELECTedStrategy: "Full CE", SELECTedMaterial: material
            }),
        })
            .then(r => { if (!r.ok) throw new Error('Network error'); return r.json(); })
            .then(data => {
                $('.loader6').hide();
                var res = new Map(data.d.map(obj => [obj.Key, obj.Value.replace(",", ".")]));
                var flowarea = $("#input_flow_data").val();
                var text = flowarea;
                text = text.replace("F_a", res.get("query_Fa"));
                text = text.replace("F_b", Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh"))));
                var containerLower = document.getElementById('steelLowerValue');
                var FbLower = Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh")));
                var spansLower = "<b><span id='steelLower_span" + year + "' style='display:none'>" + parseFloat(FbLower.toFixed(1)) + " Mt/yr</span></b>";
                if (year == startYear) spansLower = spansLower.replace("display:none", "display:block");
                containerLower.innerHTML += spansLower;
                text = text.replace("F_c", res.get("query_Fc"));
                text = text.replace("F_d", res.get("query_Fc"));
                text = text.replace("F_e", res.get("query_Fc"));
                text = text.replace("F_f", res.get("query_Ff"));
                text = text.replace("F_g", Math.abs(parseFloat(res.get("query_Ff")) - parseFloat(res.get("query_Fh"))));
                text = text.replace("F_h", res.get("query_Fh"));
                text = text.replace("F_i", res.get("query_Fh"));
                text = text.replace("F_j", res.get("query_Fh"));
                text = text.replace("F_k", res.get("query_Fk") / 50);
                text = text.replace("F_l", res.get("query_Fl") / 50);
                text = text.replace("F_m", res.get("query_Fm") / 50);
                var ghgContainerLower = document.getElementById('GhGLowerValue');
                var FmLower = res.get("query_Fm") / 50;
                var ghgSpansLower = "<b><span id='ghgLower_span" + year + "' style='display:none'>" + parseFloat(FmLower.toFixed(1)) + " Mt/yr</span></b>";
                if (year == startYear) ghgSpansLower = ghgSpansLower.replace("display:none", "display:block");
                ghgContainerLower.innerHTML += ghgSpansLower;
                text = text.replace("F_n", res.get("query_Fn"));
                text = text.replace("F_o", res.get("query_Fn"));
                text = text.replace("F_p", res.get("query_Fn"));
                $("#input_flow_data").val(text);
                process_sankey(divIdLower, divSvgLower, divChartLower);
                $("#input_flow_data").val(flowarea);
            })
            .catch(err => console.error(err));

        sankeyDivLower.appendChild(buttonDivLower);
    }

    var imgElementLower = document.getElementById("singleCountryImgLower");
    var countryNameLower = document.getElementById("countryFlagSpanLower");
    imgElementLower.src = "resources/countryFlags/de.png";
    imgElementLower.setAttribute("height", 30);
    imgElementLower.style.border = "outset";
    countryNameLower.innerText = "Germany";

    document.getElementById("svgMap-map-country-DE").classList.add('svgMap-selected');

    var url = [];
    const url1 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/SP.POP.TOTL?format=json";
    const url2 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/NY.GDP.PCAP.CD?format=json";
    const url3 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/EN.POP.DNST?format=json";
    url.push(url1, url2, url3);
    var popSpan = document.getElementById("population");
    var gdpSpan = document.getElementById("gdp");
    var populationDensitySpan = document.getElementById("populationDensity");
    url.forEach(el => fetchCountryData(el, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3));
});

// ---------------------------------------------------------------
// SECTOR DROPDOWN
// ---------------------------------------------------------------
$(document).ready(function () {
    $("#DropDownListSector").on("change", function () {
        var sectorTemp = $(this).val();
        var dropdown = $("#DropDownListMaterial");
        dropdown.empty();
        dropdown.append("<option value='' disabled selected>Please select sector</option>");
        if (sectorTemp == "Residential building") {
            ["Steel", "Cement", "Wood"].forEach(el => dropdown.append($("<option>").val(el).text(el)));
        } else if (sectorTemp == "Passenger vehicles") {
            ["Steel", "Aluminium", "Copper"].forEach(el => dropdown.append($("<option>").val(el).text(el)));
        }
    });
});

// ---------------------------------------------------------------
// WORLD BANK DATA FETCH
// ---------------------------------------------------------------
function fetchCountryData(url, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3) {
    $.ajax({
        url: url, type: 'GET', dataType: 'json',
        success: function (data) {
            let n = 0;
            while (data) {
                if (data[1][n]["value"] != null && url == url1) {
                    popSpan.innerHTML = " " + data[1][n]["value"].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " (" + data[1][n]["date"] + ")";
                    break;
                } else if (data[1][n]["value"] != null && url == url2) {
                    gdpSpan.innerHTML = " " + Math.round(data[1][n]["value"]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " (" + data[1][n]["date"] + ")";
                    break;
                } else if (data[1][n]["value"] != null && url == url3) {
                    populationDensitySpan.innerHTML = " " + Math.round(data[1][n]["value"]).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " (" + data[1][n]["date"] + ")";
                    break;
                }
                n++;
            }
        },
    });
}

// ---------------------------------------------------------------
// GHG WATERFALL CHART
// ---------------------------------------------------------------
const chartImageURL = {};
function ghgChart(data, canvasID, region, sector) {
    var res = new Map(data["d"].map(obj => [obj.Key, obj.Value]));
    var values = [...new Set(Array.from(res.values()))];
    try {
        var chart = new CanvasJS.Chart("waterfall", {
            theme: "light2",
            backgroundColor: "rgba(225,150,150,0)",
            title: { text: `Cumulative GHG 2020-2060, [${region}], [${sector}]`, fontSize: 15 },
            axisY: { title: "Mt CO2-eq / year", valueFormatString: "#.###", titleFontSize: 12 },
            data: [{
                type: "waterfall",
                yValueFormatString: "#.###",
                risingColor: "#96a6a6",
                fallingColor: "#ef6c00",
                dataPoints: [
                    { label: "SSP2 Baseline", y: parseInt(Number(values[0].toString().replace(",", ".")).toFixed(1)) },
                    { label: ".", y: parseInt((Number(values[1].toString().replace(",", ".")) - Number(values[0].toString().replace(",", "."))).toFixed(1)) },
                    { label: "Slow+Close", isIntermediateSum: true },
                    { label: ".", y: parseInt((Number(values[2].toString().replace(",", ".")) - Number(values[1].toString().replace(",", "."))).toFixed()) },
                    { label: "Narrow+Slow+Close", isCumulativeSum: true }
                ]
            }]
        });
        chart.render();
        var canvas = $("#waterfall .canvasjs-chart-canvas").get(0);
        chartImageURL.waterfall = canvas.toDataURL('image/png');
    } catch (e) {
        console.error("Error rendering GHG chart:", e);
    }
    return chartImageURL;
}