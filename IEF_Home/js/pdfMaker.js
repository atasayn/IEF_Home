// PDF variables
var imgHeader = new Image();
var pdfCountryFlag = new Image();
var energyCascadeImg = new Image();
var decouplingImg = new Image();



function done() {
    // PDF Layout
    var doc = new jsPDF('p', 'mm', "a4");

    doc.addPage();
    // Get Country Name and Flag
    var pdfCountryName = document.getElementById("countryInfoCountryName").innerHTML;

    // TEXT PART
    var text = "Under the EU-funded project CIRCOMOD (circular economy modelling for climate change mitigation)," +
        "we develop visualisations for the circular economy status and potentials for different regions, sectors, products, " +
        "and materials. Here, we show and test a visualization dashboard or circular economy profile for different regions " +
        "and end-use sectors. The dashboard displays results from the RECC scenario model for the circular economy in buildings " +
        "and vehicles. It is continuously updated and improved together with our colleagues from the Institute for Industrial Ecology (INEC) at Pforzheim University of Applied Sciences.";
    // Split the text in the pdf
    var textSplitted = doc.splitTextToSize(text, 200);

    // COUNTRY INFO
    var population = document.getElementById("population").innerHTML;
    var gdp = document.getElementById("gdp").innerHTML;
    var popDens = document.getElementById("populationDensity").innerHTML;
    var warning = document.getElementById("proxyWarning").innerHTML;
    // LINE GRAPHS FROM dropDownMenu
    //var popLine = graphs.populationLine;
    //var scenerioLine = graphs.scenarioLine;
    //var imgPopChart = popLine.toBase64Image();
    //var imgScenerioChart = scenerioLine.toBase64Image();
    //var imgAreaChart = areaGraph.toBase64Image();
    //var imgWaterfallChart = chartImageURL.waterfall;
    //var imgBarChart = barGraph.toBase64Image();
    var popLine = document.getElementById("Graph1Line");
    var scenerioLine = document.getElementById("GraphPopulationLine");
    //var imgPopChart = popLine.toBase64Image();
    //var imgScenerioChart = scenerioLine.toBase64Image();
    var imgAreaChart = areaGraph.toBase64Image();
    var imgWaterfallChart = chartImageURL.waterfall;
    var imgBarChart = barGraph.toBase64Image();


    // Sankey Configuration
    var sankeyConfig = document.getElementById("controlPanel");
    // Clone the controlPanel
    const clonedSankeyConfig = sankeyConfig.cloneNode(true);

    // Remove the pdfButton from the clone
    const pdfButton = clonedSankeyConfig.querySelector('#pdfButton');
    if (pdfButton) {
        pdfButton.remove();
    }

    var sankeyUpper = document.getElementById("sankey");
    var sankeyLower = document.getElementById("sankeyFullCE");
    // EnergyCascade and decoupling/coupling
    var energyCascade = document.getElementById("energyServiceCascadePNG").src;
    var ecdDecoupling = document.getElementById("ecdDecouplingPNG").src;

    imgHeader.onload = function () {
        // 1st PAGE
        // Header
        doc.addImage(imgHeader, 'PNG', 0, 0, 210, 11, undefined, 'FAST');
        // First Section: Country flag and name
        doc.setFontSize(14);
        doc.addImage(pdfCountryFlag, "PNG", 3, 18, 20, 10, undefined, 'FAST'); // Country Flag
        doc.text(27, 25, pdfCountryName); // Country Name
        doc.line(3, 30, 100, 30); // Line
        doc.setFontSize(8);
        doc.text(textSplitted, 3, 35);
        doc.setFontStyle('italic').setTextColor("#0000FF");
        doc.textWithLink("For more info about the project", 3, 65, { url: "https://circomod.eu/" });
        doc.setFontStyle('bold').setTextColor("#000000");
        // Second Section: Country Info
        doc.text("Population:", 115, 35);
        doc.setFontStyle('normal');
        doc.text(population, 132, 35);
        doc.setFontStyle('bold');
        doc.text("Gdp per capita (current us$):", 115, 40);
        doc.setFontStyle('normal');
        doc.text(gdp, 155, 40);
        doc.setFontStyle('bold');
        doc.text("Population density (people per sq. km of land area):", 115, 45);
        doc.setFontStyle('normal');
        doc.text(popDens, 185, 45);
        doc.fromHTML(warning, 120, 45, { width: 80 });
        // Third Section: Population and Service Level Graphs


       // doc.addImage(imgPopChart, 'PNG', 3, 70, 93, 43, undefined, 'FAST');
        doc.setFontStyle('bold');
        doc.text("Figure.", 10, 120);
        doc.setFontStyle('normal');
        doc.text("Population scenarios used.", 20, 120);
        //doc.addImage(imgScenerioChart, 'JPEG', 110, 70, 93, 43, undefined, 'FAST');
        doc.setFontStyle('bold');
        doc.text("Figure.", 120, 120);
        doc.setFontStyle('normal');
        doc.text("Scenarios for the future service level per capita", 130, 120);
        // Fourth Section : GHG and Waterfall
        doc.addImage(imgBarChart, 'PNG', 3, 130, 90, 43, undefined, 'FAST');
        doc.setFontStyle('bold');
        doc.text("Figure.", 10, 180);
        doc.setFontStyle('normal');
        var textCumSteel = "Cumulative steel production (from primary resources and " +
            "from scrap/secondary resources) for the selected sector/region " +
            "for a baseline development scenario and the reduction potential " +
            "of the narrow, slow, and close circular economy strategies.";
        var textSplittedCumSteel = doc.splitTextToSize(textCumSteel, 75);
        doc.text(textSplittedCumSteel, 20, 180);
        doc.addImage(imgAreaChart, 'PNG', 110, 130, 93, 43, undefined, 'FAST');
        doc.setFontStyle('bold');
        doc.text("Figure.", 120, 180);
        doc.setFontStyle('normal');
        var textAnnualGreen = "Annual greenhouse gas emissions from the use phase/final " +
            "energy use (scope 1), energy suppy supply (scope 2), and material production " +
            "and waste management (scope 3) for a baseline development scenario.";
        var textSplittedAnnualGreen = doc.splitTextToSize(textAnnualGreen, 75);
        doc.text(textSplittedAnnualGreen, 130, 180);
        // Fifth Section: Prod Graph
        doc.addImage(imgWaterfallChart, 'PNG', 60, 210, 90, 45, undefined, 'FAST');
        doc.setFontStyle('bold');
        doc.text("Figure.", 65, 265);
        doc.setFontStyle('normal');
        var textCumGreen = "Cumulative greenhouse gas emissions from final energy use (scope 1), " +
            "electricity and heat supply (scope 2), and material production (scope 3) for a baseline" +
            " development scenario and the reduction potential of the narrow, slow, and close circular economy strategies.";
        var textSplittedCumGreen = doc.splitTextToSize(textCumGreen, 75);
        doc.text(textSplittedCumGreen, 75, 265);
        // 2nd PAGE
        doc.setPage(2);
        //Seventh Section:energyCascade and coupling/decoupling
        doc.addImage(energyCascadeImg, 'PNG', 10, 150, 190, 28, undefined, 'FAST');
        doc.setFontStyle('bold');
        doc.text("Figure.", 20, 185);
        doc.setFontStyle('normal');
        var textEnergy = "Cumulative greenhouse gas emissions from final energy use (scope 1), " +
            "electricity and heat supply (scope 2), and material production (scope 3) for a baseline" +
            " development scenario and the reduction potential of the narrow, slow, and close circular economy strategies.";
        var textSplittedEnergy = doc.splitTextToSize(textEnergy, 150);
        doc.text(textSplittedEnergy, 30, 185);
        doc.addImage(decouplingImg, 'PNG', 20, 210, 160, 69, undefined, 'FAST');
        doc.line(90, 70, 210, 70); // Line
        // Sixth Section
        // Sankey Configuration
        Promise.all([
            html2canvas(sankeyConfig),
            html2canvas(sankeyUpper),
            html2canvas(sankeyLower),
            html2canvas(popLine),
            html2canvas(scenerioLine)
        ]).then(([canvas1, canvas2, canvas3, canvas4, canvas5]) => {
            doc.addImage(canvas1, 'PNG', 3, 5, 82, 137, undefined, 'FAST');
            doc.addImage(canvas2, 'PNG', 88, 6, 130, 57, undefined, 'FAST');
            doc.addImage(canvas3, 'PNG', 88, 76, 130, 57, undefined, 'FAST');
            doc.setPage(1);
            doc.addImage(canvas4, 'PNG', 3, 70, 93, 43, undefined, 'FAST');
            doc.addImage(canvas5, 'PNG', 110, 70, 93, 43, undefined, 'FAST');
            doc.setPage(2);
            doc.save('Country_Sector_CE_Profile.pdf');
        });

        clonedSankeyConfig.remove();
    };

    imgHeader.src = 'resources/pdfHeader.png';
    energyCascadeImg.src = energyCascade;
    decouplingImg.src = ecdDecoupling;
    pdfCountryFlag.src = document.getElementById("singleCountryImg").src;

    // Time and date
    doc.setPage(2);
    var today = new Date();
    var newdat = "Date Printed : " + today;

    // Page Number
    var pageCount = doc.internal.getNumberOfPages(); //Total Page Number
    for (i = 0; i < pageCount; i++) {
        doc.setPage(i);
        let pageCurrent = doc.internal.getCurrentPageInfo().pageNumber; //Current Page
        doc.setFontSize(8);
        doc.text('page: ' + pageCurrent + '/' + pageCount, doc.internal.pageSize.width - 20, doc.internal.pageSize.height - 5);
        doc.setFontSize(6);
        doc.text(newdat, 5, doc.internal.pageSize.height - 5);
    }
}

