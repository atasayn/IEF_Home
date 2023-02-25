$(document).ready(function () {
    $('.DDSelectRegSce').click(function (e) {
        var region = $("#DropDownListRegion").val();
        var scenario = $("#DropDownListScenario").val();
            $.ajax(            {
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
        dataset.push(row[1]);
    });

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