document.addEventListener('DOMContentLoaded', () => {
    if (/firefox/i.test(navigator.userAgent)) return;

    const overlay = document.createElement('div');
    overlay.id = 'browserWarning';
    Object.assign(overlay.style, {
        position: 'fixed',
        inset: 0,
        background: 'rgba(0,0,0,0.6)',
        display: 'flex',
        alignItems: 'center',
        justifyContent: 'center',
        zIndex: 9999
    });

    const box = document.createElement('div');
    Object.assign(box.style, {
        background: '#fff',
        padding: '20px',
        borderRadius: '6px',
        textAlign: 'center'
    });
    box.innerHTML = `
    <p style="margin:0 0 10px;font-size:16px;">
      For the best experience, we recommend using Firefox.
    </p>
    <button id="browserWarningContinue" style="padding:8px 12px;">Continue</button>
  `;

    overlay.appendChild(box);
    document.body.appendChild(overlay);

    document.getElementById('browserWarningContinue').addEventListener('click', () => {
        document.body.removeChild(overlay);
        // or: location.reload();
    });
});

(() => {
    "use strict";

    const removeBoldTags = (container) => {
        if (!container) return;
        const boldTags = container.getElementsByTagName("b");
        while (boldTags.length > 0) {
            boldTags[0].parentNode.removeChild(boldTags[0]);
        }
    };

    const fetchJSON = (url) =>
        fetch(url).then((r) => {
            if (!r.ok) throw new Error("Network response was not ok");
            return r.json();
        });

    const fetchCountryData = (url, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3) => {
        $.ajax({
            url,
            type: "GET",
            dataType: "json",
            success: (data) => {
                let n = 0;
                while (data) {
                    const entry = data?.[1]?.[n];
                    if (!entry) break;
                    if (entry.value != null && url === url1) {
                        const val = entry.value, date = entry.date;
                        popSpan.innerHTML = ` ${val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")} (${date})`;
                        break;
                    } else if (entry.value != null && url === url2) {
                        const val = entry.value, date = entry.date;
                        gdpSpan.innerHTML = ` ${Math.round(val).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")} (${date})`;
                        break;
                    } else if (entry.value != null && url === url3) {
                        const val = entry.value, date = entry.date;
                        populationDensitySpan.innerHTML = ` ${Math.round(val).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ".")} (${date})`;
                        break;
                    }
                    n++;
                }
            },
        });
    };

    const chartImageURL = {};
    function ghgChart(data, canvasID, region, sector) {
        const res = new Map(data.d.map((obj) => [obj.Key, obj.Value]));
        const values = [...new Set(Array.from(res.values()))];
        try {
            const chart = new CanvasJS.Chart("waterfall", {
                theme: "light2",
                backgroundColor: "rgba(225,150,150,0)",
                title: {
                    text: `Cumulative GHG 2020-2060, [${region}], [${sector}]`,
                    fontSize: 12,
                    fontColor: "#666",
                },
                axisY: {
                    title: "Mt CO2-eq / year",
                    valueFormatString: "#.###",
                    titleFontSize: 12,
                },
                data: [
                    {
                        type: "waterfall",
                        yValueFormatString: "#.###",
                        risingColor: "#96a6a6",
                        fallingColor: "#ef6c00",
                        dataPoints: [
                            { label: "SSP2 Baseline", y: parseInt(Number(values[0].toString().replace(",", ".")).toFixed(1)) },
                            { label: ".", y: parseInt((Number(values[1].toString().replace(",", ".")) - Number(values[0].toString().replace(",", "."))).toFixed(1)) },
                            { label: "Slow+Close", isIntermediateSum: true },
                            { label: ".", y: parseInt((Number(values[2].toString().replace(",", ".")) - Number(values[1].toString().replace(",", "."))).toFixed()) },
                            { label: "Narrow+Slow+Close", isCumulativeSum: true },
                        ],
                    },
                ],
            });
            chart.render();
            const canvas = $("#waterfall .canvasjs-chart-canvas").get(0);
            chartImageURL.waterfall = canvas.toDataURL("image/png", 1);
        } catch (e) {
            console.error("Error disposing previous chart:", e);
        }
        return chartImageURL;
    }

    const fillMapCountry = (newId) => {
        document.querySelectorAll(".svgMap-country").forEach((el) => el.removeAttribute("fill"));
        const current = document.getElementById(newId);
        if (current) current.setAttribute("fill", "blue");
    };

    const buildSankey = ({ region, scenario, sector, startYear, endYear, strategy, material, upper = true }) => {
        const sankeyWrapperId = upper ? "sankeyDivsAll" : "sankeyDivsAllFullCE";
        const sankeyDiv = document.getElementById(sankeyWrapperId);
        if (!sankeyDiv) return;

        if (sankeyDiv.style.display === "") sankeyDiv.style.display = "block";

        const buttonDiv = document.createElement("div");
        buttonDiv.style.position = "absolute";

        const previousBtn = document.createElement("button");
        previousBtn.className = "button";
        previousBtn.type = "button";
        previousBtn.textContent = ">>";
        previousBtn.setAttribute("onclick", upper ? "navigateFront()" : "navigateFrontLower()");

        const nextBtn = document.createElement("button");
        nextBtn.className = "button";
        nextBtn.type = "button";
        nextBtn.textContent = "<<";
        nextBtn.setAttribute("onclick", upper ? "navigateBack()" : "navigateBackLower()");

        buttonDiv.appendChild(previousBtn);
        buttonDiv.appendChild(nextBtn);

        const loaderClass = upper ? ".loader" : ".loader6";
        const steelContainerId = upper ? "steelUpperValue" : "steelLowerValue";
        const ghgContainerId = upper ? "GhGUpperValue" : "GhGLowerValue";
        const scenarioSpanId = upper ? "scenerioSpan" : "scenerioSpanLower";
        const sectorSpanId = upper ? "sectorSpan" : "sectorSpanLower";
        const yearSpanId = upper ? "yearSpan" : "yearSpanLower";
        const strategySpanId = upper ? "strategySpan" : "strategySpanLower";
        const materialSpanId = upper ? "materialSpan" : "materialSpanLower";
        const svgIdPrefix = upper ? "target_svg" : "Lowertarget_svg";
        const divIdPrefix = upper ? "div_svg" : "Lowerdiv_svg";
        const chartIdPrefix = upper ? "chart" : "Lowerchart";
        const spanIdPrefix = upper ? "span_svg" : "Lowerspan_svg";

        document.getElementById(scenarioSpanId).innerHTML = scenario;
        document.getElementById(sectorSpanId).innerHTML = sector;
        document.getElementById(yearSpanId).innerHTML = `${startYear}-${endYear}`;
        document.getElementById(strategySpanId).innerHTML = strategy;
        document.getElementById(materialSpanId).innerHTML = material;

        for (let year = startYear; year <= endYear; year += 10) {
            const newDiv = document.createElement("div");
            newDiv.id = `${divIdPrefix}${year}`;
            newDiv.style.position = "absolute";

            const chartParagraph = document.createElement("p");
            chartParagraph.id = `${chartIdPrefix}${year}`;
            newDiv.appendChild(chartParagraph);

            const spanDiv = document.createElement("div");
            const newSpan = document.createElement("span");
            newSpan.id = `${spanIdPrefix}${year}`;
            newSpan.innerHTML = `${scenario}-${year}`;
            newSpan.style.position = "absolute";
            newSpan.style.bottom = 0;
            spanDiv.appendChild(newSpan);

            sankeyDiv.appendChild(newDiv);
            sankeyDiv.appendChild(spanDiv);

            if (year === startYear) {
                newDiv.style.visibility = "visible";
                newSpan.style.visibility = "visible";
            } else {
                newDiv.style.visibility = "hidden";
                newSpan.style.visibility = "hidden";
            }

            const chartContainer = chartParagraph;
            const svgElement = document.createElementNS("http://www.w3.org/2000/svg", "svg");
            svgElement.setAttribute("id", `${svgIdPrefix}${year}`);
            chartContainer.appendChild(svgElement);

            const divId = `${svgIdPrefix}${year}`;
            const divSvg = newDiv.id;
            const divChart = chartParagraph.id;

            $(loaderClass).css("display", "block");

            fetch("circomodService.svc/Classification_SankeyItem", {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=utf-8" },
                body: JSON.stringify({
                    SELECTedRegion: region,
                    SELECTedScenario: scenario,
                    SELECTedSector: sector,
                    SELECTedYear: year,
                    SELECTedStrategy: strategy,
                    SELECTedMaterial: material,
                }),
            })
                .then((response) => response.json())
                .then((data) => {
                    $(loaderClass).hide();
                    const res = new Map(data.d.map((obj) => [obj.Key, obj.Value.replace(",", ".")]));
                    const flowarea = $("#input_flow_data").val();
                    let text = flowarea;

                    text = text.replace("F_a", res.get("query_Fa"));
                    text = text.replace("F_b", Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh"))));

                    const steelContainer = document.getElementById(steelContainerId);
                    const Fb = Math.abs(parseFloat(res.get("query_Fa")) + parseFloat(res.get("query_Fh")));
                    let spanSteel = `<b><span id='${upper ? "steelUpper_span" : "steelLower_span"}${year}' style='display:none'>${parseFloat(Fb.toFixed(1))} Mt/yr</span></b>`;
                    if (year === startYear) spanSteel = spanSteel.replace("display:none", "display:block");
                    steelContainer.innerHTML += spanSteel;

                    text = text.replace("F_c", res.get("query_Fc"));
                    text = text.replace("F_d", res.get("query_Fc"));
                    text = text.replace("F_e", res.get("query_Fc"));
                    text = text.replace("F_f", res.get("query_Ff"));
                    text = text.replace("F_g", Math.abs(parseFloat(res.get("query_Ff")) - parseFloat(res.get("query_Fh"))));
                    text = text.replace("F_h", res.get("query_Fh"));
                    text = text.replace("F_i", res.get("query_Fh"));
                    text = text.replace("F_j", res.get("query_Fh"));
                    text = text.replace("F_k", res.get("query_Fk") / 50);
                    text = text.replace("F_l", res.get("query_Fl") / 50);
                    text = text.replace("F_m", res.get("query_Fm") / 50);

                    const ghgContainer = document.getElementById(ghgContainerId);
                    const Fm = res.get("query_Fm") / 50;
                    let spanGhg = `<b><span id='${upper ? "ghgUpper_span" : "ghgLower_span"}${year}' style='display:none'>${parseFloat(Fm.toFixed(1))} Mt/yr</span></b>`;
                    if (year === startYear) spanGhg = spanGhg.replace("display:none", "display:block");
                    ghgContainer.innerHTML += spanGhg;

                    text = text.replace("F_n", res.get("query_Fn"));
                    text = text.replace("F_o", res.get("query_Fn"));
                    text = text.replace("F_p", res.get("query_Fn"));
                    $("#input_flow_data").val(text);
                    process_sankey(divId, divSvg, divChart);
                    $("#input_flow_data").val(flowarea);
                })
                .catch((err) => console.error(err));

            sankeyDiv.appendChild(buttonDiv);
        }
    };

    const loadCharts = ({ region, sector, material, scenario, startYear, endYear, strategy, countryID, countryName, proxyData }) => {
        const mapArea = document.getElementById("mapArea");
        mapArea.style.filter = "blur(8px)";
        mapArea.style.pointerEvents = "none";

        const countryInfoCountryName = document.getElementById("countryInfoCountryName");
        countryInfoCountryName.innerHTML = countryName;

        const imgElement = document.getElementById("singleCountryImg");
        const countryNameSpan = document.getElementById("countryFlagSpan");
        const imgElementLower = document.getElementById("singleCountryImgLower");
        const countryNameLower = document.getElementById("countryFlagSpanLower");

        imgElement.src = `resources/countryFlags/${countryID.toLowerCase()}.png`;
        imgElementLower.src = imgElement.src;
        countryNameSpan.innerHTML = countryName;
        countryNameLower.innerHTML = countryName;

        const url1 = `https://api.worldbank.org/v2/country/${countryID.toLowerCase()}/indicators/SP.POP.TOTL?format=json`;
        const url2 = `https://api.worldbank.org/v2/country/${countryID.toLowerCase()}/indicators/NY.GDP.PCAP.CD?format=json`;
        const url3 = `https://api.worldbank.org/v2/country/${countryID.toLowerCase()}/indicators/EN.POP.DNST?format=json`;

        const gdpSpan = document.getElementById("gdp");
        const popSpan = document.getElementById("population");
        const populationDensitySpan = document.getElementById("populationDensity");
        [url1, url2, url3].forEach((u) => fetchCountryData(u, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3));

        if (region === "R32CHN" && sector === "Residential building") {
            $("#ChinaTeaser").css("display", "grid");
        } else {
            $("#ChinaTeaser").css("display", "none");
        }

        const energyServicePNG = document.getElementById("energyServiceCascadePNG");
        const decouplingService = document.getElementById("ecdDecouplingPNG");
        if (sector === "Residential building") {
            energyServicePNG.src = `Content/ReccPlots/${proxyData.findFlagAndDataPNG}`;
            decouplingService.src = "Content/ReccPlots/ECD_Decoupling_Overview.png";
        } else {
            energyServicePNG.src = "";
            decouplingService.src = "";
        }

        $(".loader2").css("display", "block");
        fetch("circomodService.svc/Classification_ResultItemPopulation", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({ SELECTedRegion: region }),
        })
            .then((r) => r.json())
            .then((result) => {
                $(".loader2").hide();
                if (region !== "") {
                    displayGraph(result.d, "line-plot2", "Total Population by scenario (million)", "Total Population");
                }
            })
            .catch(console.error);

        $(".loader4").css("display", "block");
        fetch("circomodService.svc/Classification_ResultAreaStacked", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({ selectedRegion: region, selectedSector: sector }),
        })
            .then((r) => r.json())
            .then((result) => {
                $(".loader4").hide();
                if (region !== "") {
                    stackedAreaChart(result, "line-plot4", region, sector);
                }
            })
            .catch(console.error);

        $(".loader3").css("display", "block");
        fetch("circomodService.svc/Classification_Result1stAnd2ndProd", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({ selectedRegion: region, selectedSector: sector, selectedMaterial: material }),
        })
            .then((r) => r.json())
            .then((result) => {
                $(".loader3").hide();
                if (region !== "") {
                    barChart(result, "line-plot3", region, sector, material);
                }
            })
            .catch(console.error)
            .finally(() => {
                mapArea.style.filter = "none";
                mapArea.style.pointerEvents = "auto";
            });

        $(".loader5").css("display", "block");
        fetch("circomodService.svc/Classification_ResultGHG", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({ selectedRegion: region, selectedSector: sector }),
        })
            .then((r) => r.json())
            .then((result) => {
                $(".loader5").hide();
                if (region !== "") {
                    ghgChart(result, "line-plot5", region, sector);
                }
            })
            .catch(console.error);

        const canvasElement = document.getElementById("NoData" + "line-plot1");
        const countriesAvailable = ["France", "Germany", "Italy", "Spain", "UK", "Poland", "Oth_R32EU15", "Oth_R32EU12-H", "R32EU12-M"];
        if (sector === "Residential building" && countriesAvailable.includes(region)) {
            canvasElement.style.display = "none";
            $(".loader1").css("display", "block");
            fetch("circomodService.svc/Classification_ResultItemBuildingRes", {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=utf-8" },
                body: JSON.stringify({ selectedRegion: region }),
            })
                .then((r) => r.json())
                .then((result) => {
                    $(".loader1").hide();
                    if (region !== "") {
                        displayGraph(result.d, "line-plot1", "Per Capita Service Level", "m2/cap");
                    }
                })
                .catch(console.error);
        } else if (sector === "Passenger vehicles") {
            $(".loader1").css("display", "block");
            fetch("circomodService.svc/Classification_ResultItem", {
                method: "POST",
                headers: { "Content-Type": "application/json; charset=utf-8" },
                body: JSON.stringify({ SELECTedRegion: region }),
            })
                .then((r) => r.json())
                .then((result) => {
                    $(".loader1").hide();
                    if (region !== "") {
                        displayGraph(result.d, "line-plot1", "Per Capita Service Level", "Annual pkm by passenger cars");
                    }
                })
                .catch(console.error);
        } else {
            const existingChart = Chart.getChart("line-plot1");
            if (existingChart) existingChart.destroy();
            canvasElement.style.display = "flex";
        }

        buildSankey({ region, scenario, sector, startYear, endYear, strategy: "Baseline", material: "steel", upper: true });
        buildSankey({ region, scenario: "LED", sector, startYear, endYear, strategy: "Full CE", material: "steel", upper: false });
    };

    const handleCountryClick = (evt) => {
        const target = evt.currentTarget;
        const isoMatch = target.id.match(/country-([A-Za-z0-9]+)/i);
        const countryID = isoMatch ? isoMatch[1].toUpperCase() : "";
        if (!countryID) return;
        const countryName = svgMap.prototype.countries[countryID] || countryID;

        const proxyWarning = document.getElementById("proxyWarning");
        proxyWarning.innerHTML = "";

        [document.getElementById("steelUpperValue"),
        document.getElementById("GhGUpperValue"),
        document.getElementById("steelLowerValue"),
        document.getElementById("GhGLowerValue")].forEach(removeBoldTags);

        fillMapCountry(target.id);

        fetchJSON("json/countryProxy.json")
            .then((response) => {
                const findFlagAndData = response.find((obj) => obj.ISO === countryID);
                const regionInfo = { region: findFlagAndData.Data, findFlagAndDataPNG: findFlagAndData.Png };
                const warningDisplay = document.getElementById("warningDisplay");
                const proxyName = document.getElementById("proxyName");
                const countryInfoCountryName = document.getElementById("countryInfoCountryName");

                if (findFlagAndData.Flag === true) {
                    proxyWarning.innerHTML = `Sorry, no data for <span style='color:#ba1a1a'>${countryName}</span>, here, the data for the proxy region<span style='color:green'> ${findFlagAndData.Data}</span> are shown`;
                    countryInfoCountryName.innerHTML = countryName;
                    proxyName.innerHTML = `Proxy name: ${findFlagAndData.Data}`;
                    warningDisplay.style.display = "block";
                    regionInfo.region = findFlagAndData.Data;
                } else {
                    countryInfoCountryName.innerHTML = countryName;
                    proxyName.innerHTML = "";
                    warningDisplay.style.display = "none";
                }
                return regionInfo;
            })
            .then((regionObj) => {
                loadCharts({
                    region: regionObj.region,
                    sector: $("#DropDownListSector").val(),
                    material: $("#DropDownListMaterial").val(),
                    scenario: "SSP2",
                    startYear: 2020,
                    endYear: 2060,
                    strategy: "Baseline",
                    countryID,
                    countryName,
                    proxyData: regionObj,
                });
            })
            .catch(console.error);
    };

    const initSvgMap = () => {
        new svgMap({
            targetElementID: "svgMap",
            noDataText: "",
            initialZoom: 1.1,
            initialPan: { x: 400, y: 0 },
            data: {
                data: { dummy: { name: "", format: "" } },
                applyData: "dummy",
                values: {},
            },
        });

        // bind clicks once countries are in the DOM
        const container = document.getElementById("svgMap");
        const observer = new MutationObserver(() => {
            container.querySelectorAll(".svgMap-country").forEach((el) => {
                el.removeEventListener("click", handleCountryClick);
                el.addEventListener("click", handleCountryClick);
            });
        });
        observer.observe(container, { childList: true, subtree: true });
    };

    const initMaterialDropdown = () => {
        $("#DropDownListSector").on("change", function () {
            const sectorTemp = $(this).val();
            const dropdown = $("#DropDownListMaterial");
            dropdown.empty();
            dropdown.append("<option value='' disabled selected>Please select sector</option>");
            const arrayBuilding = ["Steel", "Cement", "Wood"];
            const arrayVehicle = ["Steel", "Aluminium", "Copper"];
            if (sectorTemp === "Residential building") {
                arrayBuilding.forEach((el) => dropdown.append($("<option>").val(el).text(el)));
            } else if (sectorTemp === "Passenger vehicles") {
                arrayVehicle.forEach((el) => dropdown.append($("<option>").val(el).text(el)));
            }
        });
    };

    const initOnLoadCharts = () => {
        const region = "Germany";
        const scenario = "SSP2";
        const sector = "Residential building";
        const startYear = 2020;
        const endYear = 2030;
        const strategy = "Baseline";
        const material = "steel";

        fetchJSON("json/countryProxy.json").then((response) => {
            const findFlagAndData = response.find((obj) => obj.ISO === "DE");
            document.getElementById("energyServiceCascadePNG").src = `Content/ReccPlots/${findFlagAndData.Png}`;
            document.getElementById("ecdDecouplingPNG").src = "Content/ReccPlots/ECD_Decoupling_Overview.png";
        });

        document.getElementById("countryInfoCountryName").innerHTML = region;

        $(".loader2").css("display", "block");
        fetch("circomodService.svc/Classification_ResultItemPopulation", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({ SELECTedRegion: region }),
        })
            .then((r) => r.json())
            .then((result) => {
                $(".loader2").hide();
                if (region !== "") displayGraph(result.d, "line-plot2", "Total Population by scenario (million)", "Total Population");
            })
            .catch(console.error);

        $(".loader1").css("display", "block");
        fetch("circomodService.svc/Classification_ResultItemBuildingRes", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({ selectedRegion: region }),
        })
            .then((r) => r.json())
            .then((result) => {
                $(".loader1").hide();
                if (region !== "") displayGraph(result.d, "line-plot1", "Per Capita Service Level", "m2/cap");
            })
            .catch(console.error);

        $(".loader3").css("display", "block");
        fetch("circomodService.svc/Classification_Result1stAnd2ndProd", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({ selectedRegion: region, selectedSector: sector, selectedMaterial: material }),
        })
            .then((r) => r.json())
            .then((result) => {
                $(".loader3").hide();
                if (region !== "") barChart(result, "line-plot3", region, sector, material);
            });

        $(".loader4").css("display", "block");
        fetch("circomodService.svc/Classification_ResultAreaStacked", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({ selectedRegion: region, selectedSector: sector }),
        })
            .then((r) => r.json())
            .then((result) => {
                $(".loader4").hide();
                if (region !== "") stackedAreaChart(result, "line-plot4", region, sector);
            });

        $(".loader5").css("display", "block");
        fetch("circomodService.svc/Classification_ResultGHG", {
            method: "POST",
            headers: { "Content-Type": "application/json; charset=utf-8" },
            body: JSON.stringify({ selectedRegion: region, selectedSector: sector }),
        })
            .then((r) => r.json())
            .then((result) => {
                $(".loader5").hide();
                if (region !== "") ghgChart(result, "line-plot5", region, sector);
            })
            .catch(console.error);

        buildSankey({ region, scenario, sector, startYear, endYear, strategy, material, upper: true });
        buildSankey({ region, scenario: "LED", sector, startYear, endYear, strategy: "Full CE", material, upper: false });

        fillMapCountry("svgMap-map-country-DE");

        const imgElement = document.getElementById("singleCountryImg");
        const countryNameSpan = document.getElementById("countryFlagSpan");
        imgElement.src = "resources/countryFlags/de.png";
        imgElement.setAttribute("height", 30);
        imgElement.style.border = "outset";
        countryNameSpan.innerText = "Germany";

        const imgElementLower = document.getElementById("singleCountryImgLower");
        const countryNameLower = document.getElementById("countryFlagSpanLower");
        imgElementLower.src = "resources/countryFlags/de.png";
        imgElementLower.setAttribute("height", 30);
        imgElementLower.style.border = "outset";
        countryNameLower.innerText = "Germany";

        const url1 = `https://api.worldbank.org/v2/country/de/indicators/SP.POP.TOTL?format=json`;
        const url2 = `https://api.worldbank.org/v2/country/de/indicators/NY.GDP.PCAP.CD?format=json`;
        const url3 = `https://api.worldbank.org/v2/country/de/indicators/EN.POP.DNST?format=json`;

        const popSpan = document.getElementById("population");
        const gdpSpan = document.getElementById("gdp");
        const populationDensitySpan = document.getElementById("populationDensity");
        [url1, url2, url3].forEach((u) => fetchCountryData(u, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3));
    };

    document.addEventListener("DOMContentLoaded", () => {
        initSvgMap();
        initMaterialDropdown();
    });

    $(window).on("load", () => {
        initOnLoadCharts();
    });
})();