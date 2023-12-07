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
   
        var region = $("#DropDownListPlotRegion").val();
        var numOfText = canvasIds[0].match(/\d+/);
        var numOfTextNumber = parseInt(numOfText[0], 10);
        var graphElement = document.getElementById("Graph" + numOfTextNumber + "Line").style.display;
        console.log(graphElement)
        if (graphElement === "") {
            document.getElementById("Graph" + numOfTextNumber + "Line").style.display = 'block'
            console.log("bok")
        }

        $.ajax({
            type: "POST",
            url: "circomodService.svc/Classification_ResultItem",
            data: `{"SELECTedRegion": "${region}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                console.log(numOfTextNumber)
                if (region != "") {
                    document.getElementById("RegionName" + numOfTextNumber).textContent = region;
                    displayGraph(result["d"], region, canvasIds[0]);
                    displayGraph(result["d"], region, "line-plot-maximized");
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
});