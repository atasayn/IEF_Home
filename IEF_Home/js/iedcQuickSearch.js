    
    //    function showLoadingIcon() {
    //        document.getElementById("loadingIcon").style.display = "block";
    //    }

    //    function hideLoadingIcon() {
    //        document.getElementById("loadingIcon").style.display = "none";
    //    }

    //    function generateTable(data, colCount, maxRows, tbody) {
    //        tbody.innerHTML = "";
    //        const rows = Math.min(maxRows, Math.floor(data.length / colCount));
    //        for (let r = 0; r < rows; r++) {
    //            const tr = document.createElement("tr");
    //            for (let c = 0; c < colCount; c++) {
    //                const td = document.createElement("td");
    //                const idx = r * colCount + c;
    //                td.textContent = data[idx] !== undefined ? data[idx] : "";
    //                tr.appendChild(td);
    //            }
    //            tbody.appendChild(tr);
    //        }
    //    }

    //    // Global variables to store full dataset for Excel
    //    window.fullDatasetForExcel = [];
    //    window.fullDatasetColumns = [];

    //    function cellClicked(cell) {
    //        showLoadingIcon();
    //        var userInputDataPreview = $(cell).text();
    //        console.log(userInputDataPreview);
    //        $("#dataset-preview").empty();
    //        $("#dataset-previewInfo").empty();
    //        $(".grid-dataset-preview").css("display", "block");
    //        $(".grid-dataset-previewInfo").css("display", "block");

    //        $.ajax({
    //            type: "POST",
    //            url: "/circomodService.svc/iedcDataPreview",
    //            data: JSON.stringify({ dataset_name: userInputDataPreview }),
    //            dataType: "json",
    //            contentType: "application/json; charset=utf-8",
    //            success: function (result) {
    //                hideLoadingIcon();
    //                var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
    //                var columnNames = Array.from(res.values());
    //                var columnTitle = Array.from(res.keys());

    //                var ColumnNotNullValues = [...res.values()].filter(array =>
    //                    array.some(value => value !== null)
    //                );
    //                var ColumnNotNullKeys = [...res.keys()].filter(key =>
    //                    res.get(key).some(value => value !== null)
    //                );

    //                // --- Store full dataset for Excel ---
    //                window.fullDatasetForExcel = [];
    //                window.fullDatasetColumns = ColumnNotNullKeys.slice(0, -2); // same as preview
    //                const maxLength = Math.max(...ColumnNotNullValues.slice(0, -2).map(arr => arr.length));
    //                for (let i = 0; i < maxLength; i++) {
    //                    for (const arr of ColumnNotNullValues.slice(0, -2)) {
    //                        window.fullDatasetForExcel.push(arr[i] !== undefined ? arr[i] : null);
    //                    }
    //                }

    //                // --- Build preview table (50 rows) ---
    //                innerHtml = "<thead><tr>";
    //                for (var i = 0; i < ColumnNotNullKeys.slice(0, -2).length; i++) {
    //                    innerHtml += `<th><div>${ColumnNotNullKeys[i]}</div></th>`;
    //                }
    //                innerHtml += "</tr></thead><tbody>";
    //                $("#dataset-preview").append(innerHtml);

    //                document.getElementById("btnExport").style.display = "block";
    //                document.getElementById("fltrData").style.display = "block";
    //                var tbody = document.querySelector("#dataset-preview tbody ");
    //                generateTable(window.fullDatasetForExcel, window.fullDatasetColumns.length, 50, tbody);

    //                // --- Dataset info (same as original) ---
    //                const headers1 = Array.from($("#dataset-preview th")).map(cell => cell.innerText);
    //                $.ajax({
    //                    type: "POST",
    //                    url: "circomodService.svc/iedcDatasetPreview",
    //                    data: `{"dataset_name": "${String(userInputDataPreview)}"}`,
    //                    dataType: "json",
    //                    contentType: "application/json; charset=utf-8",
    //                    success: function (result) {
    //                        var res = new Map(result["d"].map(obj => [obj.Key, obj.Value]));
    //                        var columnNames = Array.from(res.values());
    //                        document.getElementById('<%= hdnVal.ClientID %>').value = columnNames[1][0];

    //                for (i = 0; i < columnNames[0].length; i++) {
    //                    var thead = $("<thead></thead>");
    //                    var tbody = $("<tbody></tbody>");
    //                    var tr = $("<tr></tr>");
    //                    var td1 = $("<th></th>").text(columnNames[0][i]);
    //                    var td2 = $("<td></td>").text(columnNames[1][i]);
    //                    tr.append(td1, td2);
    //                    tbody.append(tr);
    //                    if (i % 2 === 1) td2.addClass("gray-row");
    //                    $("#dataset-previewInfo").append(thead, tbody);
    //                }

    //                var headerMapping = {};
    //                headers1.forEach((header, index) => {
    //                    if (header.startsWith("aspect_")) {
    //                        indexTitle = columnNames[0].indexOf(header);
    //                        headerMapping[header] = columnNames[1][indexTitle];
    //                    }
    //                });

    //                $("#dataset-preview th").each(function () {
    //                    var headerText = $(this).text();
    //                    if (headerMapping[headerText]) {
    //                        $(this).text(headerText + "\n" + headerMapping[headerText]);
    //                    }
    //                });
    //            }
    //        });
    //    }
    //});
    //    }

        // --- Export to Excel ---
        function ExportToExcel() {
            const workbook = new ExcelJS.Workbook();

            // --- Sheet1: Dataset Description ---
            const sheet1 = workbook.addWorksheet('Dataset Description');

            // KEEP THIS ENTIRE SECTION EXACTLY AS YOUR ORIGINAL CODE
            sheet1.getColumn(2).width = 40;
            sheet1.getColumn(3).width = 30;
            sheet1.getColumn(4).width = 50;

            sheet1.mergeCells('B2:D2');
            const titleCell = sheet1.getCell('B2');
            titleCell.value = 'Dataset Information';
            titleCell.alignment = { horizontal: 'center', vertical: 'middle', wrapText: true, shrinkToFit: true };
            titleCell.font = { bold: true };
            titleCell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: 'FFD9D9D9' } };

            sheet1.getCell('C3').value = 'Dataset descriptors';
            sheet1.getCell('D3').value = 'Dataset description from IEDC dataset catalogue';
            sheet1.getCell('C3').font = { bold: true };
            sheet1.getCell('D3').font = { bold: true };

            const headerBorderStyle = {
                top: { style: 'thin', color: { argb: 'FF000000' } },
                left: { style: 'thin', color: { argb: 'FF000000' } },
                bottom: { style: 'thin', color: { argb: 'FF000000' } },
                right: { style: 'thin', color: { argb: 'FF000000' } }
            };

            ['B4', 'C4', 'D4'].forEach(cellAddress => {
                const cell = sheet1.getCell(cellAddress);
                cell.border = headerBorderStyle;
                cell.alignment = { wrapText: true, shrinkToFit: true, vertical: 'middle' };
            });

            const mergedRegions = [
                { range: 'B4:B6', text: 'Identification', color: '#F4CCCC' },
                { range: 'B7:B10', text: 'Grouping', color: '#FCE5CD' },
                { range: 'B11:B20', text: 'System location: What elements and objects in the system are described?', color: '#FCF2CC' },
                { range: 'B21:B25', text: 'Description', color: '#D9EAD3' },
                { range: 'B26:B52', text: 'Data model for this dataset: Aspects, classifications, tuple notation, and semantic strings.', color: '#D0E0E3' },
                { range: 'B53:B60', text: 'Data access and licence', color: '#C9DAF8' },
                { range: 'B61:B67', text: 'Data submission, review, and conversion info', color: '#CFE2F3' },
                { range: 'B68:B72', text: 'Reserve – currently not used.', color: '#EEECE1' }
            ];

            function convertColor(hex) {
                const rgb = hex.replace('#', '');
                return `FF${rgb.toUpperCase()}`;
            }

            mergedRegions.forEach(region => {
                sheet1.mergeCells(region.range);
                const cell = sheet1.getCell(region.range.split(":")[0]);
                cell.value = region.text;
                cell.alignment = { vertical: 'middle', horizontal: 'center', wrapText: true, shrinkToFit: true };
                cell.fill = { type: 'pattern', pattern: 'solid', fgColor: { argb: convertColor(region.color) } };
                cell.font = { bold: true };
            });

            const table1 = document.getElementById('dataset-previewInfo');
            const rowOffset = 4;
            const colOffset = 3;
            for (let i = 0; i < table1.rows.length; i++) {
                const row = table1.rows[i];
                for (let j = 0; j < row.cells.length; j++) {
                    const cell = sheet1.getCell(i + rowOffset, j + colOffset);
                    cell.value = row.cells[j].innerText;
                    cell.alignment = { wrapText: true, shrinkToFit: true, vertical: 'middle' };
                }
            }

            const lastRow = table1.rows.length + rowOffset - 1;
            const outerBorderStyle = { style: 'thin', color: { argb: 'FF000000' } };
            for (let i = 3; i <= lastRow; i++) {
                for (let j = 2; j <= 4; j++) {
                    const cell = sheet1.getCell(i, j);
                    cell.border = {
                        top: i === 3 ? outerBorderStyle : undefined,
                        bottom: i === lastRow ? outerBorderStyle : undefined,
                        left: j === 2 ? outerBorderStyle : undefined,
                        right: j === 4 ? outerBorderStyle : undefined,
                    };
                }
            }

            // --- Sheet2: Data ---
            const sheet2 = workbook.addWorksheet('Data');

            const colCount = window.fullDatasetColumns.length;

            // Add headers
            window.fullDatasetColumns.forEach((header, j) => {
                const cell = sheet2.getCell(1, j + 1);
                cell.value = header;
                cell.font = { bold: true };
            });

            // Add all rows
            const totalRows = Math.floor(window.fullDatasetForExcel.length / colCount);
            for (let r = 0; r < totalRows; r++) {
                for (let c = 0; c < colCount; c++) {
                    const idx = r * colCount + c;
                    sheet2.getCell(r + 2, c + 1).value = window.fullDatasetForExcel[idx];
                }
            }

            // --- Save Excel ---
            const cellD5 = sheet1.getCell('D5');
            const text = cellD5.text || cellD5.value || '';
            const fileName = text ? text + '.xlsx' : 'export.xlsx';

            workbook.xlsx.writeBuffer().then(buffer => {
                const blob = new Blob([buffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
                saveAs(blob, fileName);
            });
        }

        //// --- Helper: generateTable for preview ---
        //function generateTable(data, colCount, maxRows, tbody) {
        //    tbody.innerHTML = "";
        //    const rows = Math.min(maxRows, Math.floor(data.length / colCount));
        //    for (let r = 0; r < rows; r++) {
        //        const tr = document.createElement("tr");
        //        for (let c = 0; c < colCount; c++) {
        //            const td = document.createElement("td");
        //            const idx = r * colCount + c;
        //            td.textContent = data[idx] !== undefined ? data[idx] : "";
        //            tr.appendChild(td);
        //        }
        //        tbody.appendChild(tr);
        //    }
        //}
        //var previouslyhighlightedcell = null;

        //function highlightcell(cell) {
        //    // reset the previously highlighted cell
        //    if (previouslyhighlightedcell) {
        //        previouslyhighlightedcell.style.backgroundcolor = ''; // or set to the original color if it's not empty string
        //    }

        //    // highlight the new cell
        //    cell.style.backgroundcolor = 'orange';

        //    // update the reference
        //    previouslyhighlightedcell = cell;
        //}


