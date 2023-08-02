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
});

$(document).ready(function () {
    $('#data-type').on('click', 'tbody tr td', function (e) {
        
        var userInputAspect = $(this).parent().index();

        $.ajax({
            type: "POST",
            url: "circomodService.svc/iedcDatatypeID",
            data: `{"userInput": "${String(userInputAspect + 1)}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
                
                $("#datasets").append("<thead>" + "<tr><th colspan='2'>Total number of datasets available for chosen data type:" + result.d.length + "</th></tr>" +
                    "<tr>" + "<th>Datasets</th>"  + "</tr>" + "</thead><tbody>");

                for (var i = 0; i < result.d.length; i++) {

                    $("#datasets").append("<tr><td>" + result.d[i] + "</td></tr>");

                }
                $("#datasets").append("</tbody>");
            }
        });
    });
});

//$(document).ready(function () {
//    $('#data-type').on('click', 'tbody tr td', function (e) {
      
//        var userInput = $(this).parent().index();
        
//        $.ajax({
//            type: "POST",
//            url: "circomodService.svc/iedcDatatypeID",
//            data: `{"userInput": "${String(userInput+1)}"}`,
//            dataType: "json",
//            contentType: "application/json; charset=utf-8",
//            success: function (result) {
               
//                $("#aspects").append("<thead>" + "<tr><th colspan='2'>Total number of datasets available for chosen data type:" + result.d.length + "</th></tr>" + 
//                    "<tr>" + "<th>Aspects</th>" + "<th>Classification Items</th>" + "</tr>" + "</thead><tbody>" );
               
//                for (var i = 0; i < result.d.length; i++) {

//                    $("#aspects").append("<tr><td>" + result.d[i] + "</td></tr>");

//                }
//                $("#aspects").append("</tbody>");
//            }
//        });
//    });
//});

