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
            var flagContainer = document.getElementById("countryFlag");
            var imgElement = document.getElementById("singleCountryImg");
            var countryName = document.getElementById("countryFlagSpan");
            
            $('.svgMap-country').off('click').on('click', function (e) {
                proxyWarning.innerHTML = ""
                //Fetch json for ISO codes 
                const filePath = "json/countryProxy.json";
                fetch(filePath)
                    .then(response => response.json())
                    .then(function (response) {
                        const findFlagAndData = response.find(obj => obj.ISO === countryID.toUpperCase()); 
                        var name = svgMap.prototype.countries[countryID]
                        if (findFlagAndData.Flag == true) {
                            var sankeyProxy = document.getElementById("controlPanel");
                            var proxyWarning = document.getElementById("proxyWarning");
                            countryName.innerHTML = name + " (" + findFlagAndData.Data + ")";
                            var region = findFlagAndData.Data;
                            proxyWarning.innerHTML = "Sorry, no data for <span style='color:red'>" + name + "</span>, here, the data for the proxy region<span style='color:green'> " + findFlagAndData.Data + "</span> are shown"
                            return region
                        } else {
                            countryName.innerHTML = name;
                            var region = name;
                            return region
                        }
                    })

                    .then(function (region) {
                    //Create divs for multiple sankey graphs for the buttons
                    flagContainer.children.innerHTML = ""
                    imgElement.src = "https://cdn.jsdelivr.net/gh/hjnilsson/country-flags@latest/svg/" + countryID.toLowerCase() + ".svg";
                    imgElement.setAttribute("height", 30)
                    imgElement.style.border = "outset";

                    document.getElementById(idValue).setAttribute('fill', null)
                    idValue = e.target.id;
                    document.getElementById(idValue).setAttribute('fill', 'blue');

                    const url1 = "https://api.worldbank.org/v2/country/" + countryID.toLowerCase() + "/indicators/SP.POP.TOTL?format=json"; //GDP
                    const url2 = "https://api.worldbank.org/v2/country/" + countryID.toLowerCase() + "/indicators/NY.GDP.MKTP.CD?format=json"; //Population
                    const url3 = "https://api.worldbank.org/v2/country/" + countryID.toLowerCase() + "/indicators/EN.POP.DNST?format=json"; //PopulationDensity
                    url.push(url1, url2, url3)
                    var popSpan = document.getElementById("population");
                    var gdpSpan = document.getElementById("gdp");
                    var populationDensitySpan = document.getElementById("populationDensity");
                    url.forEach((element) =>
                        fetchCountryData(element, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3)
                    )
                    // Sankey Parameters
                    var scenario = "LED";
                    var startYear = 2020;
                    var endYear = 2060;
                    // Sankey Sector Parameter
                        var sectorTemp = $('#DropDownListSector').val();
                        var material = $('#DropDownListMaterial').val();
                        // AJAX call for Population
                        $.ajax({
                            type: "POST",
                            url: "circomodService.svc/Classification_ResultItemPopulation",
                            data: `{"SELECTedRegion": "${region}"}`,
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (result) {
                                if (region != "") {
                                  
                                    document.getElementById("RegionName2").textContent = region;
                                    displayGraph(result["d"], 2062-2015, "line-plot2", `Population`, 'Total Population');

                                }
                            }
                        });
                        $('.loader2').css("display", "block");
                        // AJAX call for Bar Graph Primary/Secondary Production
                        $.ajax({
                            type: "POST",
                            url: "circomodService.svc/Classification_Result1stAnd2ndProd",
                            data: `{"selectedRegion": "${region}","selectedSector": "${sectorTemp}","selectedMaterial": "${material}"}`,
                            dataType: "json",
                            contentType: "application/json; charset=utf-8",
                            success: function (result) { 
                                $('.loader2').hide();
                                if (region != "") {

                                    barChart(result, "line-plot3")
                                }
                            }
                        });

                        // AJAX call for Line Graph for "Per Capita Service Level"
                        if (sectorTemp == "Residential building") {
                            var sector = sectorTemp;
                            $.ajax({
                                type: "POST",
                                url: "circomodService.svc/Classification_ResultItemBuilding",
                                data: `{"SELECTedRegion": "${region}"}`,
                                dataType: "json",
                                contentType: "application/json; charset=utf-8",
                                success: function (result) {
                                    if (region != "") {
                                        document.getElementById("RegionName1").textContent = region;
                                        displayGraph(result["d"], 86, "line-plot1", `Per Capita Service Level `, 'm²/cap ');
                                    }
                                }
                            });
                        } else {
                            var sector = "Passenger Vehicles";
                            $.ajax({
                                type: "POST",
                                url: "circomodService.svc/Classification_ResultItem",
                                data: `{"SELECTedRegion": "${region}"}`,
                                dataType: "json",
                                contentType: "application/json; charset=utf-8",
                                success: function (result) {
                                    if (region != "") {
                                        document.getElementById("RegionName1").textContent = region;
                                        displayGraph(result["d"], 86, "line-plot1", `Per Capita Service Level `, 'Annual pkm by passenger cars');
                                    }
                                }
                            });
                        }


                    // Sankey Parameters
                    var strategy = "Baseline";
                    var material = "Steel";
                    document.getElementById('sankeyDivsAll').innerHTML = "";
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
                    for (let year = startYear; year <= endYear; year+=10) {
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
                        newSpan.innerHTML = year;
                        newSpan.style.width = "50px";
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
                        // Sankey AJAX call
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
                                text = text.replace("F_n", res.get("query_Fn"));
                                text = text.replace("F_o", res.get("query_Fn"));
                                text = text.replace("F_p", res.get("query_Fn"));
                                $("#input_flow_data").val(text);
                                process_sankey(divId, divSvg, divChart);

                                $("#input_flow_data").val(flowarea);
                            }

                        });
                        sankeyDiv.appendChild(buttonDiv);
                    }
                });
            });
        }
    });
});
$(window).on('load', function () {

    var region = "Germany";
    // AJAX call for Population
    $.ajax({
        type: "POST",
        url: "circomodService.svc/Classification_ResultItemPopulation",
        data: `{"SELECTedRegion": "${region}"}`,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            if (region != "") {

                document.getElementById("RegionName2").textContent = region;
                displayGraph(result["d"], 2062 - 2015, "line-plot2", `Population`, 'Total Population');

            }
        }
    });



    $.ajax({
        type: "POST",
        url: "circomodService.svc/Classification_ResultItem",
        data: `{"SELECTedRegion": "${region}"}`,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            if (region != "") {
                document.getElementById("RegionName1").textContent = region;
                displayGraph(result["d"], 86, "line-plot1", `Per Capita Service Level `, 'Annual pkm by passenger cars');
            }
        }
    });



    var scenario = "LED";
    var sector = "Passenger Vehicles";
    var startYear = 2020;
    var endYear = 2030;
    var strategy = "Baseline";
    var material = "Steel";
    $('.loader2').css("display", "block");
    $.ajax({
        type: "POST",
        url: "circomodService.svc/Classification_Result1stAnd2ndProd",
        data: `{"selectedRegion": "${region}","selectedSector": "${sector}","selectedMaterial": "${material}"}`,
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (result) {
            $('.loader2').hide();
            if (region != "") {

                barChart(result, "line-plot3")
            }
        }
    });

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
    $('.loader').css("display", "block");
    for (let year = startYear; year <= endYear; year++) {
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
        newSpan.innerHTML = year;
        newSpan.style.width = "50px";
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
                text = text.replace("F_n", res.get("query_Fn"));
                text = text.replace("F_o", res.get("query_Fn"));
                text = text.replace("F_p", res.get("query_Fn"));
                $("#input_flow_data").val(text);
                process_sankey(divId, divSvg, divChart);
                $("#input_flow_data").val(flowarea);
            }

        });
        sankeyDiv.appendChild(buttonDiv);
    }
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

    document.getElementById("svgMap-map-country-DE").setAttribute('fill', 'blue');

    var url = [];
    const url1 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/SP.POP.TOTL?format=json"; //GDP
    const url2 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/NY.GDP.MKTP.CD?format=json"; //Population
    const url3 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/EN.POP.DNST?format=json"; //PopulationDensity
    url.push(url1, url2, url3)
    var popSpan = document.getElementById("population");
    var gdpSpan = document.getElementById("gdp");
    var populationDensitySpan = document.getElementById("populationDensity");
    url.forEach((element) =>
        fetchCountryData(element, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3)
    )
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
                    gdpSpan.innerHTML = "&#8226" + " " + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "(" + date + ")"
                    break
                } else if (data[1][n]["value"] != null && url == url2) {
                    var value = data[1][n]["value"]
                    var date = data[1][n]["date"]
                    popSpan.innerHTML = "&#8226" + " " + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "(" + date + ")"
                    break

                } else if (data[1][n]["value"] != null && url == url3) {
                    var value = data[1][n]["value"]
                    var date = data[1][n]["date"]
                    populationDensitySpan.innerHTML = "&#8226" + " " + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "(" + date + ")"
                    break
                }
                n++             
            }
        },

    });
}
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