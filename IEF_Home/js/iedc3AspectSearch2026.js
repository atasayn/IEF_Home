// IEDC 3-aspect search (2026, stepwise version).
// State machine mirrors iedc_3_aspect_search_2026.py: data type -> up to 3x (aspect -> label),
// each choice narrows the candidate dataset id list and any later choice is reset when an
// earlier one changes ("hierarchical reset").

var state = {
    dataType: null,
    steps: [] // steps[i] = { aspectId, aspectName, label, candidateIds }
};

$(document).ready(function () {
    loadDataTypes();
});

// ---------------------------------------------------------------------------
// Generic helpers
// ---------------------------------------------------------------------------

function mapToEntries(d) {
    if (!d) return [];
    return d.map(function (obj) { return [obj.Key, obj.Value]; });
}

function updateRowColors(table) {
    table.find('tbody tr').css('background-color', '');
    table.find('tbody tr:visible').each(function (index) {
        if (index % 2 === 0) {
            $(this).css('background-color', '#dddddd');
        }
    });
}

function buildSelectableTable($table, headerText, entries, onSelect) {
    $table.empty();
    $table.append('<thead><tr><th>' + headerText + '</th></tr>' +
        '<tr><th style="display: flex; gap: 10px; align-items: center;"><input type="text" class="search-box" placeholder="Type to search"><div class="selected-label" style="display: none; white-space: nowrap; font-size: 12px; color: #0f8ca7;"><b></b></div></th></tr></thead><tbody></tbody>');
    var $tbody = $table.find('tbody');

    entries.forEach(function (entry) {
        var $tr = $('<tr></tr>');
        var $td = $('<td></td>').text(entry[1]).attr('data-key', entry[0]);
        $tr.append($td);
        $tbody.append($tr);
    });
    updateRowColors($table);

    $table.on('click', 'tbody td', function () {
        var $row = $(this);
        onSelect($row.attr('data-key'), $row.text(), $row);
    });

    $table.on('keyup', '.search-box', function () {
        var val = $.trim($(this).val()).replace(/ +/g, ' ').toLowerCase();
        $table.find('tbody tr').show().filter(function () {
            var text = $(this).text().replace(/\s+/g, ' ').toLowerCase();
            return !~text.indexOf(val);
        }).hide();
        updateRowColors($table);
    });
}

function clearDatasetPanels() {
    $('#results-grid').css('display', 'none');
    $('#results-detail').css('display', 'none');
    $('#dataset-list').empty();
    $('#dataset-preview').empty();
    $('#dataset-previewInfo').empty();
    $('#hiddentable').empty();
    $('#btnExport').hide();
    $('#fltrData').hide();
    $('#hdnVal').val('');
}

// Removes every aspect/label table for steps after i, truncates the confirmed
// selections to length i, and clears the results panels. Step i's own tables
// (and whatever label is already marked as selected on it) are left alone,
// so a confirmed choice stays visible until the user actually changes it.
function removeStepsAfter(i) {
    var j = i + 1;
    while (document.getElementById('aspect-step-' + j) || document.getElementById('label-step-' + j)) {
        $('#aspect-step-' + j).remove();
        $('#label-step-' + j).remove();
        j++;
    }
    state.steps = state.steps.slice(0, i);
    clearDatasetPanels();
}

// Used when the user picks a (possibly different) aspect at step i: the old
// label choice for that step no longer applies, so its table is dropped too.
function resetFrom(i) {
    $('#label-step-' + i).remove();
    removeStepsAfter(i);
}

function candidateIdsFor(i) {
    if (i === 0) return null;
    return state.steps[i - 1].candidateIds;
}

// ---------------------------------------------------------------------------
// Step 0: data type
// ---------------------------------------------------------------------------

function loadDataTypes() {
    $.ajax({
        type: 'POST',
        url: 'circomodService.svc/iedcDatatype',
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (result) {
            var $table = $('#data-type');
            $table.append('<thead><tr><th>Data Type</th></tr></thead><tbody></tbody>');
            var $tbody = $table.find('tbody');
            for (var i = 0; i < result.d.length; i++) {
                $tbody.append('<tr><td>' + result.d[i] + '</td></tr>');
            }
            updateRowColors($table);
        }
    });
}

$(document).on('click', '#data-type tbody td', function () {
    $('#data-type td').removeClass('active');
    $(this).addClass('active');

    var idx = $(this).closest('tr').index();

    state.dataType = idx + 1;
    state.steps = [];
    $('#wizard-steps').empty();
    clearDatasetPanels();
    $('#dataset-count').text('');

    $.ajax({
        type: 'POST',
        url: 'circomodService.svc/iedcDatatypesIdNumbers',
        data: JSON.stringify({ userSELECT: String(state.dataType) }),
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (result) {
            var count = result && result.d ? result.d.length : 0;
            $('#dataset-count').text('Total number of datasets available for chosen data type: ' + count);
        }
    });

    renderAspectStep(0);
});

// ---------------------------------------------------------------------------
// Steps 1-3: aspect, then label, repeated up to 3 times
// ---------------------------------------------------------------------------

function renderAspectStep(i) {
    var candidateIds = candidateIdsFor(i);
    var excludeIds = state.steps.slice(0, i).map(function (s) { return s.aspectId; });

    var $container = $('<div class="wizard-step" id="aspect-step-' + i + '"></div>');
    $container.append('<div class="wizard-step-label">Choose aspect ' + (i + 1) + ' of up to 3</div>');
    var $table = $('<table id="aspect-table-' + i + '"></table>');
    $container.append($table);
    $('#wizard-steps').append($container);

    $.ajax({
        type: 'POST',
        url: 'circomodService.svc/iedc3AspectGetAspects',
        data: JSON.stringify({
            dataType: String(state.dataType),
            candidateIdsCsv: candidateIds ? candidateIds.join(',') : '',
            excludeAspectIdsCsv: excludeIds.join(',')
        }),
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (result) {
            var entries = mapToEntries(result.d);
            if (entries.length === 0) {
                $table.replaceWith('<div class="no-more-msg">No further aspects available for the currently selected datasets.</div>');
                return;
            }
            buildSelectableTable($table, 'Aspect', entries, function (aspectId, aspectName, $row) {
                $table.find('td').removeClass('active');
                $row.addClass('active');
                resetFrom(i);
                renderLabelStep(i, aspectId, aspectName, candidateIds);
            });
        }
    });
}

function renderLabelStep(i, aspectId, aspectName, candidateIds) {
    var $container = $('<div class="wizard-step" id="label-step-' + i + '"></div>');
    $container.append('<div class="wizard-step-label">Choose a label for &ldquo;' + aspectName + '&rdquo;</div>');
    var $table = $('<table id="label-table-' + i + '"></table>');
    $container.append($table);
    $('#wizard-steps').append($container);

    $.ajax({
        type: 'POST',
        url: 'circomodService.svc/iedc3AspectGetLabels',
        data: JSON.stringify({
            dataType: String(state.dataType),
            aspectId: String(aspectId),
            candidateIdsCsv: candidateIds ? candidateIds.join(',') : ''
        }),
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (result) {
            var entries = mapToEntries(result.d);
            if (entries.length === 0) {
                $table.replaceWith('<div class="no-more-msg">No labels with matching data found.</div>');
                return;
            }
            var displayEntries = entries.map(function (e) {
                return [e[0], e[0] + ' (class. ID ' + e[1] + ')'];
            });
            buildSelectableTable($table, aspectName, displayEntries, function (label, displayText, $row) {
                $table.find('td').removeClass('active');
                $row.addClass('active');
                removeStepsAfter(i);
                // Show selected label in table header
                var $selectedLabel = $table.find('thead .selected-label');
                $selectedLabel.find('b').text(label);
                $selectedLabel.show();
                chooseLabel(i, aspectId, aspectName, label, candidateIds);
            });
        }
    });
}

function chooseLabel(i, aspectId, aspectName, label, candidateIds) {
    $.ajax({
        type: 'POST',
        url: 'circomodService.svc/iedc3AspectGetDatasets',
        data: JSON.stringify({
            dataType: String(state.dataType),
            aspectId: String(aspectId),
            label: label,
            candidateIdsCsv: candidateIds ? candidateIds.join(',') : ''
        }),
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (result) {
            var entries = mapToEntries(result.d);
            var newCandidateIds = entries.map(function (e) { return e[0]; });

            state.steps[i] = {
                aspectId: aspectId,
                aspectName: aspectName,
                label: label,
                candidateIds: newCandidateIds
            };

            renderDatasetList(entries);

            // Add instructional message below label step (after both aspect and label tables)
            if (i < 2) {
                var messages = [
                    "Please scroll to the bottom of the page to see all matching datasets. Continue with selecting a second aspect to refine the selection.",
                    "Please scroll to the bottom of the page to see all matching datasets. Continue with selecting a third aspect to refine the selection."
                ];

                var $labelStep = $('#label-step-' + i);
                var $existingMsg = $labelStep.next('.instruction-message');
                if ($existingMsg.length > 0) {
                    $existingMsg.remove();
                }

                var $message = $('<div class="instruction-message" style="grid-column: 1 / -1; margin-top: 10px; padding: 12px; background: #f0f3f4; border-left: 4px solid #0f8ca7; color: #253238; font-size: 13px; line-height: 1.5;">' + messages[i] + '</div>');
                $labelStep.after($message);
            }

            if (entries.length > 0 && i < 2) {
                renderAspectStep(i + 1);
            }
        }
    });
}

// ---------------------------------------------------------------------------
// Dataset list, preview and download (ported from iedcAdvancedData.js / iedcQuickSearch.js)
// ---------------------------------------------------------------------------

function renderDatasetList(entries) {
    clearDatasetPanels();

    if (entries.length === 0) {
        return;
    }

    $('#results-grid').css('display', 'flex');

    var $table = $('#dataset-list');
    $table.empty();
    $table.css('color', 'black');
    var header = 'Matching datasets (' + entries.length + ')';
    $table.append('<thead><tr><th>' + header + '</th></tr></thead><tbody></tbody>');
    var $tbody = $table.find('tbody');
    entries.forEach(function (entry) {
        var $tr = $('<tr></tr>');
        var $td = $('<td></td>').text(entry[1]).attr('data-id', entry[0]);
        $tr.append($td);
        $tbody.append($tr);
    });
    updateRowColors($table);
}

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

$(document).on('click', '#dataset-list tbody td', function () {
    var $td = $(this);
    var datasetName = $td.text();
    var datasetId = $td.attr('data-id');

    $('#dataset-list td').removeClass('active');
    $td.addClass('active');

    $('#results-detail').css('display', 'flex');
    $('#dataset-preview').empty();
    $('#dataset-previewInfo').empty();
    $('#hiddentable').empty();
    $('.loader2').show();

    $('#hdnVal').val(datasetId);

    $.ajax({
        type: 'POST',
        url: 'circomodService.svc/iedcDataPreview',
        data: JSON.stringify({ dataset_name: datasetName }),
        dataType: 'json',
        contentType: 'application/json; charset=utf-8',
        success: function (result) {
            $('.loader2').hide();
            var res = new Map(result['d'].map(function (obj) { return [obj.Key, obj.Value]; }));
            var columnNames = Array.from(res.values());
            var columnTitle = Array.from(res.keys());

            var ColumnNotNullValues = [...res.values()].filter(function (arr) {
                return arr.some(function (v) { return v !== null; });
            });
            var ColumnNotNullKeys = [...res.keys()].filter(function (key) {
                return res.get(key).some(function (v) { return v !== null; });
            });

            window.fullDatasetColumns = ColumnNotNullKeys.slice(0, -2);
            window.fullDatasetForExcel = [];
            var maxLength = Math.max.apply(null, ColumnNotNullValues.slice(0, -2).map(function (arr) { return arr.length; }));
            for (var i = 0; i < maxLength; i++) {
                ColumnNotNullValues.slice(0, -2).forEach(function (arr) {
                    window.fullDatasetForExcel.push(arr[i] !== undefined ? arr[i] : null);
                });
            }

            var innerHtml = "<caption class='caption-dataset-description'>Dataset Description</caption><thead><tr>";
            for (var k = 0; k < ColumnNotNullKeys.slice(0, -2).length; k++) {
                innerHtml += '<th><div>' + ColumnNotNullKeys[k] + '</div></th>';
            }
            innerHtml += '</tr></thead><tbody>';
            $('#dataset-preview').append(innerHtml);

            innerHtml = '<thead><tr>';
            for (var m = 0; m < columnTitle.slice(0, -2).length; m++) {
                innerHtml += '<th><div>' + columnTitle.slice(0, -2)[m] + '</div></th>';
            }
            innerHtml += '</tr></thead><tbody><tr></tr></tbody>';
            $('#hiddentable').append(innerHtml);

            document.getElementById('btnExport').style.display = 'block';
            document.getElementById('fltrData').style.display = 'block';

            var tbody = document.querySelector('#dataset-preview tbody');
            var hiddentabletbody = document.querySelector('#hiddentable tbody');
            generateTable(window.fullDatasetForExcel, window.fullDatasetColumns.length, 50, tbody);
            generateTable(columnNames.at(-2), columnNames.at(-1).length, columnNames.at(-2).length / columnNames.at(-1).length, hiddentabletbody);

            var headers1 = Array.from($('#dataset-preview th')).map(function (cell) { return cell.innerText; });

            $.ajax({
                type: 'POST',
                url: 'circomodService.svc/iedcDatasetPreview',
                data: JSON.stringify({ dataset_name: datasetName }),
                dataType: 'json',
                contentType: 'application/json; charset=utf-8',
                success: function (result2) {
                    var res2 = new Map(result2['d'].map(function (obj) { return [obj.Key, obj.Value]; }));
                    var columnNames2 = Array.from(res2.values());

                    for (var p = 0; p < columnNames2[0].length; p++) {
                        var thead = $('<thead></thead>');
                        var tbody2 = $('<tbody></tbody>');
                        var tr = $('<tr></tr>');
                        var td1 = $('<th></th>').text(columnNames2[0][p]);
                        var td2 = $('<td></td>').text(columnNames2[1][p]);
                        tr.append(td1, td2);
                        tbody2.append(tr);
                        if (p % 2 === 1) td2.addClass('gray-row');
                        $('#dataset-previewInfo').append(thead, tbody2);
                    }

                    var headerMapping = {};
                    headers1.forEach(function (header) {
                        if (header.indexOf('aspect_') === 0) {
                            var indexTitle = columnNames2[0].indexOf(header);
                            headerMapping[header] = columnNames2[1][indexTitle];
                        }
                    });

                    $('#dataset-preview th').each(function () {
                        var headerText = $(this).text();
                        if (headerMapping[headerText]) {
                            $(this).text(headerText + '\n' + headerMapping[headerText]);
                        }
                    });

                    $('#hiddentable th').each(function () {
                        var headerText = $(this).text();
                        if (headerMapping[headerText]) {
                            $(this).text(headerText + '\n' + headerMapping[headerText]);
                        }
                    });
                }
            });
        }
    });
});

// ---------------------------------------------------------------------------
// Excel export (ported from js/iedcQuickSearch.js, the working uncommented version)
// ---------------------------------------------------------------------------

function ExportToExcel() {
    if (!window.fullDatasetForExcel || !window.fullDatasetColumns) return;

    const workbook = new ExcelJS.Workbook();
    const sheet1 = workbook.addWorksheet('Dataset Description');

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
        const cell = sheet1.getCell(region.range.split(':')[0]);
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

    const sheet2 = workbook.addWorksheet('Data');
    const colCount = window.fullDatasetColumns.length;

    window.fullDatasetColumns.forEach((header, j) => {
        const cell = sheet2.getCell(1, j + 1);
        cell.value = header;
        cell.font = { bold: true };
    });

    const totalRows = Math.floor(window.fullDatasetForExcel.length / colCount);
    for (let r = 0; r < totalRows; r++) {
        for (let c = 0; c < colCount; c++) {
            const idx = r * colCount + c;
            sheet2.getCell(r + 2, c + 1).value = window.fullDatasetForExcel[idx];
        }
    }

    const cellD5 = sheet1.getCell('D5');
    const text = cellD5.text || cellD5.value || '';
    const fileName = text ? text + '.xlsx' : 'export.xlsx';

    workbook.xlsx.writeBuffer().then(buffer => {
        const blob = new Blob([buffer], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
        saveAs(blob, fileName);
    });
}
