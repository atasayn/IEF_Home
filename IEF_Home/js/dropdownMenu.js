$(document).ready(function () {

    $('.DDSelectRegSce').click(function (e) {
        var region = $("#DropDownListRegion").val();
        console.log(region);
        $.ajax({
                type: "POST",
                url: "circomodService.svc/Classification_ResultItem",
                data: `{"SELECTedRegion": "${region}"}`,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (result) {

                    if(region!=""){
                    displayGraph(result["d"], region, "line-chart");
                    }
                }
        });
    });

});
    

function displayGraph(data, region, canvasID) {
   
    let labels = Array.from({ length: 86 }, (v, i) => 2015 + i);

    try {
        Chart.getChart(canvasID).destroy();
    } catch (e) {}
    new Chart(document.getElementById(canvasID), {
        type: 'line',
        data: {
            labels: labels,
            datasets: [
                {
                    data: data[0],
                    label: "LED",
                    borderColor: "#ff0000",
                    fill: false                   
                },
                {
                    data: data[1],
                    label: "SSP1",
                    borderColor: "#00ff00",
                    fill: false
                },
                {
                    data: data[2],
                    label: "SSP2",
                    borderColor: "#0000ff",
                    fill: false
                }
            ]
        },
        options: {
            locale: "fr-CA",
            title: {
                display: true,
                text: `Region ${region}`
            },
            scales: {
                y: {
                    title: {
                        display: true,
                        text: 'Annual person-km by passenger cars'
                    }
                },
                x: {
                    title: {
                        display: true,
                        text: 'Year'
                    },
                    ticks: {
                        autoSkip: true,
                        maxTicksLimit: 20
                    }                    
                }
            }           
        }
    });
}

$(document).ready(function () {
    $('.DDSelectSankey').click(function(e) {
        var region = $("#DropDownListSankeyRegion").val();
        var scenario = $("#DropDownListSankeyScenario").val();
        var sector = $("#DropDownListSector").val();
        var year = $("#DropDownListYear").val();
        var strategy = $("#DropDownListStrategy").val();
        var material = $("#DropDownListMaterial").val();

        allFields = [region, scenario, sector, year, strategy, material];
        console.log(allFields)
        if (allFields.includes("")) {
            var message = document.getElementById("errorMsg");
            message.textContent = "SELECT one parameter FROM each dropdown menu";
            message.style.color = "#ff6666";
        } else if (!(allFields.includes(""))) {
            var message = document.getElementById("errorMsg");
            message.textContent = "";
        }

        $.ajax({
            url: "circomodService.svc/Classification_SankeyItem",
            type: "POST",
            data: `{"SELECTedRegion": "${region}","SELECTedScenario": "${scenario}","SELECTedSector": "${sector}","SELECTedYear": "${year}",
                        "SELECTedStrategy": "${strategy}","SELECTedMaterial": "${material}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                var res = new Map(data["d"].map(obj => [obj.Key, obj.Value.replace(",",".")]));

                console.log(res);
                var flowarea = $("#input_flow_data").val();
                var text = flowarea;
                console.log(text);

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
                text = text.replace("F_k", res.get("query_Fk")/50);
                text = text.replace("F_l", res.get("query_Fl")/50);
                text = text.replace("F_m", res.get("query_Fm")/50);
                text = text.replace("F_n", res.get("query_Fn"));
                text = text.replace("F_o", res.get("query_Fn"));
                text = text.replace("F_p", res.get("query_Fn")); 
                $("#input_flow_data").val(text);
                console.log(text);
                if (allFields.every(element => element !== "")) {
                    process_sankey();
                }
                $("#input_flow_data").val(flowarea);
         
            }
        });
    });

});
$(document).on('click', '.svgMap-country', function () {
    
        var region = document.getElementById("countryFlagSpan").innerHTML;
        $.ajax({
            type: "POST",
            url: "circomodService.svc/Classification_ResultItem",
            data: `{"SELECTedRegion": "${region}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                if (region != "") {
                    document.getElementById("RegionName1").textContent = region;
                    displayGraph(result["d"], region, "line-plot1");
                }
            }
        });

    document.getElementById('sankey').innerHTML = "";
    var scenario = "LED";
    var sector = "Residential Building";
    var startYear = 2020;
    var endYear = 2030;
    var strategy = "Baseline";
    var material = "Steel";

    document.getElementById("scenerioSpan").innerHTML = scenario
    document.getElementById("sectorSpan").innerHTML = sector
    document.getElementById("yearSpan").innerHTML = startYear + "-" + endYear
    document.getElementById("strategySpan").innerHTML = strategy
    document.getElementById("materialSpan").innerHTML = material
    var graphElement = document.getElementById("sankey").style.display;

    if (graphElement === "") {
        document.getElementById("sankey").style.display = 'block';
    }
    var sankeyDiv = document.getElementById("sankey");
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


//$(document).on(' click', '.svgMap-country', function (e) {

//    var region = document.getElementById("countryFlagSpan").innerHTML;
//    document.getElementById('sankey').innerHTML = "";
//    var scenario = "LED";
//    var sector = "Residential Building";
//    var startYear = 2020;
//    var endYear = 2030;
//    var strategy = "Baseline";
//    var material = "Steel";

//    document.getElementById("scenerioSpan").innerHTML = scenario
//    document.getElementById("sectorSpan").innerHTML = sector
//    document.getElementById("yearSpan").innerHTML = startYear + "-" + endYear
//    document.getElementById("strategySpan").innerHTML = strategy
//    document.getElementById("materialSpan").innerHTML = material
//    var graphElement = document.getElementById("sankey").style.display;

//    if (graphElement === "") {
//        document.getElementById("sankey").style.display = 'block';
//    }
//    var sankeyDiv = document.getElementById("sankey");
//    var buttonDiv = document.createElement("div");
//    buttonDiv.style.position = "absolute";
//    // Create <a> elements
//    var previousLink = document.createElement("button");
//    previousLink.className = "button ";
//    previousLink.type = "button";
//    previousLink.textContent = ">>";
//    previousLink.setAttribute("onclick", "navigateFront()");

//    var nextLink = document.createElement("button");
//    nextLink.className = "button ";
//    nextLink.type = "button";
//    nextLink.textContent = "<<";
//    nextLink.setAttribute("onclick", "navigateBack()");       
//    // Append <a> elements to the "sankey" div
//    buttonDiv.appendChild(previousLink);
//    buttonDiv.appendChild(nextLink); 
//        for (let year = startYear; year <= endYear; year++) {
//            var newDiv = document.createElement("div");
//            newDiv.id = "div_svg" + year;
//            newDiv.style.position = 'absolute';
//            // Create and append <p id="chart"> element within each div
//            var chartParagraph = document.createElement("p");
//            chartParagraph.id = "chart" + year;
//            newDiv.appendChild(chartParagraph);
//            // Append the dynamically created div to the parent div
//            sankeyDiv.appendChild(newDiv);
//            //Create Div for Span and Span for the year text
//            var spanDiv = document.createElement("div");
//            var newSpan = document.createElement("span");
//            newSpan.id = "span_svg" + year;
//            newSpan.innerHTML = year;
//            newSpan.style.width = "50px";
//            newSpan.style.position = "absolute";
//            newSpan.style.bottom = 0;
//            spanDiv.appendChild(newSpan);
//            sankeyDiv.appendChild(spanDiv);
//            if (newDiv.id == "div_svg" + startYear && newSpan.id == "span_svg" + startYear) {
//                newDiv.style.visibility = "visible"
//                newSpan.style.visibility = "visible"
//            } else {
//                newDiv.style.visibility = "hidden"
//                newSpan.style.visibility = "hidden"
//            }
//            // Get the chartContainer directly from chartParagraph
//            var chartContainer = chartParagraph;

//            const svgElement = document.createElementNS("http://www.w3.org/2000/svg", "svg");
//            svgElement.setAttribute("id", "target_svg" + year); // Using underscores instead of spaces

//            // Append the SVG to the chartContainer
//            chartContainer.appendChild(svgElement);

//            let divId = "target_svg" + year
//            let divSvg = newDiv.id
//            let divChart = chartParagraph.id;

//                $.ajax({
//                    url: "circomodService.svc/Classification_SankeyItem",
//                    type: "POST",
//                    data: `{"SELECTedRegion": "${region}","SELECTedScenario": "${scenario}","SELECTedSector": "${sector}","SELECTedYear": "${year}",
//                        "SELECTedStrategy": "${strategy}","SELECTedMaterial": "${material}"}`,
//                    dataType: "json",
//                    contentType: "application/json; charset=utf-8",

//                    success: function (data) {

//                        var res = new Map(data["d"].map(obj => [obj.Key, obj.Value.replace(",", ".")]));
//                        var flowarea = $("#input_flow_data").val();
//                        var text = flowarea;
//                        text = text.replace("F_a", res.get("query_Fa"));
//                        text = text.replace("F_b", Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh"))));
//                        text = text.replace("F_c", res.get("query_Fc"));
//                        text = text.replace("F_d", res.get("query_Fc"));
//                        text = text.replace("F_e", res.get("query_Fc"));
//                        text = text.replace("F_f", res.get("query_Ff"));
//                        text = text.replace("F_g", Math.abs(parseFloat(res.get("query_Ff")) - parseFloat(res.get("query_Fh"))));
//                        text = text.replace("F_h", res.get("query_Fh"));
//                        text = text.replace("F_i", res.get("query_Fh"));
//                        text = text.replace("F_j", res.get("query_Fh"));
//                        text = text.replace("F_k", res.get("query_Fk") / 50);
//                        text = text.replace("F_l", res.get("query_Fl") / 50);
//                        text = text.replace("F_m", res.get("query_Fm") / 50);
//                        text = text.replace("F_n", res.get("query_Fn"));
//                        text = text.replace("F_o", res.get("query_Fn"));
//                        text = text.replace("F_p", res.get("query_Fn"));
//                        $("#input_flow_data").val(text);
//                        process_sankey(divId, divSvg, divChart);
//                        $("#input_flow_data").val(flowarea);  
//                    }

//                });
//            sankeyDiv.appendChild(buttonDiv);    
//        }
    
//});

function createDiv(sankeyDiv, year, startYear) {
    // Create 1st Div for the year
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
    return ["target_svg" + year, newDiv.id, chartParagraph.id]
}
