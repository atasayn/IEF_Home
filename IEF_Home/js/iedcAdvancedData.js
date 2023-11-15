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

    var selections = [];

    $('#data-type').on('click', 'tbody tr td', function (e) {
        
        var userInputDatatype = $(this).parent().index();
        window.userInputDatatype = userInputDatatype;
        $("#aspectsClass1").empty();
        $("#aspectsClass2").empty();
        $("#aspectsClass3").empty();
        $("#dataset-list").empty();
        $("#dataset-preview").empty();
        $("#dataset-previewInfo").empty();
        
        $.ajax({
            type: "POST",
            url: "circomodService.svc/iedcDatatypesIdNumbers",
            data: `{"userselect": "${String(userInputDatatype + 1)}"} `,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {

                selections = [];
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
                if (result.d.length == 0) {
                    $("#aspects").append("<tr><td>" + "NO DATA FOUND" + "</td></tr>");
                    $("#aspects").append("</tbody>");
                } else {
                    for (var i = 0; i < result.d.length; i++) {

                        $("#aspects").append("<tr><td>" + result.d[i] + "</td></tr>");

                    }
                    $("#aspects").append("</tbody>");
                }

            }
        });
    });

   
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
                selections[tableID.slice(-1) - 1] = [];
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
                
                // Get the parent div element
                const gridItemDataset = document.querySelector('.grid-item-dataset');

                // Get all the tables within the parent div
                const tables = gridItemDataset.querySelectorAll('table');

                if (aspect_selections.includes(userInputClassAspect)) {

                    // Loop through the tables (except the first one with id "aspects")
                    for (var i = 1; i < tables.length; i++) {
                        const table = tables[i];

                        // Check if the table has no child elements (rows)
                        if (table.childElementCount === 0) {
                            $('#' + table.id).append("<thead>" + "<tr><th>" + userInputClassAspect + "</th></tr>" + "</thead><tbody>");

                            for (var i = 0; i < values.length; i++) {
                                $('#' + table.id).append("<tr><td>" + values[i] + "</td></tr>");

                            }
                            $('#' + table.id).append("</tbody>");
                            selections[table.id.slice(-1)-1] = { "name": userInputClassAspect || null, "selected": [] };

                        }
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
                $("#dataset-list").empty();
                $("#dataset-previewInfo").empty();
                if (result.d.length == 0 || selections.length == 0) {
                    
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
        $("#dataset-previewInfo").empty();
        $("#hiddentable").empty();
        $.ajax({
            type: "POST",
            url: "circomodService.svc/iedcDataPreview",
            data: `{"dataset_name": "${String(userInputDataPreview)}"}`,
            dataType: "json",
            contentType: "application/json; charset=utf-8",
            success: function (result) {
               
                var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
                var columnNames = Array.from(res.values());
                var columnTitle = Array.from(res.keys());
                console.log(columnNames)
                console.log(columnTitle)
              
                var ColumnNotNullValues = [...res.values()].filter(array =>
                    array.some(value => value !== null)
                );
                var ColumnNotNullKeys = [...res.keys()].filter(key =>
                    res.get(key).some(value => value !== null)
                );
                
                const maxLength = Math.max(...ColumnNotNullValues.slice(0,-2).map(arr => arr.length));

                const interleavedArray = [];
                for (let i = 0; i < maxLength; i++) {
                    for (const arr of ColumnNotNullValues.slice(0, -2)) {
                        if (arr[i] !== undefined) {
                            interleavedArray.push(arr[i] !== undefined ? arr[i] : null);
                        }
                    }
                }

        
                innerHtml = "<thead><tr>";
                for (var i = 0; i < ColumnNotNullKeys.slice(0, -2).length; i++) {
                    innerHtml += `<th><div>${ColumnNotNullKeys[i]}</div></th>`;
                }
                innerHtml += "</tr></thead><tbody>";
                $("#dataset-preview").append(innerHtml);


                innerHtml = "<thead><tr>";
                for (var i = 0; i < columnTitle.slice(0, -2).length; i++) {
                    innerHtml += `<th><div>${columnTitle.slice(0, -2)[i]}</div></th>`;
                }
                innerHtml += "</tr></thead><tbody><tr></tr></tbody>";
                $("#hiddentable").append(innerHtml);

          
                document.getElementById("btnExport").style.display = "block";
                var tbody = document.querySelector("#dataset-preview tbody ");
                var hiddentabletbody = document.querySelector("#hiddentable tbody");
                generateTable(interleavedArray, ColumnNotNullKeys.slice(0, -2).length, 50, tbody);

                generateTable(columnNames.at(-2), columnNames.at(-1).length, columnNames.at(-2).length / columnNames.at(-1).length, hiddentabletbody);
                // Now, you can retrieve the headers from the #dataset-preview table
                const headers1 = Array.from($("#dataset-preview th")).map(cell => cell.innerText);

                // Next, you can proceed to fetch and process the dataset-previewInfo data.
                $.ajax({
                    type: "POST",
                    url: "circomodService.svc/iedcDatasetPreview",
                    data: `{"dataset_name": "${String(userInputDataPreview)}"}`,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: function (result) {
                        var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
                        var columnNames = Array.from(res.values());
                        for (i = 0; i < columnNames[0].length; i++) {
                        // Create the table

                        var thead = $("<thead></thead>");
                        var tbody = $("<tbody></tbody>");
                        var tr = $("<tr></tr>");

                        // Create the first column (1st td)
                        var td1 = $("<th></th>").text(columnNames[0][i]);

                        // Create the second column (2nd td)
                        var td2 = $("<td></td>").text(columnNames[1][i]);

                        // Append the td elements to the tr
                        tr.append(td1, td2);

                        // Append the tr to the tbody
                        tbody.append(tr);

                        // Add the gray-row class to every second row in the second column
                        if (i % 2 === 1) {
                            td2.addClass("gray-row");
                        }

                        // Append the thead and tbody to the table
                        $("#dataset-previewInfo").append(thead, tbody);
                          

                        }
                       
                        // Create a mapping of "aspect" headers in the first table to their corresponding values in the second table
                        var headerMapping = {};
                        headers1.forEach((header, index) => {
                            if (header.startsWith("aspect_")) {
                                indexTitle = columnNames[0].indexOf(header)
                                headerMapping[header] = columnNames[1][indexTitle];
                            }
                        });

                        // Replace the "aspect" headers in the #dataset-preview table with values from the second table
                        $("#dataset-preview th").each(function () {
                            var headerText = $(this).text();
                            if (headerMapping[headerText] ) {
                                $(this).text(headerText + "\n" + headerMapping[headerText]);
                            }
                        });

                        $("#hiddentable th").each(function () {
                            var headerText = $(this).text();
                            if (headerMapping[headerText]) {
                                $(this).text(headerText + "\n" + headerMapping[headerText]);
                            }
                        });

                    }
                });
            }
        });
    });

});
function generateTable(data, columns, rows, tbody) {

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


function ExportToExcel(type, fn, dl) {
    var sheet1 = document.getElementById('dataset-previewInfo');
    var sheet2 = document.getElementById('hiddentable');
    var wb1 = XLSX.utils.table_to_book(sheet1, { sheet: "Dataset Description" });
    var wb2 = XLSX.utils.table_to_book(sheet2, { sheet: "Data" });

    // Append the second sheet to the first Workbook
    XLSX.utils.book_append_sheet(wb1, wb2.Sheets[wb2.SheetNames[0]], "Data");



    for (var sheetName in wb1.Sheets) {
        if (wb1.Sheets.hasOwnProperty(sheetName)) {
            // Get the sheet using the sheetName
            var ws = wb1.Sheets[sheetName];

            // Define a style object with bold font and centered text
            var style = {
                font: { bold: true },
                alignment: { horizontal: 'center' }
            };

            // Apply the style to the entire worksheet
            ws['!cols'] = [{ wpx: 80 }, { wpx: 80 }]; // Set column width (adjust as needed)
            ws['!rows'] = [{ hpt: 20 }]; // Set row height (adjust as needed)

            for (var cellAddress in ws) {
                if (ws.hasOwnProperty(cellAddress)) {
                    if (cellAddress === '!ref') continue; // Skip the !ref key
                    ws[cellAddress].s = style;
                }
            }
        }
    }

   
    // Get the value of cell B2
    var cellB2 = ws['B2'];
    var sheetName = cellB2 ? cellB2.v : 'MySheetName'; // Use B2 value as the sheet name or fallback to 'MySheetName'

    // Export the Excel file
    return dl ?
        XLSX.write(wb1, { bookType: type, bookSST: true, type: 'base64' }) :
        XLSX.writeFile(wb1, fn || (sheetName + '.' + (type || 'xlsx')));
}