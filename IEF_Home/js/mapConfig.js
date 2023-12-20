$(document).ready(function () {
    $('#vmap').vectorMap({
        map: 'world_en',
        backgroundColor: '#E9ECEF',
        color: '#ffffff',
        hoverOpacity: 0.7,
        selectedColor: '#666666',
        enableZoom: true,
        showTooltip: true,
        scaleColors: ['#17A2B8', '#006491'],
        values: sample_data,
        normalizeFunction: 'polynomial'
    });
});

