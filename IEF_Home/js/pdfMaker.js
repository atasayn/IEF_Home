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
        "and vehicles. It is continuously updated and improved. ";
    // Split the text in the pdf
    var textSplitted = doc.splitTextToSize(text, 200);

    // COUNTRY INFO
    var population = document.getElementById("population").innerHTML;
    var gdp = document.getElementById("gdp").innerHTML;
    var popDens = document.getElementById("populationDensity").innerHTML;
    var warning = document.getElementById("proxyWarning").innerHTML;
    // LINE GRAPHS FROM dropDownMenu
    var popLine = graphs.populationLine;
    var scenerioLine = graphs.scenarioLine;
    var imgPopChart = popLine.toBase64Image();
    var imgScenerioChart = scenerioLine.toBase64Image();
    var imgAreaChart = areaGraph.toBase64Image();
    var imgWaterfallChart = chartImageURL.waterfall;
    var imgBarChart = barGraph.toBase64Image();

    // Sankey Configuration
    var sankeyConfig = document.getElementById("controlPanel");
    var sankeyUpper = document.getElementById("sankey");
    var sankeyLower = document.getElementById("sankeyFullCE");
    // EnergyCascade and decoupling/coupling
    var energyCascade = document.getElementById("energyServiceCascadePNG").src;
    var ecdDecoupling = document.getElementById("ecdDecouplingPNG").src;
    console.log(energyCascade);
    imgHeader.onload = function () {
        // 1st PAGE
        // Header
        doc.addImage(imgHeader, 'PNG', 0, 0, 210, 11);
        // First Section: Country flag and name
        doc.setFontSize(14);
        doc.addImage(pdfCountryFlag, "PNG", 3, 18, 20, 10); // Country Flag
        doc.text(27, 25, pdfCountryName); // Country Name
        doc.line(3, 30, 100, 30); // Line
        doc.setFontSize(8);
        doc.text(textSplitted, 3, 35);
        doc.setFontStyle('italic').setTextColor("#0000FF");
        doc.textWithLink("For more info about the project", 3, 58, { url: "https://circomod.eu/" });
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
        doc.text(popDens, 1185, 45);
        doc.fromHTML(warning, 120, 45, { width: 80 });
        // Third Section: Population and Service Level Graphs
        doc.addImage(imgPopChart, 'PNG', 3, 70, 93, 43);
        doc.addImage(imgScenerioChart, 'JPEG', 110, 70, 93, 43);
        // Fourth Section : GHG and Waterfall
        doc.addImage(imgWaterfallChart, 'PNG', 3, 130, 90, 43);
        doc.addImage(imgAreaChart, 'PNG', 110, 130, 93, 43);
        // Fifth Section: Prod Graph
        doc.addImage(imgBarChart, 'PNG', 60, 200, 93, 43);

        // 2nd PAGE
        doc.setPage(2);
        //Seventh Section:energyCascade and coupling/decoupling
        doc.addImage(energyCascadeImg, 'PNG', 10, 150, 190,28);
        doc.addImage(decouplingImg, 'PNG', 10, 190, 190,89);


        // Sixth Section
        // Sankey Configuration
        Promise.all([
            html2canvas(sankeyConfig),
            html2canvas(sankeyUpper),
            html2canvas(sankeyLower)
        ]).then(([canvas1, canvas2, canvas3]) => {
            doc.addImage(canvas1, 'PNG', 3, 5, 82, 137);
            doc.addImage(canvas2, 'PNG', 88, 6, 130, 57);
            doc.addImage(canvas3, 'PNG', 88, 76, 130, 57);
            doc.save('two-by-four.pdf');
        });
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

