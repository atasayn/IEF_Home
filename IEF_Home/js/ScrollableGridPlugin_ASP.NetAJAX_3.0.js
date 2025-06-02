// Store scroll positions and search values per table
var scrollPositions = {};
var searchValues = {};

function MakeScrollable(e, t) {
    var n = e.id;
    var r = e.offsetHeight;
    var i = [];

    for (var s = 0; s < e.getElementsByTagName("TH").length; s++) {
        i[s] = e.getElementsByTagName("TH")[s].offsetWidth;
    }

    // Add container
    var container = document.createElement("div");
    container.className = "scrollable-container";

    // Add search box for gvAspects
    if (e.id === "gvAspects") {
        var searchBox = document.createElement("input");
        searchBox.type = "text";
        searchBox.placeholder = "Search in Aspect List...";
        searchBox.className = "table-search-box";
        searchBox.style.cssText = "margin-bottom: 8px; width: 100%; padding: 5px;";
        container.appendChild(searchBox);

        // Restore previous search value
        if (searchValues[n]) {
            searchBox.value = searchValues[n];
        }

        searchBox.addEventListener("input", function () {
            var filter = searchBox.value.toLowerCase();
            searchValues[n] = filter; // Save current value

            var table = document.getElementById("gvAspects");
            var rows = table.getElementsByTagName("tr");

            for (var i = 1; i < rows.length; i++) {
                var cells = rows[i].getElementsByTagName("td");
                var match = false;
                for (var j = 0; j < cells.length; j++) {
                    if (cells[j].innerText.toLowerCase().includes(filter)) {
                        match = true;
                        break;
                    }
                }
                rows[i].style.display = match ? "" : "none";
            }

            // Restore scroll position
            var scrollableDiv = container.querySelector("div:last-child");
            if (scrollableDiv && scrollPositions[n]) {
                scrollableDiv.scrollTop = scrollPositions[n];
            }
        });
    }

    e.parentNode.insertBefore(container, e);
    container.appendChild(e);

    // Clone header
    var u = document.createElement("table");
    for (s = 0; s < e.attributes.length; s++) {
        if (e.attributes[s].specified && e.attributes[s].name !== "id") {
            u.setAttribute(e.attributes[s].name, e.attributes[s].value);
        }
    }
    u.style.cssText = e.style.cssText;
    u.appendChild(document.createElement("tbody"));
    u.getElementsByTagName("tbody")[0].appendChild(e.getElementsByTagName("TR")[0]);

    var a = u.getElementsByTagName("TH");
    var f = e.getElementsByTagName("TR")[0];

    for (var s = 0; s < a.length; s++) {
        var l = Math.max(i[s], f.getElementsByTagName("TD")[s]?.offsetWidth || 0);
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

    // Restore scroll position if available
    if (scrollPositions[n]) {
        h.scrollTop = scrollPositions[n];
    }

    // Save scroll position on scroll
    h.onscroll = function () {
        scrollPositions[n] = h.scrollTop;
    };

    // Reapply search if needed
    if (e.id === "gvAspects" && searchValues[n]) {
        setTimeout(() => {
            searchBox.dispatchEvent(new Event("input"));
        }, 0);
    }
}

// jQuery plugin wrapper
(function (e) {
    e.fn.Scrollable = function (t) {
        var n = { ScrollHeight: 300, Width: 0, IsInUpdatePanel: false };
        t = e.extend(n, t);

        return this.each(function () {
            var n = e(this).get(0);
            var r = n.id;
            MakeScrollable(n, t);

            if (t.IsInUpdatePanel) {
                var i = Sys.WebForms.PageRequestManager.getInstance();
                if (i != null) {
                    i.add_endRequest(function () {
                        MakeScrollable(e("#" + r).get(0), t);
                    });
                }
            }
        });
    };
})(jQuery);