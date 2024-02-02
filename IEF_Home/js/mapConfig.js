document.addEventListener("DOMContentLoaded", function () {

    var idList = [];
    var idValue = [];
    var url = [];  
    new svgMap({
        targetElementID: 'svgMap',
        noDataText: "",
        initialZoom: 1.1,
        initialPan: { x: 400, y: 0 },
        data: {

            values: {

            }
        },
        onGetTooltip: function (tooltipDiv, countryID, countryValues) {
            var flagContainer = document.getElementById("countryFlag");
            var imgElement = document.getElementById("singleCountryImg");
            var countryName = document.getElementById("countryFlagSpan");         
            $('.svgMap-country').off('click').on('click', function (e) {


                const filePath = "json/countryProxy.json";

                fetch(filePath)
                    .then(response => response.json())
                    .then(function (response) {
                        console.log(response)
                        const findFlagAndData = response.find(obj => obj.ISO === countryID.toUpperCase());
                        if (findFlagAndData.Flag == true) {
                            var sankeyProxy = document.getElementById("sankey");
                            var graphLine1Proxy = document.getElementById("Graph1Line");
                            sankeyProxy.innerHTML = "Sorry, no data for XY, here, the data for the proxy region " + findFlagAndData.Data + " are shown"

                        }
                    }),



                flagContainer.children.innerHTML = ""
                // Create img element
                id = e.target.id
                var parts = id.split('-');
                var countryCode = parts[parts.length - 1].toLowerCase();
                // Set the src attribute of the img tag
                imgElement.src = "https://cdn.jsdelivr.net/gh/hjnilsson/country-flags@latest/svg/" + countryID.toLowerCase() + ".svg";
                imgElement.setAttribute("height", 30)
                imgElement.style.border = "outset";
                var name = svgMap.prototype.countries[countryID]
                countryName.innerText = name;
                countryName.id = "countryFlagSpan"
                if (idList.includes(idValue)) {
                    document.getElementById(idValue).setAttribute('fill', null)
                }
                idValue = e.target.id;
                document.getElementById(idValue).setAttribute('fill', 'blue');
                idList.push(idValue)
                const url1 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/SP.POP.TOTL?format=json"; //GDP
                const url2 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/NY.GDP.MKTP.CD?format=json"; //Population
                const url3 = "https://api.worldbank.org/v2/country/" + countryCode + "/indicators/EN.POP.DNST?format=json"; //PopulationDensity
                url.push(url1, url2, url3) 
                var popSpan = document.getElementById("population");
                var gdpSpan = document.getElementById("gdp");
                var populationDensitySpan = document.getElementById("populationDensity");
                url.forEach((element) =>
                    fetchCountryData(element, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3)
                )           
            });
        }
    });
});

function fetchCountryData(url, popSpan, gdpSpan, populationDensitySpan,url1,url2,url3) {
    $.ajax({
        url: url,
        type: 'GET',
        dataType: 'json',
        success: function (data) {
            // Handle the data here
            let n = 0;
            while (data) {
                if (data[1][n]["value"] != null && url==url1) {
                    var value = data[1][n]["value"]
                    var date = data[1][n]["date"]
                    gdpSpan.innerHTML = "&#8226" + " " + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "(" + date + ")"
                    break
                } else if (data[1][n]["value"] != null && url == url2) {
                    var value = data[1][n]["value"]
                    var date = data[1][n]["date"]
                    popSpan.innerHTML = "&#8226" + " " + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "(" + date + ")"
                    break

                } else if (data[1][n]["value"] != null && url == url3) {
                    var value = data[1][n]["value"]
                    var date = data[1][n]["date"]
                    populationDensitySpan.innerHTML = "&#8226" + " " + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "(" + date + ")"
                    break
                }
                n++             
            }
        },
        error: function (error) {
            console.log('Error fetching data:', error);
        }
    });
}
