$(document).ready(function () {

    $('.DDSelectRegSce').click(function (e) {
        var region = $("#DropDownListRegion").val();
        var scenario = $("#DropDownListScenario").val();
        $.ajax({
                type: "POST",
                url: "circomodService.svc/Classification_ResultItem",
                data: `{"selectedRegion": "${region}","selectedScenario": "${scenario}"}`,
                dataType: "json",
                contentType: "application/json; charset=utf-8",
                success: function (result) {
                    
                    displayGraph(result["d"], region, scenario);
                    
                   
                }
        });
    });
});


function displayGraph(data, region, scenario) {
    console.log(data);
    let labels = Array();
    let dataset = Array();
    data.forEach(row => {
        labels.push(row[0]);
        dataset.push(parseFloat(row[1].replace(",", ".")));
    });

    try {
        Chart.getChart("line-chart").destroy();
    } catch (e) {}
    new Chart(document.getElementById("line-chart"), {
        type: 'line',
        data: {
            labels: labels,
            datasets: [{
                    data: dataset,
                    label: data[0][3],
                    borderColor: "#3e95cd",
                    fill: false                   
            }]
        },
        options: {
            locale: "fr-CA",
            title: {
                display: true,
                text: `Region ${region}, scenario ${scenario}`
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
    $('.DDSelectSankey').click(function (e) {

        var region = $("#DropDownListSankeyRegion").val();
        var scenario = $("#DropDownListSankeyScenario").val();
        var sector = $("#DropDownListSector").val();
        var year = $("#DropDownListYear").val();
        var strategy = $("#DropDownListStrategy").val();
        var material = $("#DropDownListMaterial").val();
 

        $.ajax({
            url: "circomodService.svc/Classification_SankeyItem",
            type: "POST",
            data: `{"selectedRegion": "${region}","selectedScenario": "${scenario}","selectedSector": "${sector}","selectedYear": "${year}",
                        "selectedStrategy": "${strategy}","selectedMaterial": "${material}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                var res = new Map(data["d"].map(obj => [obj.Key, obj.Value]));
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
                //text = text.replace("F_g", Math.abs(parseFloat(res.get("query_Ff")) - parseFloat(res.get("query_Fh"))));
                text = text.replace("F_h", res.get("query_Fh"));
                text = text.replace("F_i", res.get("query_Fh"));
                text = text.replace("F_j", res.get("query_Fh"));
                text = text.replace("F_k", res.get("query_Fk"));
                text = text.replace("F_l", res.get("query_Fl"));
                text = text.replace("F_m", res.get("query_Fm"));
                text = text.replace("F_n", res.get("query_Fn"));
                text = text.replace("F_o", res.get("query_Fn"));
                text = text.replace("F_p", res.get("query_Fn"));
 
                $("#input_flow_data").val(text);
                console.log(text);
                process_sankey();
                $("#input_flow_data").val(flowarea);
            }
        });
    });
});