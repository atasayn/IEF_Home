document.addEventListener("DOMContentLoaded", function () {

    var idList = [];
    var idValue = [];

    new svgMap({
        targetElementID: 'svgMap',
        noDataText: "",

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
                var result = parts[parts.length - 1];

                
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

            });

        }

    });

});
