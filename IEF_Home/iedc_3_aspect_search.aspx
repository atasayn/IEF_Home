<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="iedc_3_aspect_search.aspx.cs" Inherits="IEF_Home.iedc_3_aspect_search" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolderHead" runat="server">

    <script src="js/jquery.min.js"></script>
    <script type="text/javascript" src="js/iedc3AspectSearch2026.js?v=4"></script>
    <script src="https://cdn.jsdelivr.net/npm/exceljs@4.3.0/dist/exceljs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/file-saver@2.0.5/dist/FileSaver.min.js"></script>

    <script>
        function openDataFilter() {
            var el = document.getElementById('hdnVal');

            if (!el || !el.value) {
                console.warn('Dataset ID missing');
                return;
            }

            window.open(
                'https://www.database.industrialecology.uni-freiburg.de/dataFilter.aspx?value='
                + encodeURIComponent(el.value),
                '_blank'
            );
        }
    </script>

    <style>
        :root {
            --teal: #0f8ca7;
            --teal-dark: #0b6d84;
            --teal-darker: #08505f;
            --amber: #ffc000;
            --amber-dark: #e0a800;
            --gray-stripe: #f0f3f4;
            --border: #e1e8ea;
            --text: #253238;
            --text-muted: #6b7a80;
            --radius: 12px;
            --shadow: 0 2px 6px rgba(15, 140, 167, 0.08), 0 1px 2px rgba(0, 0, 0, 0.04);
            --shadow-hover: 0 6px 16px rgba(15, 140, 167, 0.14), 0 2px 4px rgba(0, 0, 0, 0.06);
        }

        * {
            box-sizing: border-box;
        }

        .iedc3-page {
            font-family: "Segoe UI", "Helvetica Neue", Arial, sans-serif;
            color: var(--text);
        }

        .grid-container {
            max-width: 1240px;
            margin: 0 auto;
            padding: 0 20px 40px;
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        /* ---------- Intro card ---------- */

        .grid-intro-expl {
            display: flex;
            align-items: center;
            gap: 28px;
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 24px 28px;
        }

        .iedc3-intro-text h3 {
            margin: 0 0 8px;
            font-size: 21px;
            font-weight: 700;
            letter-spacing: 0.2px;
            color: var(--teal-darker);
        }

        .iedc3-intro-text .iedc3-backlink {
            margin: 0 0 14px;
            font-size: 13px;
            color: var(--text-muted);
        }

        .iedc3-intro-text .iedc3-backlink a {
            color: var(--teal-dark);
            text-decoration: none;
            font-weight: 600;
        }

            .iedc3-intro-text .iedc3-backlink a:hover {
                text-decoration: underline;
            }

        .grid-intro-expl p {
            font-size: 14px;
            line-height: 1.6;
            color: var(--text-muted);
            margin: 0;
        }

        .iedc3-intro-logo {
            flex: 0 0 auto;
        }

        .iedc3-intro-logo img {
            display: block;
        }

        @media (max-width: 640px) {
            .grid-intro-expl {
                flex-direction: column;
                align-items: flex-start;
            }
        }

        /* ---------- Grid layout ---------- */

        /* 2 columns: each aspect step and its label step sit side by side on
           their own row (aspect-step-0 | label-step-0, then aspect-step-1 |
           label-step-1, etc.), so the 3 aspect/label pairs stack as 3 rows
           instead of wrapping together. */
        .wizard-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(260px, 1fr));
            gap: 20px;
            align-items: start;
        }

        #datatype-step {
            grid-column: 1 / -1;
        }

        /* Makes the JS-populated wrapper transparent to the grid, so every
           aspect/label step it appends becomes a grid item of .wizard-grid
           instead of stacking in one long column. */
        #wizard-steps {
            display: contents;
        }

        .selected-label {
            display: none;
            font-size: 13px;
            color: var(--teal-darker);
            background: #eaf6f8;
            border: 1px solid #cdeaef;
            border-radius: 8px;
            padding: 6px 10px;
        }

            .selected-label.is-set {
                display: block;
            }

            .selected-label b {
                color: var(--teal-darker);
            }

        .results-grid {
            display: flex;
            flex-direction: column;
            gap: 20px;
        }

        .results-detail {
            display: flex;
            flex-direction: column;
            gap: 20px;
            min-width: 0;
        }

        @media (max-width: 720px) {
            .wizard-grid {
                grid-template-columns: 1fr;
            }
        }

        /* ---------- Cards / wizard steps ---------- */

        .wizard-step {
            display: flex;
            flex-direction: column;
            gap: 10px;
            width: 100%;
            max-width: 100%;
            min-width: 0;
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 18px 20px 20px;
            animation: iedc3-step-in 0.25s ease-out;
        }

        @keyframes iedc3-step-in {
            from {
                opacity: 0;
                transform: translateY(6px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .wizard-step-label {
            font-weight: 600;
            font-size: 14px;
            color: var(--teal-darker);
            display: flex;
            align-items: center;
            gap: 8px;
            letter-spacing: 0.2px;
        }

        .wizard-step-label::before {
            content: "";
            width: 8px;
            height: 8px;
            border-radius: 50%;
            background: var(--amber);
            flex: 0 0 auto;
        }

        .dataset-count {
            font-size: 13px;
            color: var(--text-muted);
        }

        .grid-dataset-list {
            padding-top: 0;
            width: 100%;
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 18px 20px 20px;
        }

        .grid-dataset-preview {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            max-width: 100%;
            padding: 18px 20px 20px;
        }

        .grid-dataset-previewInfo {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            overflow: hidden;
            max-width: 100%;
            padding: 18px 20px 20px;
        }

        /* ---------- Tables ---------- */

        td:hover {
            background-color: #fff3d1;
            color: #000000;
            cursor: pointer;
        }

        .active {
            background-color: var(--amber) !important;
            font-weight: 600;
        }

        #data-type td, .wizard-step table td, #dataset-list td {
            width: 100%;
            padding: 8px 12px;
            font-size: 13.5px;
            border-bottom: 1px solid var(--gray-stripe);
            transition: background-color 0.12s ease;
        }

        #data-type th, .wizard-step table th, #dataset-list th {
            width: 100%;
        }

        th {
            padding: 9px 12px;
            background: var(--teal);
            text-align: left;
            color: white;
            font-size: 12.5px;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
        }

        #data-type, .wizard-step table {
            border-radius: 8px;
            border: 1px solid var(--border);
            border-collapse: separate;
            overflow: hidden;
            max-height: 300px;
            width: 100%;
        }

        #dataset-preview, #dataset-previewInfo {
            border-radius: 8px;
            border: 1px solid var(--border);
            border-collapse: separate;
            width: 100%;
        }

        #dataset-list {
            border-radius: 8px;
            border: 1px solid var(--border);
            border-collapse: separate;
            overflow: hidden;
            max-height: 220px;
            width: 100%;
        }

        #data-type tbody, .wizard-step table tbody {
            display: block;
            height: 300px;
            overflow-y: auto;
        }

        #dataset-list tbody {
            display: block;
            height: 220px;
            overflow-y: auto;
        }

        #dataset-preview, #dataset-previewInfo {
            height: 520px;
            display: block;
            width: 100%;
            overflow: auto;
        }

            #dataset-preview th, #dataset-previewInfo th {
                position: sticky;
                top: 0;
            }

            #dataset-preview td {
                text-align: center;
                vertical-align: middle;
                padding: 6px 10px;
                font-size: 13px;
            }

        #data-type tr:nth-child(even), .wizard-step table tr:nth-child(even), #dataset-preview tr:nth-child(even), #dataset-list tr:nth-child(even), #dataset-previewInfo tr:nth-child(even) {
            background-color: var(--gray-stripe);
        }

        /* ---------- Buttons ---------- */

        #btnExport, #fltrData {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            height: 42px;
            padding: 0 22px;
            margin: 12px 12px 0 0;
            border: none;
            border-radius: 999px;
            font-weight: 600;
            font-size: 13.5px;
            letter-spacing: 0.2px;
            cursor: pointer;
            transition: transform 0.12s ease, box-shadow 0.12s ease, background-color 0.12s ease;
        }

        #btnExport {
            background: var(--amber);
            color: #241a00;
            box-shadow: 0 2px 6px rgba(255, 192, 0, 0.35);
        }

            #btnExport:hover {
                background: var(--amber-dark);
                transform: translateY(-1px);
                box-shadow: 0 4px 10px rgba(255, 192, 0, 0.45);
            }

        #fltrData {
            background: #ffffff;
            color: var(--teal-dark);
            border: 1.5px solid var(--teal);
        }

            #fltrData:hover {
                background: var(--teal);
                color: #ffffff;
                transform: translateY(-1px);
            }

        .btn-row {
            display: flex;
            flex-direction: row;
            flex-wrap: wrap;
        }

        .wizard-step table tr {
            display: flex;
            flex-wrap: wrap;
        }

        .loader, .loader2 {
            width: 60px;
            height: 60px;
            display: block;
            margin: 0 auto;
        }

        .no-more-msg {
            font-style: italic;
            color: var(--text-muted);
            font-size: 13.5px;
            padding: 6px 2px;
        }

        input {
            margin-bottom: 6px;
            padding: 7px 12px;
            width: 100%;
            max-width: 260px;
            border: 1px solid var(--border);
            border-radius: 999px;
            font-size: 13px;
            color: var(--text);
            background-color: #ffffff;
            outline: none;
            transition: border-color 0.15s ease, box-shadow 0.15s ease;
        }

            input::placeholder {
                color: var(--text-muted);
            }

            input[type="text"].search-box:focus {
                border-color: var(--teal);
                box-shadow: 0 0 0 3px rgba(15, 140, 167, 0.15);
            }

        input[type="hidden"] {
            display: none;
        }
    </style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolderMain" runat="server">
    <div class="iedc3-page">
        <div class="grid-container">
            <div class="grid-intro-expl">
                <div class="iedc3-intro-text">
                    <h3>Industrial Ecology Data Commons (IEDC): 3-aspect search</h3>
                    <p class="iedc3-backlink">Back to standard interface and IEDC homepage &nbsp;<a href="https://www.database.industrialecology.uni-freiburg.de/" target="_blank">database.industrialecology.uni-freiburg.de &#8599;</a></p>
                    <p>The IEDC 3-aspect search finds datasets that contain data for up to three specifiers. It allows you to answer questions like
                        &ldquo;Are there data on the material composition of residential buildings erected in China in the year 2000?&rdquo;,
                        &ldquo;Do you have data on copper flows in Brazil in 2023?&rdquo;. The 3-aspect search needs four parameters: The data type
                        that you&rsquo;re searching for, and up to three labels for which data are needed. The step-by-step search interface below
                        guides you through the dataset identification and selection. The matching datasets can be inspected further on the filtering
                        page or directly downloaded as xlsx templates for own use.</p>
                </div>
                <div class="iedc3-intro-logo">
                    <img class="iedcLogo" src="resources/iedcLogo23.png" width="120" />
                </div>
            </div>

            <div class="wizard-grid" id="wizard-datatype">
                <div class="wizard-step" id="datatype-step">
                    <div class="wizard-step-label">Step 1: Choose a data type</div>
                    <table id="data-type"></table>
                    <div class="dataset-count" id="dataset-count"></div>
                </div>

                <div id="wizard-steps"></div>
            </div>

            <div class="results-grid" id="results-grid" style="display: none">
                <div class="grid-dataset-list">
                    <img class="loader" src="resources/IEDC_working.gif" style="display: none" />
                    <table id="dataset-list"></table>
                </div>

                <div class="results-detail" id="results-detail" style="display: none">
                    <div class="grid-dataset-preview">
                        <img class="loader2" src="resources/IEDC_working.gif" style="display: none" />
                        <table id="dataset-preview"></table>
                        <table id="hiddentable" style="display: none"></table>
                    </div>

                    <div class="grid-dataset-previewInfo">
                        <table id="dataset-previewInfo"></table>
                        <div class="btn-row">
                            <button id="btnExport" onclick="ExportToExcel();" style="display: none" type="button">Download</button>
                            <button id="fltrData" onclick="openDataFilter();" style="display: none" type="button">Filter Data</button>
                        </div>
                        <input type="hidden" id="hdnVal" value="" />
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>
