document.addEventListener("DOMContentLoaded", function () {
    //$('#vmap').vectorMap({
    //    map: 'world_en',
    //    backgroundColor: '#E9ECEF',
    //    color: '#ffffff',
    //    hoverOpacity: 0.7,
    //    selectedColor: '#666666',
    //    enableZoom: true,
    //    showTooltip: true,
    //    scaleColors: ['#17A2B8', '#006491'],
    //    values: sample_data,
    //    normalizeFunction: 'polynomial',
    //    onRegionOver: function (e, code, region) {
    //        console.log(region)
    //        var divDisplay = d3.select("#my_dataviz");
    //        divDisplay.html("");  // Clear previous content




    //    },
    //    onLabelShow: function (event, label, code) {

    //    }
    //});

    new svgMap({
        targetElementID: 'svgMap',
        noDataText: "",
        data: {
       
            values: {

            }
        },
    });
});



