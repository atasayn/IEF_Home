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
                    document.getElementById(idValue).setAttribute('fill', null);

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
                console.log(url)
                url.forEach((element) =>
                    fetchCountryData(element, popSpan, gdpSpan, populationDensitySpan, url1, url2, url3)
                )

              
            });

        }

    });

});

// Function to fetch country data
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
                    console.log(data);
                    console.log(value);
                    console.log(url[0]);
                    break
                } else if (data[1][n]["value"] != null && url == url2) {
                    var value = data[1][n]["value"]
                    var date = data[1][n]["date"]
                    popSpan.innerHTML = "&#8226" + " " + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "(" + date + ")"
                    console.log(data);
                    console.log(value);
                    break

                } else if (data[1][n]["value"] != null && url == url3) {
                    var value = data[1][n]["value"]
                    var date = data[1][n]["date"]
                    populationDensitySpan.innerHTML = "&#8226" + " " + value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + "(" + date + ")"
                    console.log(data);
                    console.log(value);
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

// Function to display country data
//function displayCountryData(data) {
//    const country = data[1][0];

//    const area = country.area;
//    const population = country.population;
//    const gdp = country.gdp;

//    const resultDiv = $('#result');
//    resultDiv.html(`
//                <h2>${country.name}</h2>
//                <p>Area: ${area} sq. km</p>
//                <p>Population: ${population}</p>
//                <p>GDP: ${gdp}</p>
//            `);
//}
