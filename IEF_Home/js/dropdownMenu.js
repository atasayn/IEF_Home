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


    var canvasIds = ["line-plot1", "line-plot2", "line-plot3"]; 
    function shiftCanvasIds() {
        const lastElement = canvasIds.pop();
        canvasIds.unshift(lastElement);

    }
    $('#DropDownListPlotRegion').click(function (e) {

        if ($("#LinePlot").is(":checked")) {
            var region = $("#DropDownListPlotRegion").val();
            var numOfText = canvasIds[0].match(/\d+/);
            var numOfTextNumber = parseInt(numOfText[0], 10);
            var graphElement = document.getElementById("Graph" + numOfTextNumber + "Line").style.display;
            console.log(graphElement)
            if (graphElement === "") {
                document.getElementById("Graph" + numOfTextNumber + "Line").style.display = 'block'
            }
        }
       

        $.ajax({
            type: "POST",
            url: "circomodService.svc/Classification_ResultItem",
            data: `{"SELECTedRegion": "${region}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {

                // Line-Plot
                if (region != "") {
                    document.getElementById("RegionName" + numOfTextNumber).textContent = region;
                    displayGraph(result["d"], region, canvasIds[0]);
                    shiftCanvasIds(canvasIds)
                }

            }
        });
    });
});



function displayGraph(data, region, canvasID) {
    console.log(data);
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


    $('#Sankey').change(function (e) {
        var region = $("#DropDownListPlotRegion").val();
        var scenario = "LED";
        var sector = "Residential Building";
        var startYear = 2020;
        var endYear = 2050;
        var strategy = "Baseline";
        var material = "Steel";
        var graphElement = document.getElementById("sankey").style.display;

        if (graphElement === "") {
            document.getElementById("sankey").style.display = 'block';
        }

        var sankeyDiv = document.getElementById("sankey");
        



        for (let year = startYear; year <= endYear; year++) {
            var newDiv = document.createElement("div");
            newDiv.id = "div_svg " + year;
            newDiv.style.position = 'absolute';
            // Create and append <p id="chart"> element within each div
            var chartParagraph = document.createElement("p");
            chartParagraph.id = "chart" + year;
            newDiv.appendChild(chartParagraph);

            // Append the dynamically created div to the parent div
            sankeyDiv.appendChild(newDiv);

            // Get the chartContainer directly from chartParagraph
            var chartContainer = chartParagraph;

            const svgElement = document.createElementNS("http://www.w3.org/2000/svg", "svg");
            svgElement.setAttribute("id", "target_svg_" + year); // Using underscores instead of spaces

            // Create and append <text> element for the year within the SVG
            var yearText = document.createElementNS("http://www.w3.org/2000/svg", "text");
            yearText.setAttribute("class", "label label-danger");
            yearText.textContent = year
  
            svgElement.appendChild(yearText);

            // Append the SVG to the chartContainer
            chartContainer.appendChild(svgElement);

            let divId = "target_svg" + year;
            let divSvg = newDiv.id;
            let divChart = chartParagraph.id
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
        }


    });



});