document.addEventListener("DOMContentLoaded", function () {
    var idValue = "svgMap-map-country-DE";
    var url = [];  
    new svgMap({
        targetElementID: 'svgMap',
        noDataText: "",
        initialZoom: 1.1,
        initialPan: { x: 400, y: 0 },
        data: {
            values: {
            }
        },
        onGetTooltip: function (tooltipDiv, countryID, countryValues) {
            // Get Id's of graph divs
            var flagContainer = document.getElementById("countryFlag");
            var imgElement = document.getElementById("singleCountryImg");
            var countryName = document.getElementById("countryFlagSpan");
            var energyServicePNG = document.getElementById("energyServiceCascadePNG");
            var decouplingService = document.getElementById("ecdDecouplingPNG");

            // Lower  Sankey
            var imgElementLower = document.getElementById("singleCountryImgLower");
            var countryNameLower = document.getElementById("countryFlagSpanLower");
            $('.svgMap-country').off('click').on('click', function (e) {

                var proxyWarning = document.getElementById("proxyWarning");
                proxyWarning.innerHTML = ""
                // Upper Sankey Reset Div
                // Find the <p> element by its id
                var steelSpanUpperContainer = document.getElementById("steelUpperValue");
                var ghgSpanUpperContainer = document.getElementById("GhGUpperValue");
                var steelSpanLowerContainer = document.getElementById("steelLowerValue");
                var ghgSpanLowerContainer = document.getElementById("GhGLowerValue");

                // Function to remove <b> tags within a container
                function removeBoldTags(container) {
                    var boldTags = container.getElementsByTagName("b");
                    while (boldTags.length > 0) {
                        boldTags[0].parentNode.removeChild(boldTags[0]);
                    }
                }

                // Remove <b> tags from upper containers
                removeBoldTags(steelSpanUpperContainer);
                removeBoldTags(ghgSpanUpperContainer);

                // Remove <b> tags from lower containers
                removeBoldTags(steelSpanLowerContainer);
                removeBoldTags(ghgSpanLowerContainer);        
                // Map blue fill over country selection
                document.getElementById(idValue).setAttribute('fill', null)
                idValue = e.target.id;
                document.getElementById(idValue).setAttribute('fill', 'blue');

                //Fetch json for ISO codes --> Get CountryName,Dataname for missing country,Flag,EnergyCascade png names
                const filePath = "json/countryProxy.json";
                fetch(filePath)
                .then(response => response.json())
                .then(function (response) {
                    var countryInfoCountryName = document.getElementById("countryInfoCountryName");
                    var proxyName = document.getElementById("proxyName");
                    const findFlagAndData = response.find(obj => obj.ISO === countryID.toUpperCase());
                    var name = svgMap.prototype.countries[countryID]
                    if (findFlagAndData.Flag == true) {
                        countryName.innerHTML = name + " (" + findFlagAndData.Data + ")";
                        countryNameLower.innerHTML = countryName.innerHTML
                        var region = findFlagAndData.Data;
                        proxyWarning.innerHTML = "Sorry, no data for <span style='color:#ba1a1a'>" + name + "</span>, here, the data for the proxy region<span style='color:green'> " + findFlagAndData.Data + "</span> are shown"
                        countryInfoCountryName.innerHTML = name;
                        proxyName.innerHTML = "Proxy name: " + findFlagAndData.Data
                        var findFlagAndDataPNG = findFlagAndData.Png
                        return { region: region, findFlagAndDataPNG: findFlagAndDataPNG };
                    } else {
                        countryName.innerHTML = name;
                        countryInfoCountryName.innerHTML = name;
                        countryNameLower.innerHTML = countryName.innerHTML
                        proxyName.innerHTML = ""
                        var findFlagAndDataPNG = findFlagAndData.Png
                        return { region: findFlagAndData.Data, findFlagAndDataPNG: findFlagAndDataPNG };
                    }
                })
                .then(function (regionObj) {

                // Reset Divs
                    var region = regionObj.region;
                    var findFlagAndDataPNG = regionObj.findFlagAndDataPNG;
                    // Bind Flag to "Sankey Configuration"
                    imgElement.src = "https://cdn.jsdelivr.net/gh/hjnilsson/country-flags@latest/svg/" + countryID.toLowerCase() + ".svg";
                    imgElementLower.src = imgElement.src
                    // Get Fetch API for "Country Info" div
                    const url1 = "https://api.worldbank.org/v2/country/" + countryID.toLowerCase() + "/indicators/SP.POP.TOTL?format=json"; //GDP
                    const url2 = "https://api.worldbank.org/v2/country/" + countryID.toLowerCase() + "/indicators/NY.GDP.PCAP.CD?format=json"; //Population
                    const url3 = "https://api.worldbank.org/v2/country/" + countryID.toLowerCase() + "/indicators/EN.POP.DNST?format=json"; //PopulationDensity
                    url.push(url1, url2, url3)
                    var popSpan = document.getElementById("population");
                    var gdpSpan = document.getElementById("gdp");
                    var populationDensitySpan = document.getElementById("populationDensity");
                    url.forEach((element) =>
                        fetchCountryData(element, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3)
                    )
                    // Set Parameters
                    var scenario = "SSP2";
                    var startYear = 2020;
                    var endYear = 2060;
                    var sectorTemp = $('#DropDownListSector').val();
                    var material = $('#DropDownListMaterial').val();
                    // Sankey Sector Parameter

                    // China Teaser
                    if (region == "R32CHN" && sectorTemp == "Residential building") {
                        $('#ChinaTeaser').css('display', 'grid');
                    } else {
                        $('#ChinaTeaser').css('display', 'none');
                    }

                    // Energy Cascade and Decoupling PNG
                    if (sectorTemp == "Residential building") {
                        energyServicePNG.src = "Content/ReccPlots/" + findFlagAndDataPNG
                        decouplingService.src = "Content/ReccPlots/ECD_Decoupling_Overview.png"
                    } else {
                        energyServicePNG.src = ""
                        decouplingService.src = ""
                    }
                    $('.loader2').css("display", "block");
                    // AJAX call for Population
                    $.ajax({
                        type: "POST",
                        url: "circomodService.svc/Classification_ResultItemPopulation",
                        data: `{"SELECTedRegion": "${region}"}`,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (result) {
                            $('.loader2').hide();
                            if (region != "") {
                                displayGraph(result["d"], "line-plot2", `Total Population by scenerio(million)`, 'Total Population');

                            }
                        }
                    });

                    $('.loader4').css("display", "block");
                    $.ajax({
                        type: "POST",
                        url: "circomodService.svc/Classification_ResultAreaStacked",
                        data: `{"selectedRegion": "${region}","selectedSector": "${sectorTemp}"}`,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (result) {
                            $('.loader4').hide();
                            if (region != "") {
                                stackedAreaChart(result, "line-plot4");

                            }
                        }
                    });

                    $('.loader3').css("display", "block");
                    // AJAX call for Bar Graph Primary/Secondary Production
                    var request3 = $.ajax({
                        type: "POST",
                        url: "circomodService.svc/Classification_Result1stAnd2ndProd",
                        data: `{"selectedRegion": "${region}","selectedSector": "${sectorTemp}","selectedMaterial": "${material}"}`,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (result) {
                            $('.loader3').hide();
                            if (region != "") {
                                console.log(material)
                                barChart(result, "line-plot3", material)
                            }
                        }
                    });


                    $('.loader5').css("display", "block");
                    $.ajax({
                        type: "POST",
                        url: "circomodService.svc/Classification_ResultGHG",
                        data: `{"selectedRegion": "${region}","selectedSector": "${sectorTemp}"}`,
                        dataType: "json",
                        contentType: "application/json; charset=utf-8",
                        success: function (result) {
                            $('.loader5').hide();
                            if (region != "") {
                                ghgChart(result, "line-plot5");

                            }
                        }
                    });
                    var canvasElement = document.getElementById("NoData" + "line-plot1");
                    // AJAX call for Line Graph for "Per Capita Service Level SECTOR:Passenger Vehicle, REGION:Choose"
                    countriesAvailable = ["France", "Germany", "Italy", "Spain", "UK", "Poland", "Oth_R32EU15", "Oth_R32EU12-H", "R32EU12-M"];
                    if (sectorTemp == "Residential building" && countriesAvailable.includes(region)) {
                        var sector = sectorTemp;
                        canvasElement.style.display = "none";
                        $('.loader1').css("display", "block");
                        $.ajax({
                            type: "POST",
                            url: "circomodService.svc/Classification_ResultItemBuildingRes",
                            data: `{"selectedRegion": "${region}"}`,
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (result) {
                                $('.loader1').hide();
                                if (region != "") {
                                    displayGraph(result["d"], "line-plot1", `Per Capita Service Level `, 'm2/cap');
                                }
                            }
                        });
                    } else if (sectorTemp == "Passenger vehicles") {
                            $('.loader1').css("display", "block");
                            /*$.ajax({
                                type: "POST",
                                url: "circomodService.svc/Classification_ResultItem",
                                data: `{"SELECTedRegion": "${region}"}`,
                                dataType: "json",
                                contentType: "application/json; charset=utf-8",
                                success: function (result) {
                                    $('.loader1').hide();
                                    if (region != "") {
                                        displayGraph(result["d"], "line-plot1", `Per Capita Service Level `, 'Annual pkm by passenger cars');
                                    }
                                }
                            });*/
                        fetch("circomodService.svc/Classification_ResultItem", {
                            method: "POST",
                            headers: {
                                "Content-Type": "application/json; charset=utf-8",
                            },
                            body: JSON.stringify({ SELECTedRegion: region }),
                        })
                            .then(response => response.json())
                            .then(result => {
                                document.querySelector('.loader1').style.display = 'none';
                                if (region !== "") {
                                    displayGraph(result.d, "line-plot1", "Per Capita Service Level", "Annual pkm by passenger cars");
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                            });
                    } else {
                        Chart.getChart("line-plot1").destroy();
                        canvasElement.style.display = "flex";
                       }

                    // UPPER Parameters

                    var startYear = 2020;
                    var endYear = 2060;
                   // var material = "Steel";
                    var strategy = "Baseline";
                    document.getElementById('sankeyDivsAll').innerHTML = "";
                    document.getElementById('sankeyDivsAllFullCE').innerHTML = "";
                    document.getElementById("scenerioSpan").innerHTML = scenario
                    document.getElementById("sectorSpan").innerHTML = sector
                    document.getElementById("yearSpan").innerHTML = startYear + "-" + endYear
                    document.getElementById("strategySpan").innerHTML = strategy
                    document.getElementById("materialSpan").innerHTML = material
                    var graphElement = document.getElementById("sankeyDivsAll").style.display;

                    if (graphElement === "") {
                        document.getElementById("sankeyDivsAll").style.display = 'block';
                    }
                    var sankeyDiv = document.getElementById("sankeyDivsAll");
                    var buttonDiv = document.createElement("div");
                    buttonDiv.style.position = "absolute";
                    // Create Buttons
                    var previousLink = document.createElement("button");
                    previousLink.className = "button ";
                    previousLink.type = "button";
                    previousLink.textContent = ">>";
                    previousLink.setAttribute("onclick", "navigateFront()");
                    var nextLink = document.createElement("button");
                    nextLink.className = "button ";
                    nextLink.type = "button";
                    nextLink.textContent = "<<";
                    nextLink.setAttribute("onclick", "navigateBack()");
                    // Append buttons elements to the "sankey" div
                    buttonDiv.appendChild(previousLink);
                    buttonDiv.appendChild(nextLink);
                    for (let year = startYear; year <= endYear; year += 10) {
                        // LOWER SANKEY
                        var scenario = "SSP2";
                        var strategy = "Baseline";
                        var newDiv = document.createElement("div");
                        newDiv.id = "div_svg" + year;
                        newDiv.style.position = 'absolute';
                        // Create and append <p id="chart"> element within each div
                        var chartParagraph = document.createElement("p");
                        chartParagraph.id = "chart" + year;
                        newDiv.appendChild(chartParagraph);
                        // Append the dynamically created div to the parent div
                        sankeyDiv.appendChild(newDiv);
                        //Create Div for Span and Span for the year text
                        var spanDiv = document.createElement("div");
                        var newSpan = document.createElement("span");
                        newSpan.id = "span_svg" + year;
                        newSpan.innerHTML = "SSP2-"+year;                    
                        newSpan.style.position = "absolute";
                        newSpan.style.bottom = 0;
                        spanDiv.appendChild(newSpan);
                        sankeyDiv.appendChild(spanDiv);
                        if (newDiv.id == "div_svg" + startYear && newSpan.id == "span_svg" + startYear) {
                            newDiv.style.visibility = "visible"
                            newSpan.style.visibility = "visible"
                        } else {
                            newDiv.style.visibility = "hidden"
                            newSpan.style.visibility = "hidden"
                        }
                        // Get the chartContainer directly from chartParagraph
                        var chartContainer = chartParagraph;

                        const svgElement = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                        svgElement.setAttribute("id", "target_svg" + year); // Using underscores instead of spaces
                        // Append the SVG to the chartContainer
                        chartContainer.appendChild(svgElement);
                        let divId = "target_svg" + year
                        let divSvg = newDiv.id
                        let divChart = chartParagraph.id;
                        $('.loader').css("display", "block");
                        // Sankey Upper AJAX call
                        $.ajax({
                            url: "circomodService.svc/Classification_SankeyItem",
                            type: "POST",
                            data: `{"SELECTedRegion": "${region}","SELECTedScenario": "${scenario}","SELECTedSector": "${sectorTemp}","SELECTedYear": "${year}",
                            "SELECTedStrategy": "${strategy}","SELECTedMaterial": "steel"}`,
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $('.loader').hide();
                                var res = new Map(data["d"].map(obj => [obj.Key, obj.Value.replace(",", ".")]));
                                var flowarea = $("#input_flow_data").val();
                                var text = flowarea;
                                text = text.replace("F_a", res.get("query_Fa"));
                                text = text.replace("F_b", Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh"))));
                                // Reference flow for final consumption of steel (blue): Mt/yr
                                var container = document.getElementById('steelUpperValue');
                                var Fb  = Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh")))
                                spans = "<b><span id='" + "steelUpper_span" + year + "'" + "style='display:none'>" + parseFloat(Fb.toFixed(1)) + " Mt/yr</span></b>";
                                if (year == startYear) {
                                    spans = spans.replace("display:none", "display:block")
                                }
                                container.innerHTML += spans
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
                                // Reference flow for GHG emissions (green): Mt/yr
                                var container = document.getElementById('GhGUpperValue');
                                var Fm = res.get("query_Fm") / 50 
                                spans = "<b><span id='" + "ghgUpper_span" + year + "'" + "style='display:none'>" + parseFloat(Fm.toFixed(1)) + " Mt/yr</span></b>";
                                if (year == startYear) {
                                    spans = spans.replace("display:none", "display:block")
                                }
                                container.innerHTML += spans
                                text = text.replace("F_n", res.get("query_Fn"));
                                text = text.replace("F_o", res.get("query_Fn"));
                                text = text.replace("F_p", res.get("query_Fn"));
                                $("#input_flow_data").val(text);
                                process_sankey(divId, divSvg, divChart);
                                $("#input_flow_data").val(flowarea);
                            }
                        });
                        sankeyDiv.appendChild(buttonDiv);
                        // LOWER SANKEY
                        var scenario = "LED";
                        var strategy = "Full CE";
                        // Lower Sankey Config
                       
                        document.getElementById("scenerioSpanLower").innerHTML = scenario
                        document.getElementById("sectorSpanLower").innerHTML = sector
                        document.getElementById("yearSpanLower").innerHTML = startYear + "-" + endYear
                        document.getElementById("strategySpanLower").innerHTML = strategy
                        document.getElementById("materialSpanLower").innerHTML = material
                        var graphElementLower = document.getElementById("sankeyDivsAllFullCE").style.display;
                        // Lower Sanykey
                        if (graphElementLower === "") {
                            document.getElementById("sankeyDivsAllFullCE").style.display = 'block';
                        }
                        var sankeyDivLower = document.getElementById("sankeyDivsAllFullCE");
                        var buttonDivLower = document.createElement("div");
                        buttonDivLower.style.position = "absolute";
                        // Create <a> elements
                        var previousLinkLower = document.createElement("button");
                        previousLinkLower.className = "button ";
                        previousLinkLower.type = "button";
                        previousLinkLower.textContent = ">>";
                        previousLinkLower.setAttribute("onclick", "navigateFrontLower()");

                        var nextLinkLower = document.createElement("button");
                        nextLinkLower.className = "button ";
                        nextLinkLower.type = "button";
                        nextLinkLower.textContent = "<<";
                        nextLinkLower.setAttribute("onclick", "navigateBackLower()");
                        // Append <a> elements to the "sankey" div
                        buttonDivLower.appendChild(previousLinkLower);
                        buttonDivLower.appendChild(nextLinkLower);
                        var newDivLower = document.createElement("div");
                        newDivLower.id = "Lowerdiv_svg" + year;
                        newDivLower.style.position = 'absolute';
                        // Create and append <p id="chart"> element within each div
                        var chartParagraphLower = document.createElement("p");
                        chartParagraphLower.id = "Lowerchart" + year;
                        newDivLower.appendChild(chartParagraphLower);
                        // Append the dynamically created div to the parent div
                        sankeyDivLower.appendChild(newDivLower);
                        //Create Div for Span and Span for the year text
                        var spanDivLower = document.createElement("div");
                        var newSpanLower = document.createElement("span");
                        newSpanLower.id = "Lowerspan_svg" + year;
                        newSpanLower.innerHTML = "LED-"+year;
                        newSpanLower.style.position = "absolute";
                        newSpanLower.style.bottom = 0;
                        spanDivLower.appendChild(newSpanLower);
                        sankeyDivLower.appendChild(spanDivLower);
                        if (newDivLower.id == "Lowerdiv_svg" + startYear && newSpanLower.id == "Lowerspan_svg" + startYear) {
                            newDivLower.style.visibility = "visible"
                            newSpanLower.style.visibility = "visible"
                        } else {
                            newDivLower.style.visibility = "hidden"
                            newSpanLower.style.visibility = "hidden"
                        }
                        // Get the chartContainer directly from chartParagraph
                        var chartContainerLower = chartParagraphLower;
                        const svgElementLower = document.createElementNS("http://www.w3.org/2000/svg", "svg");
                        svgElementLower.setAttribute("id", "Lowertarget_svg" + year); // Using underscores instead of spaces
                        // Append the SVG to the chartContainer
                        chartContainerLower.appendChild(svgElementLower);
                        let divIdLower = "Lowertarget_svg" + year
                        let divSvgLower = newDivLower.id
                        let divChartLower = chartParagraphLower.id;
                        var spans = "";
                            $('.loader6').css("display", "block");
                          
                        $.ajax({
                            url: "circomodService.svc/Classification_SankeyItem",
                            type: "POST",
                            data: `{"SELECTedRegion": "${region}","SELECTedScenario": "${scenario}","SELECTedSector": "${sectorTemp}","SELECTedYear": "${year}",
                                "SELECTedStrategy": "${strategy}","SELECTedMaterial": "steel"}`,
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $('.loader6').hide();
                                var res = new Map(data["d"].map(obj => [obj.Key, obj.Value.replace(",", ".")]));
                                var flowarea = $("#input_flow_data").val();
                                var text = flowarea;
                                text = text.replace("F_a", res.get("query_Fa"));
                                text = text.replace("F_b", Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh"))));
                                // Reference flow for final consumption of steel (blue): Mt/yr
                                var container = document.getElementById('steelLowerValue');
                                var Fb = Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh")))
                                spans = "<b><span id='" + "steelLower_span" + year + "'" + "style='display:none'>" + parseFloat(Fb.toFixed(1)) + " Mt/yr</span></b>";
                                if (year == startYear) {
                                    spans = spans.replace("display:none", "display:block")
                                }
                                container.innerHTML += spans
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
                                // Reference flow for GHG emissions (green): Mt/yr
                                var container = document.getElementById('GhGLowerValue');
                                var Fm = res.get("query_Fm") / 50
                                spans = "<b><span id='" + "ghgLower_span" + year + "'" + "style='display:none'>" + parseFloat(Fm.toFixed(1)) + " Mt/yr</span></b>";
                                if (year == startYear) {
                                    spans = spans.replace("display:none", "display:block")
                                }
                                container.innerHTML += spans
                                text = text.replace("F_n", res.get("query_Fn"));
                                text = text.replace("F_o", res.get("query_Fn"));
                                text = text.replace("F_p", res.get("query_Fn"));
                                $("#input_flow_data").val(text);
                                process_sankey(divIdLower, divSvgLower, divChartLower);
                                $("#input_flow_data").val(flowarea);
                            }

                        });
                        sankeyDivLower.appendChild(buttonDivLower);
                    }
                    
                });            
            });
        }
    });
});

function fetchCountryData(url, popSpan, gdpSpan, populationDensitySpan,url1,url2,url3) {
    $.ajax({
        url: url,
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            // Handle the data here
            let n = 0;
            while (data) {
                if (data[1][n]["value"] != null && url==url1) {
                    var value = data[1][n]["value"]
                    var date = data[1][n]["date"]
                    gdpSpan.innerHTML = "&#8226" + " " + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " (" + date + ")"
                    break
                } else if (data[1][n]["value"] != null && url == url2) {
                    var value = data[1][n]["value"]
                    var date = data[1][n]["date"]
                    popSpan.innerHTML = "&#8226" + " " + Math.round(value).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " (" + date + ")"
                    break

                } else if (data[1][n]["value"] != null && url == url3) {
                    var value = data[1][n]["value"]
                    var date = data[1][n]["date"]
                    populationDensitySpan.innerHTML = "&#8226" + " " + Math.round(value).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".") + " (" + date + ")"
                    break
                }
                n++             
            }
        },

    });
}
$(window).on('load', function () {

    var countryInfoCountryName = document.getElementById("countryInfoCountryName");
    // Fetch Json
    const filePath = "json/countryProxy.json";
    fetch(filePath)
        .then(response => response.json())
        .then(function (response){
        countryID = "DE"
        const findFlagAndData = response.find(obj => obj.ISO === countryID.toUpperCase());
            var energyServicePNG = document.getElementById("energyServiceCascadePNG");
            var decouplingService = document.getElementById("ecdDecouplingPNG")
            energyServicePNG.src = "Content/ReccPlots/" + findFlagAndData.Png
            decouplingService.src = "Content/ReccPlots/ECD_Decoupling_Overview.png"

        });

    var region = "Germany";
    var scenario = "SSP2";
    var sector = "Residential building";
    var startYear = 2020;
    var endYear = 2030;
    var strategy = "Baseline";
    var material = "steel";
    countryInfoCountryName.innerHTML = region
    $('.loader2').css("display", "block");
    // AJAX call for Population
    $.ajax({
        type: "POST",
        url: "circomodService.svc/Classification_ResultItemPopulation",
        data: `{"SELECTedRegion": "${region}"}`,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            $('.loader2').hide();
            if (region != "") {
                displayGraph(result["d"], "line-plot2", `Total Population by scenerio(million)`, 'Total Population');

            }
        }
    });

    // Ajax call for Per Capita Service Level, SECTOR:Passenger Vehicle, REGION:Choose
    $('.loader1').css("display", "block");
    $.ajax({
        type: "POST",
        url: "circomodService.svc/Classification_ResultItemBuildingRes",
        data: `{"selectedRegion": "${region}"}`,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            $('.loader1').hide();
            if (region != "") {
                displayGraph(result["d"],"line-plot1", `Per Capita Service Level `, 'm2/cap');
            }
        }
    });


    $('.loader3').css("display", "block");
    /*$.ajax({
        type: "POST",
        url: "circomodService.svc/Classification_Result1stAnd2ndProd",
        data: `{"selectedRegion": "${region}","selectedSector": "${sector}","selectedMaterial": "${material}"}`,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            $('.loader3').hide();
            if (region != "") {
                barChart(result, "line-plot3",material)
            }
        }
    });*/
    fetch("circomodService.svc/Classification_Result1stAnd2ndProd", {
        method: "POST",
        headers: {
            "Content-Type": "application/json; charset=utf-8",
        },
        body: JSON.stringify({
            selectedRegion: region,
            selectedSector: sector,
            selectedMaterial: material
        }),
    }).then(response => response.json()).then(result => {
        document.querySelector('.loader3').style.display = 'none';
        if (region !== "") {
            barChart(result, "line-plot3", material);
        }
    })


    $('.loader4').css("display", "block");
    /*$.ajax({
        type: "POST",
        url: "circomodService.svc/Classification_ResultAreaStacked",
        data: `{"selectedRegion": "${region}","selectedSector": "${sector}"}`,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            $('.loader4').hide();
            if (region != "") {
                stackedAreaChart(result, "line-plot4");
            }
        }
    });*/
    fetch("circomodService.svc/Classification_ResultAreaStacked", {
        method: "POST",
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: JSON.stringify({
            selectedRegion: region,
            selectedSector: sector
        })
    }).then(response => response.json()).then(result => {
        document.querySelector('.loader4').style.display = 'none';
        if (region !== "") {
            stackedAreaChart(result, "line-plot4");
        }
    })


    $('.loader5').css("display", "block");
    $.ajax({
        type: "POST",
        url: "circomodService.svc/Classification_ResultGHG",
        data: `{"selectedRegion": "${region}","selectedSector": "${sector}"}`,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            $('.loader5').hide();
            if (region != "") {
                ghgChart(result,'line-plot5');

            }
        }
    });

    // Upper Sankey Config
    document.getElementById("scenerioSpan").innerHTML = scenario
    document.getElementById("sectorSpan").innerHTML = sector
    document.getElementById("yearSpan").innerHTML = startYear + "-" + endYear
    document.getElementById("strategySpan").innerHTML = strategy
    document.getElementById("materialSpan").innerHTML = material
    var graphElement = document.getElementById("sankeyDivsAll").style.display;


    // Upper Sanyke
    if (graphElement === "") {
        document.getElementById("sankeyDivsAll").style.display = 'block';
    }
    var sankeyDiv = document.getElementById("sankeyDivsAll");
    var buttonDiv = document.createElement("div");
    buttonDiv.style.position = "absolute";
    // Create <a> elements
    var previousLink = document.createElement("button");
    previousLink.className = "button ";
    previousLink.type = "button";
    previousLink.textContent = ">>";
    previousLink.setAttribute("onclick", "navigateFront()");

    var nextLink = document.createElement("button");
    nextLink.className = "button ";
    nextLink.type = "button";
    nextLink.textContent = "<<";
    nextLink.setAttribute("onclick", "navigateBack()");
    // Append <a> elements to the "sankey" div
    buttonDiv.appendChild(previousLink);
    buttonDiv.appendChild(nextLink);


   
    for (let year = startYear; year <= endYear; year += 10) {
     
        var newDiv = document.createElement("div");
        newDiv.id = "div_svg" + year;
        newDiv.style.position = 'absolute';
        // Create and append <p id="chart"> element within each div
        var chartParagraph = document.createElement("p");
        chartParagraph.id = "chart" + year;
        newDiv.appendChild(chartParagraph);
        // Append the dynamically created div to the parent div
        sankeyDiv.appendChild(newDiv);
        //Create Div for Span and Span for the year text
        var spanDiv = document.createElement("div");
        var newSpan = document.createElement("span");
        newSpan.id = "span_svg" + year;
        newSpan.innerHTML = "SSP2-"+year;
        newSpan.style.position = "absolute";
        newSpan.style.bottom = 0;
        spanDiv.appendChild(newSpan);
        sankeyDiv.appendChild(spanDiv);
        if (newDiv.id == "div_svg" + startYear && newSpan.id == "span_svg" + startYear) {
            newDiv.style.visibility = "visible"
            newSpan.style.visibility = "visible"
        } else {
            newDiv.style.visibility = "hidden"
            newSpan.style.visibility = "hidden"
        }
        // Get the chartContainer directly from chartParagraph
        var chartContainer = chartParagraph;
        const svgElement = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svgElement.setAttribute("id", "target_svg" + year); // Using underscores instead of spaces
        // Append the SVG to the chartContainer
        chartContainer.appendChild(svgElement);
        let divId = "target_svg" + year
        let divSvg = newDiv.id
        let divChart = chartParagraph.id;
        var spans = "";

        $('.loader').css("display", "block");
        $.ajax({
            url: "circomodService.svc/Classification_SankeyItem",
            type: "POST",
            data: `{"SELECTedRegion": "${region}","SELECTedScenario": "${scenario}","SELECTedSector": "${sector}","SELECTedYear": "${year}",
                        "SELECTedStrategy": "${strategy}","SELECTedMaterial": "${material}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                $('.loader').hide();
                var res = new Map(data["d"].map(obj => [obj.Key, obj.Value.replace(",", ".")]));
                var flowarea = $("#input_flow_data").val();
                var text = flowarea;
                text = text.replace("F_a", res.get("query_Fa"));
                text = text.replace("F_b", Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh"))));
                // Reference flow for final consumption of steel (blue): Mt/yr
                var container = document.getElementById('steelUpperValue');
                var Fb = Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh")));
                spans = "<b><span id='" + "steelUpper_span" + year + "'" + "style='display:none'>" + parseFloat(Fb.toFixed(1)) + " Mt/yr</span></b>";              
                if (year == startYear) {
                    spans = spans.replace("display:none","display:block")
                }
                container.innerHTML += spans
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
                // Reference flow for GHG emissions (green): Mt/yr
                var container = document.getElementById('GhGUpperValue');
                var Fm = res.get("query_Fm") / 50;
                spans = "<b><span id='" + "ghgUpper_span" + year + "'" + "style='display:none'>" + parseFloat(Fm.toFixed(1)) + " Mt/yr</span></b>";
                if (year == startYear) {
                    spans = spans.replace("display:none", "display:block")
                }
                container.innerHTML += spans
                text = text.replace("F_n", res.get("query_Fn"));
                text = text.replace("F_o", res.get("query_Fn"));
                text = text.replace("F_p", res.get("query_Fn"));
                $("#input_flow_data").val(text);
                process_sankey(divId, divSvg, divChart);
                $("#input_flow_data").val(flowarea);
            }

            
        });

        sankeyDiv.appendChild(buttonDiv)

        // Upper  Sankey
        var flagContainer = document.getElementById("countryFlag");
        var imgElement = document.getElementById("singleCountryImg");
        var countryName = document.getElementById("countryFlagSpan");
        flagContainer.children.innerHTML = ""
        var countryCode = "de";
        // Set the src attribute of the img tag
        imgElement.src = "https://cdn.jsdelivr.net/gh/hjnilsson/country-flags@latest/svg/" + "de" + ".svg";
        imgElement.setAttribute("height", 30)
        imgElement.style.border = "outset";
        var name = "Germany"
        countryName.innerText = name;
        countryName.id = "countryFlagSpan"

        // LOWER SANKEY
        var scenario = "LED";
        var strategy = "Full CE";
        // Lower Sankey Config
        document.getElementById("scenerioSpanLower").innerHTML = scenario
        document.getElementById("sectorSpanLower").innerHTML = sector
        document.getElementById("yearSpanLower").innerHTML = startYear + "-" + endYear
        document.getElementById("strategySpanLower").innerHTML = strategy
        document.getElementById("materialSpanLower").innerHTML = material
        var graphElementLower = document.getElementById("sankeyDivsAllFullCE").style.display;
        // Lower Sanykey
        if (graphElementLower === "") {
            document.getElementById("sankeyDivsAllFullCE").style.display = 'block';
        }
        var sankeyDivLower = document.getElementById("sankeyDivsAllFullCE");
        var buttonDivLower = document.createElement("div");
        buttonDivLower.style.position = "absolute";
        // Create <a> elements
        var previousLinkLower = document.createElement("button");
        previousLinkLower.className = "button ";
        previousLinkLower.type = "button";
        previousLinkLower.textContent = ">>";
        previousLinkLower.setAttribute("onclick", "navigateFrontLower()");

        var nextLinkLower = document.createElement("button");
        nextLinkLower.className = "button ";
        nextLinkLower.type = "button";
        nextLinkLower.textContent = "<<";
        nextLinkLower.setAttribute("onclick", "navigateBackLower()");
        // Append <a> elements to the "sankey" div
        buttonDivLower.appendChild(previousLinkLower);
        buttonDivLower.appendChild(nextLinkLower);
        var newDivLower = document.createElement("div");
        newDivLower.id = "Lowerdiv_svg" + year;
        newDivLower.style.position = 'absolute';
        // Create and append <p id="chart"> element within each div
        var chartParagraphLower = document.createElement("p");
        chartParagraphLower.id = "Lowerchart" + year;
        newDivLower.appendChild(chartParagraphLower);
        // Append the dynamically created div to the parent div
        sankeyDivLower.appendChild(newDivLower);
        //Create Div for Span and Span for the year text
        var spanDivLower = document.createElement("div");
        var newSpanLower = document.createElement("span");
        newSpanLower.id = "Lowerspan_svg" + year;
        newSpanLower.innerHTML = "LED-" + year;
        newSpanLower.style.position = "absolute";
        newSpanLower.style.bottom = 0;
        spanDivLower.appendChild(newSpanLower);
        sankeyDivLower.appendChild(spanDivLower);
        if (newDivLower.id == "Lowerdiv_svg" + startYear && newSpanLower.id == "Lowerspan_svg" + startYear) {
            newDivLower.style.visibility = "visible"
            newSpanLower.style.visibility = "visible"
        } else {
            newDivLower.style.visibility = "hidden"
            newSpanLower.style.visibility = "hidden"
        }
        // Get the chartContainer directly from chartParagraph
        var chartContainerLower = chartParagraphLower;
        const svgElementLower = document.createElementNS("http://www.w3.org/2000/svg", "svg");
        svgElementLower.setAttribute("id", "Lowertarget_svg" + year); // Using underscores instead of spaces
        // Append the SVG to the chartContainer
        chartContainerLower.appendChild(svgElementLower);
        let divIdLower = "Lowertarget_svg" + year
        let divSvgLower = newDivLower.id
        let divChartLower = chartParagraphLower.id;
        var spans = "";
        $('.loader6').css("display", "block");
        $.ajax({
            url: "circomodService.svc/Classification_SankeyItem",
            type: "POST",
            data: `{"SELECTedRegion": "${region}","SELECTedScenario": "${scenario}","SELECTedSector": "${sector}","SELECTedYear": "${year}",
                        "SELECTedStrategy": "${strategy}","SELECTedMaterial": "${material}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",

            success: function (data) {
                $('.loader6').hide();
                var res = new Map(data["d"].map(obj => [obj.Key, obj.Value.replace(",", ".")]));
                var flowarea = $("#input_flow_data").val();
                var text = flowarea;
                text = text.replace("F_a", res.get("query_Fa"));
                text = text.replace("F_b", Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh"))));
                // Reference flow for final consumption of steel (blue): Mt/yr
                var container = document.getElementById('steelLowerValue');
                var Fb = Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh")));
                spans = "<b><span id='" + "steelLower_span" + year + "'" + "style='display:none'>" + parseFloat(Fb.toFixed(1)) + " Mt/yr</span></b>";
                if (year == startYear) {
                    spans = spans.replace("display:none", "display:block")
                }
                container.innerHTML += spans
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
                // Reference flow for GHG emissions (green): Mt/yr
                var container = document.getElementById('GhGLowerValue');
                var Fm = res.get("query_Fm") / 50 
                spans = "<b><span id='" + "ghgLower_span" + year + "'" + "style='display:none'>" + parseFloat(Fm.toFixed(1)) + " Mt/yr</span></b>";
                if (year == startYear) {
                    spans = spans.replace("display:none", "display:block")
                }
                container.innerHTML += spans
                text = text.replace("F_n", res.get("query_Fn"));
                text = text.replace("F_o", res.get("query_Fn"));
                text = text.replace("F_p", res.get("query_Fn"));
                $("#input_flow_data").val(text);
                process_sankey(divIdLower, divSvgLower, divChartLower);
                $("#input_flow_data").val(flowarea);
            }
            
        });
        sankeyDivLower.appendChild(buttonDivLower);
    }

    // Lower  Sankey
    var flagContainerLower = document.getElementById("countryFlagLower");
    var imgElementLower = document.getElementById("singleCountryImgLower");
    var countryNameLower = document.getElementById("countryFlagSpanLower");
    flagContainerLower.children.innerHTML = ""
    // Set the src attribute of the img tag
    imgElementLower.src = "https://cdn.jsdelivr.net/gh/hjnilsson/country-flags@latest/svg/" + "de" + ".svg";
    imgElementLower.setAttribute("height", 30)
    imgElementLower.style.border = "outset";
    var name = "Germany"
    countryNameLower.innerText = name;
    countryNameLower.id = "countryFlagSpanLower"


    // Country info API
    document.getElementById("svgMap-map-country-DE").setAttribute('fill', 'blue');
    var url = [];
    const url1 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/SP.POP.TOTL?format=json"; //GDP
    const url2 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/NY.GDP.PCAP.CD?format=json"; //Population
    const url3 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/EN.POP.DNST?format=json"; //PopulationDensity
    url.push(url1, url2, url3)
    var popSpan = document.getElementById("population");
    var gdpSpan = document.getElementById("gdp");
    var populationDensitySpan = document.getElementById("populationDensity");
    url.forEach((element) =>
        fetchCountryData(element, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3)
    )
});

$(document).ready(function () {
    $("#DropDownListSector").on("change", function () {
        var sectorTemp = $(this).val();
        var dropdown = $("#DropDownListMaterial"); // Using jQuery to get dropdown element
        // Residential building  materials
        const arrayBuilding = ["Steel", "Cement", "Wood"];
        // Passenger vehicle materials
        const arrayVehicle = ["Steel", "Aluminium", "Copper"];
        dropdown.empty(); // Clear previous options before appending new ones
        dropdown.append("<option value='' disabled selected>Please select sector</option>")
        if (sectorTemp == "Residential building") {
            arrayBuilding.forEach((element) => {
                var opt = $("<option>").val(element).text(element);
                dropdown.append(opt);
            });
        } else if (sectorTemp == "Passenger vehicles") {
            console.log(sectorTemp);
            arrayVehicle.forEach((element) => {
                var opt = $("<option>").val(element).text(element);
                dropdown.append(opt);
            });
        }
    });
});

function ghgChart(data, canvasID) {
    var res = new Map(data["d"].map(obj => [obj.Key, obj.Value]));
    var values = [...new Set(Array.from(res.values()))];
    try {
        // Clear previous chart
        if (window.chart) {
            window.chart.dispose();
        }
    } catch (e) {
        console.error("Error disposing previous chart:", e);
    }     
    var dataPoints = [
        { x: "SSP2 Baseline", y: Number(values[0].toString().replace(",", ".")).toFixed(1) },
        { x: ".", y: (Number(values[1].toString().replace(",", ".")) - Number(values[0].toString().replace(",", "."))).toFixed(1) },
        { x: "Slow+Close", isTotal: true },
        { x: ",", y: (Number(values[2].toString().replace(",", ".")) - Number(values[1].toString().replace(",", "."))).toFixed() },
        { x: "Narrow+Slow+Close", isTotal: true }
    ];
    // create a waterfall chart with the data
    var chart = anychart.waterfall(dataPoints);
    
    // set the chart title
    chart.title('Cumulative GHG 2020-2060, [region], [sector]');
    chart.yAxis().title('Mt CO2-eq / year');
    // set the container id for the waterfall chart
    chart.container("GHG");
    // Enable noData label
    chart.noData().label(true);

    // draw the resulting chart
    chart.draw();
   
    window.chart = chart;
    
}

