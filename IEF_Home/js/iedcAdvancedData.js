$(document).ready(function () {

    

    $.ajax({
        type: "POST",
        url: "circomodService.svc/iedcDatatype",
        dataType: "json",
        contentType: "application/json; charset=utf-8",
        success: function (result) {

            $("#data-type").append("<thead>" + "<th>Data Type</th>" + "</thead><tbody>");

            for (var i = 0; i < result.d.length; i++) {

                $("#data-type").append("<tr><td> " + result.d[i] + "</td></tr></tbody>" );

            }
       
        }

    });



    $('#data-type').on('click', 'tbody tr td', function (e) {
        
        var userInputDatatype = $(this).parent().index();
        window.userInputDatatype = userInputDatatype;

        $.ajax({
            type: "POST",
            url: "circomodService.svc/iedcDatatypesIdNumbers",
            data: `{"userSelect": "${String(userInputDatatype + 1)}"} `,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {

                console.log(result)
                $("#grid-item-datasets").append("<thead>" + "<tr><th colspan='2'>Total number of datasets available for chosen data type:" + result.d.length + "</th></tr>" +
                    "<tr>" + "<th>Datasets</th>" + "</tr>" + "</thead><tbody>");

            }
        });
    });



    $('#data-type').on('click', 'tbody tr td', function (e) {
        $("#aspects").empty();
        var userInputAspect = $(this).parent().index();
       

        $.ajax({
            type: "POST",
            url: "circomodService.svc/iedcDatatypeAspect",
            data: `{"userInput": "${String(userInputAspect + 1)}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {

                console.log(result)
                
                $("#aspects").append("<thead>" + "<tr><th>Aspects" + "</th></tr>" + "</thead><tbody>");
                for (var i = 0; i < result.d.length; i++) {

                    $("#aspects").append("<tr><td>" + result.d[i] + "</td></tr>");
                  
                }
                $("#aspects").append("</tbody>");
            }
        });
    });



    $('#aspects').on('click', 'tbody tr td', function (e) {
        
        var userInputClassAspect = $(this).text();
        console.log(userInputClassAspect)

        $.ajax({
            type: "POST",
            url: "circomodService.svc/iedcDatatypeClassAspects",
            data: `{ "aspectName": "${String(userInputClassAspect)}", "data_type":"${String(userInputDatatype + 1)}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {

                var table1 = document.getElementById("aspectsClass1").rows.length;
                var table2 = document.getElementById("aspectsClass2").rows.length;
                var table3 = document.getElementById("aspectsClass3").rows.length;

                if (table1 == 0) { 
                    $("#aspectsClass1").empty();
                    var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
                    var values = Array.from(res.values());

                    $("#aspectsClass1").append("<thead>" + "<tr><th>" + userInputClassAspect + "</th></tr>" + "</thead><tbody>");

                        for (var i = 0; i < values.length; i++) {

                            $("#aspectsClass1").append("<tr><td>" + values[i] + "</td></tr>");
                    
                        }
                    $("#aspectsClass1").append("</tbody>");

                } else if (table2 == 0 && table1 !== 0) {

                    $("#aspectsClass2").empty();
                    var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
                    var values = Array.from(res.values());

                    $("#aspectsClass2").append("<thead>" + "<tr><th>" + userInputClassAspect + "</th></tr>" + "</thead><tbody>");

                    for (var i = 0; i < values.length; i++) {

                        $("#aspectsClass2").append("<tr><td>" + values[i] + "</td></tr>");

                    }

                    $("#aspectsClass2").append("</tbody>");
                } else if (table2 !== 0 && table1 !== 0) {
                    $("#aspectsClass3").empty();
                    var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
                    var values = Array.from(res.values());

                    $("#aspectsClass3").append("<thead>" + "<tr><th>" + userInputClassAspect + "</th></tr>" + "</thead><tbody>");

                    for (var i = 0; i < values.length; i++) {

                        $("#aspectsClass3").append("<tr><td>" + values[i] + "</td></tr>");

                    }

                    $("#aspectsClass3").append("</tbody>");
                }
            }
        });
    });
});

