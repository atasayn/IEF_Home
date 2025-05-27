var position = 0;

function MakeScrollable(e, t) {
    var n = e.id;
    var r = e.offsetHeight;
    var i = new Array;

    for (var s = 0; s < e.getElementsByTagName("TH").length; s++) {
        i[s] = e.getElementsByTagName("TH")[s].offsetWidth;
    }

    // Add a container for the entire widget
    var container = document.createElement("div");
    container.className = "scrollable-container";


    // Create search box
    var searchBox = document.createElement("input");
    searchBox.type = "text";
    if (e.id != "dataset_names") {
        searchBox.placeholder = "Search in Aspect List...";
    } else {
        searchBox.placeholder = "Search in Dataset List...";
    }

    searchBox.className = "table-search-box";
    searchBox.style.cssText = "margin-bottom: 8px; width: 100%; padding: 5px;";
    container.appendChild(searchBox);

    e.parentNode.insertBefore(container, e);
    container.appendChild(e);

    // Clone table header
    var u = document.createElement("table");
    for (s = 0; s < e.attributes.length; s++) {
        if (e.attributes[s].specified && e.attributes[s].name != "id") {
            u.setAttribute(e.attributes[s].name, e.attributes[s].value);
        }
    }
    u.style.cssText = e.style.cssText;
    u.appendChild(document.createElement("tbody"));
    u.getElementsByTagName("tbody")[0].appendChild(e.getElementsByTagName("TR")[0]);

    var a = u.getElementsByTagName("TH");
    var f = e.getElementsByTagName("TR")[0];

    for (var s = 0; s < a.length; s++) {
        var l;
        if (i[s] > f.getElementsByTagName("TD")[s].offsetWidth) {
            l = i[s];
        } else {
            l = f.getElementsByTagName("TD")[s].offsetWidth;
        }
        a[s].style.width = parseInt(l) + "px";
        $("tr", $(e)).each(function () {
            $("td", this).eq(s).css("width", l);
        });
    }

    container.removeChild(e);

    var c = document.createElement("div");
    c.id = "header" + n;
    c.appendChild(u);
    container.appendChild(c);

    var h = document.createElement("div");
    var p = u.offsetWidth;
    h.style.cssText = "overflow:auto;height:" + t.ScrollHeight + "px;width:" + p + "px";
    h.appendChild(e);
    container.appendChild(h);

    if (t.Width > 0) {
        container.style.cssText += "overflow:auto;width:" + 400 + "px";
    }

    h.scrollTop = position;
    h.onscroll = function () {
        position = h.scrollTop;
    };

    // Add search filter logic
    $(searchBox).on("keyup", function () {
        var value = $(this).val().toLowerCase();
        $("#" + n + " tbody tr").filter(function () {
            $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
        });
    });
}

(function (e) {
    e.fn.Scrollable = function (t) {
        var n = { ScrollHeight: 300, Width: 0, IsInUpdatePanel: false };
        var t = e.extend(n, t);

        return this.each(function () {
            var n = e(this).get(0);
            var r = n.id;
            MakeScrollable(n, t);

            if (t.IsInUpdatePanel) {
                var i = Sys.WebForms.PageRequestManager.getInstance();
                if (i != null) {
                    i.add_endRequest(function (n, i) {
                        MakeScrollable(e("#" + r).get(0), t);
                    });
                }
            }
        });
    };
})(jQuery);
