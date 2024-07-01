
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
                        displayGraph(result["d"], "line-chart", `Per Capita Service Level`,'Annual pkm by passenger cars');
                    }
                }
        });
    });

});
const graphs = {};
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
function displayGraph(data, canvasID, title, yAxisTitle) {
    var canvasElement = document.getElementById("NoData" + canvasID);
    try {
        Chart.getChart(canvasID).destroy();
    } catch (e) { }

    if (data.every(subarray => subarray.length === 0)) {
        canvasElement.style.display = "flex";
    } else {
        canvasElement.style.display = "none";
        let labels = data[1];
        var lineGraph = new Chart(document.getElementById(canvasID), {
            type: 'line',
            data: {
                labels: labels,
                datasets: [
                    {
                        data: data[0],
                        label: "LED",
                        backgroundColor: "#1b9e77",
                        borderColor: '#1b9e77'
                        , fill: false
                    },
                    {
                        data: data[2],
                        label: "SSP1",
                        backgroundColor: "#d95f02",
                        borderColor: '#d95f02',
                        fill: false
                    },
                    {
                        data: data[4],
                        label: "SSP2",
                        backgroundColor: "#7570b3",
                        borderColor: '#7570b3',
                        fill: false
                    }
                ]
            },
            options: {
                locale: "fr-CA",
                plugins: {
                    title: {
                        display: true,
                        text: title,
                    }
                },
                scales: {

                    y: {
                        title: {
                            display: true,
                            text: yAxisTitle,

                        },
                    },
                    x: {
                        title: {
                            display: true,
                            text: 'Year',

                        },
                        ticks: {
                            autoSkip: true,
                            maxTicksLimit: 20
                        }
                    }
                }
            }
        });
        // Return both line graphs as properties of an object

        if (title === "Total Population by scenario (million)") {
            graphs.populationLine = lineGraph;
            return graphs;
        } else if (title === "Per Capita Service Level") {
            graphs.scenarioLine = lineGraph;
            return graphs;
        }

    }
}




