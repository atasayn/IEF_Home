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
        $("#aspectsClass1").empty();
        $("#aspectsClass2").empty();
        $("#aspectsClass3").empty();
       
        $.ajax({
            type: "POST",
            url: "circomodService.svc/iedcDatatypesIdNumbers",
            data: `{"userselect": "${String(userInputDatatype + 1)}"} `,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {

               
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

              
                
                $("#aspects").append("<thead>" + "<tr><th>Aspects" + "</th></tr>" + "</thead><tbody>");
                for (var i = 0; i < result.d.length; i++) {

                    $("#aspects").append("<tr><td>" + result.d[i] + "</td></tr>");
                  
                }
                $("#aspects").append("</tbody>");
            }
        });
    });

    var selections = [];
    var aspect_selections = [];


    $('#aspects').on('click', 'tbody tr td', function (e) {
        
        
        var userInputClassAspect = $(this).text();
        

        i=0
        while (i < 1) {  
            
            
            if (aspect_selections.includes(userInputClassAspect)) {
                var tables = document.querySelectorAll('.grid-item-dataset table');
                for (var i = 0; i < tables.length; i++) {
                    var table = tables[i];
                    var th = table.querySelector('th');
                    if (th && th.textContent.trim() === userInputClassAspect) {
                        var tableID = table.id;
                        $('#'+tableID).empty();
                    }
                }
                aspect_selections = aspect_selections.filter(item => item !== userInputClassAspect);
                var original_color = window.getComputedStyle(e.target.parentNode).backgroundColor;
                e.target.style.background = original_color;

            } else {
                aspect_selections.push(userInputClassAspect);
                var original_color = window.getComputedStyle(e.target.parentNode).backgroundColor;
                e.target.style.background = "#ffc000";
            }

            if (aspect_selections.length == 4) {
                aspect_selections = []
                $("#aspectsClass1").empty();
                $("#aspectsClass2").empty();
                $("#aspectsClass3").empty();
                $("#dataset-preview").empty();
                $("#dataset-list").empty();
                document.getElementById("btnExport").style.display = "none";
                var evenRows = document.getElementById("aspects").querySelectorAll('tr:nth-child(even) td');
                var oddRows = document.getElementById("aspects").querySelectorAll('tr:nth-child(odd) td');

                evenRows.forEach(function (row) {
                    row.style.backgroundColor = "#dddddd";     
                });

                oddRows.forEach(function (row) {
                    row.style.backgroundColor = "white";
                });
            }
            
            i++
            
        }



        $.ajax({
            type: "POST",
            url: "circomodService.svc/iedcDatatypeClassAspects",
            data: `{ "aspectName": "${String(userInputClassAspect)}", "data_type":"${String(userInputDatatype + 1)}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {

                var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
                var values = Array.from(res.values());
                index = aspect_selections.indexOf(userInputClassAspect)

                for (i = 0; i < aspect_selections.length; i++) {

                    if (index == i) {
                        var table = "#aspectsClass" + (index + 1);
                      
                        $(table).empty();
                        $(table).append("<thead>" + "<tr><th>" + userInputClassAspect + "</th></tr>" + "</thead><tbody>");

                        for (var i = 0; i < values.length; i++) {
                            $(table).append("<tr><td>" + values[i] + "</td></tr>");

                        }
                        $(table).append("</tbody>");
                        selections[index] = { "name": userInputClassAspect || null, "selected": [] };


                    }
                }   
            }
        });
    });

    $('.grid-item-dataset table:gt(0)').on('click', 'tbody tr td', function (e) {

        $("#dataset-list").empty();
        $("#dataset-preview").empty();
        document.getElementById("btnExport").style.display = "none";
        var tbl = e.target.parentNode.parentNode.parentNode
        var tbl_index = parseInt(tbl.id.slice(-1)) - 1
        var selected_name = e.target.innerText
   
     
        if (selections[tbl_index]["selected"].includes(selected_name)) {
            // Element is already selected, delete it FROM the list AND remove background color
            selections[tbl_index]["selected"] = selections[tbl_index]["selected"].filter(item => item != selected_name);
            e.target.style.background = null;
        
        } else {
            // Add element to list AND set background color
            selections[tbl_index]["selected"].push(selected_name);
            e.target.style.background = "#ffc000";
        }

        dataList = []

        $.ajax({
            type: "POST",
            url: "circomodService.svc/iedcMatchAspects",

            data: `{ "data_type": "${String(userInputDatatype + 1)}",
            "classAspectlist1": "${String(selections[0]['selected'])}",
            "classAspectlist2": "${1 in selections ? String(selections[1]['selected']) : ""}",
            "classAspectlist3": "${2 in selections ? String(selections[2]['selected']) : ""}"
            }`,

            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result)
            {
                dataList = result.d;
                console.log(result.d.length)
                $("#dataset-list").empty();

                if (result.d.length == 0 || selections.length == 0) {
                    console.log(selections.length)
                    $("#dataset-list").append("<thead>" + "<tr><th>Data List" + "</th></tr>" + "</thead><tbody>");
                    $("#dataset-list").append("<tr><td>" + "NO DATA FOUND" + "</td></tr>");
                    $("#dataset-list").append("</tbody>");
                    $("#dataset-list").css("color", "red")
                    $("#dataset-preview").empty();
                } else {

                    $("#dataset-list").append("<thead>" + "<tr><th>Data List" + "</th></tr>" + "</thead><tbody>");
                    for (var i = 0; i < result.d.length; i++) {
                        $("#dataset-list").append("<tr><td>" + result.d[i] + "</td></tr>");
                    }
                    $("#dataset-list").append("</tbody>");
                    $("#dataset-list").css("color", "black")
                }

            }
        });
    });


    $('#dataset-list').on('click', 'tbody tr td', function (e) {
      
        var userInputDataPreview = $(this).text();
        $("#dataset-preview").empty();

        

        $.ajax({
            type: "POST",
            url: "circomodService.svc/iedcDataPreview",
            data: `{"dataset_name": "${String(userInputDataPreview)}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {

                dataList = result.d;
                let innerHtml = "<thead><tr>"
                let columnNames = [
                    "id", "dataset Name", "aspect1", "aspect2", "aspect3", "aspect4", "aspect5", "aspect6", "aspect7",
                    "aspect8", "aspect9", "aspect10", "aspect11", "aspect12", "value", "unit_nominator"
                ];
                for (const i of columnNames) {
                    innerHtml += `<th><div>${i}</div></th>`;
                }
                innerHtml += "</tr></thead><tbody><tr></tr></tbody>"
                $("#dataset-preview").append(innerHtml);
                document.getElementById("btnExport").style.display = "block";
                generateTable(result.d, 16, (result.d.length/16))

            }

        });


        function generateTable(data, columns, rows) {

            var tbody = document.querySelector("#dataset-preview tbody ");
            var index = 0;


            for (var i = 0; i < rows; i++) {
                var row = tbody.insertRow(i);
                for (var j = 0; j < columns; j++) {
                    if (index < data.length) {
                        var cell = row.insertCell(j);
                        cell.innerHTML = data[index++];
                    }
                }
            }
        }



    });


});

function ExportToExcel(type, fn, dl) {
    var elt = document.getElementById('dataset-preview');
    var wb = XLSX.utils.table_to_book(elt, { sheet: "Data" });

    // Get the first sheet in the workbook
    var ws = wb.Sheets['Data'];

    // Define a style object with bold font
    var boldStyle = {
        font: { bold: true }
    };

    // Get the range of the first row
    var firstRowRange = XLSX.utils.decode_range(ws['!ref']);
    firstRowRange.e.r = 0; // Set the end row to 0 (the first row)

    // Loop through the cells in the first row and apply the bold style
    for (var C = firstRowRange.s.c; C <= firstRowRange.e.c; ++C) {
        var cell_address = XLSX.utils.encode_cell({ r: firstRowRange.s.r, c: C });
        if (!ws[cell_address]) continue; // Skip empty cells
        ws[cell_address].s = boldStyle;
    }

    // Get the value of cell B2
    var cellB2 = ws['B2'];
    var sheetName = cellB2 ? cellB2.v : 'MySheetName'; // Use B2 value as the sheet name or fallback to 'MySheetName'

    // Export the Excel file
    return dl ?
        XLSX.write(wb, { bookType: type, bookSST: true, type: 'base64' }) :
        XLSX.writeFile(wb, fn || (sheetName + '.' + (type || 'xlsx')));
}