
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
                        displayGraph(result["d"], 86, "line-chart", `Per Capita Service Level `,'Annual pkm by passenger cars');
                    }
                }
        });
    });

});
   

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
function displayGraph(data, ylength, canvasID, title, yAxisTitle) {

    let labels = Array.from({ length: ylength }, (v, i) => 2015 + i);
    try {
        Chart.getChart(canvasID).destroy();
    } catch (e) { }
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
}


function barChart(data, canvasID) {

    var res = new Map(data["d"].map(obj => [obj.Key, obj.Value]));
    var values = [...new Set(Array.from(res.values()))];

    console.log(values)
    try {
        Chart.getChart(canvasID).destroy();
    } catch (e) { }
    new Chart(document.getElementById(canvasID), {

        type: 'bar',
        data: {
            labels: ["SSP2 + Baseline", "SSP2 + Full CE", "LED + Full CE" ],
            datasets: [{
                label: 'Primary Production',
                backgroundColor: "blue",
                data: [values[0].slice(-1), values[1].slice(-1), values[2].slice(-1)],
            }, {
                label: 'Secondary Production',
                backgroundColor: "green",
                data: [values[3].slice(-1), values[4].slice(-1), values[5].slice(-1)],
            }],
        },
        options: {
            plugins: {
                title: {
                    display: true,
                    text: 'Production between 2020-2060'
                },
            },
            scales: {
                x: {
                    stacked: true,
                },
                y: {
                    stacked: true,
                    title: {
                        display: true,
                        text: 'Tg/year',

                    },
                }
            }
        } 

    });
};


