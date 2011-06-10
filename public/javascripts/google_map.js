var points = [];
var marker = null;
var highlighted_marker = null;
var point_markers = [];
var map;
var polyline;
var areas = []
var index_areas = []
var search_point = null
// Add a point to the points list.
function addPoint() {
    var lat = document.getElementById('txtLatitude').value;
    var pLat = parseFloat(lat);

    if (pLat.toString() != lat) {
        alert('Invalid latitude entered. Must be in range of -90 to 90');
        return;
    }

    if (pLat < -90 || pLat > 90) {
        alert('Invalid latitude entered. Must be in range of -90 to 90');
        return;
    }

    var lng = document.getElementById('txtLongitude').value;
    var pLong = parseFloat(lng);

    if (pLong.toString() != lng) {
        alert('Invalid longitude entered. Must be in range of -180 to 180');
        return;
    }

    if (pLong < -180 || pLong > 180) {
        alert('Invalid longitude entered. Must be in range of -180 to 180');
        return;
    }

    var level = document.getElementById('txtLevel').value;
    var pLevel = parseInt(level);

    if (pLevel.toString() != level) {
        alert('Invalid minimum level entered. Must be in range of 0 to 3');
        return;
    }

    if (pLevel < 0 || pLevel > 3) {
        alert('Invalid minimum level entered. Must be in range of 0 to 3');
        return;
    }
    createPoint(lat, lng, pLevel);
    createEncodings(false);
//var CoordPoint = '(' + point.Latitude + ','  + point.Longitude + ')';
//alert(CoordPoint);
//document.getElementById('ListeDePoints').value = CoordPoint;
}


// Returns the index of the marker in the polyline.
function findMarkerIndex(point_marker) {
    var index = -1;

    for (var  i = 0; i < point_markers.length; ++i) {
        if (point_markers[i] == point_marker) {
            index = i;
            break;
        }
    }

    return index;
}


// Creates a point and adds it to both the polyline and the list.
function createPoint(lat, lng, pLevel) {
    addPointItem(lat, lng, pLevel);

    var newPoint = {
        Latitude: lat,
        Longitude: lng,
        Level: pLevel
    };

    points.push(newPoint);

    if (marker) {
        marker.setMap(null);
        marker = null;
    }

    var point_marker = createPointMarker(new google.maps.LatLng(lat, lng), false);
    point_markers.push(point_marker);
}


// Creates a marker representing a point in the polyline.
function createPointMarker(point, highlighted) {
        
    var clr = highlighted ? "yellow" : "blue";

    var point_marker = createMarker(point, clr);

    google.maps.event.addListener(point_marker, "drag", function(event) {
        var index = findMarkerIndex(point_marker);

        if (index >= 0) {
            var nLat = event.latLng.lat();
            var nLng = event.latLng.lng();

            var pLevel = points[index].Level;

            var modifiedPoint = {
                Latitude: nLat,
                Longitude: nLng,
                Level: pLevel
            };

            points[index] = modifiedPoint;
            createEncodings(false);
            document.getElementById('pointList').options[index]
            = new Option(nLat + ',' + nLng, index);

        // = new Option('(' + nLat + ',' + nLng + ')', index);
        }
    });

    google.maps.event.addListener(point_marker, "click", function() {
        highlight(findMarkerIndex(point_marker));
    });

    return point_marker;
}


// Add an option to the points list with the specified information.
function addPointItem(lat, lng, pLevel) {
    var displayPoint = new Option(lat + ',' + lng, points.length);
    //var displayPoint = new Option('(' + lat + ',' + lng + ')', points.length);
    document.getElementById('pointList').options.add(displayPoint);
}


// Highlights the point specified by index in both the map and the point list.
function highlight(index) {
    var pointList = document.getElementById('pointList');

    if (index < pointList.length) {
        pointList.selectedIndex = index;
    }

    if (point_markers[index] != null
        && point_markers[index] != highlighted_marker) {
        point_markers[index].setMap(null);
    }

    if (highlighted_marker != null) {
        var oldIndex = findMarkerIndex(highlighted_marker);
        highlighted_marker.setMap(null)

        if (oldIndex != index) {
            point_markers[oldIndex]
            = createPointMarker(highlighted_marker.getPosition(), false);
        }
    }

    highlighted_marker = createPointMarker(point_markers[index].getPosition(),
        true);
    point_markers[index] = highlighted_marker;
}


// Delete *all* the points from the polyline, with confirmation dialog before
// deletion.
function deleteAllPoints() {
    //var deleteConfirm = confirm("Êtes vous sur de vouloir effacer tous les points ?");

    //if (deleteConfirm) {
        document.getElementById('pointList').options.length = 0;
        points = [];
        deleteAllMarkers();
        createEncodings();
    //}
}


// Deletes all the markers for the points in the polyline
function deleteAllMarkers() {
    for(var i = 0; i < point_markers.length; ++i) {
        point_markers[i].setMap(null)
    }

    point_markers = [];
    highlighted_marker = null;
}


// Delete a point from the polyline.
function deletePoint()
{
    if (points.length > 0)
    {
        var point_index = document.getElementById('pointList').selectedIndex;

        if (point_index >= 0 && point_index < points.length)
        {
            points.splice(point_index, 1);

            if (highlighted_marker == point_markers[point_index])
            {
                highlighted_marker = null;
            }

            point_markers[point_index].setMap(null)
            point_markers.splice(point_index, 1);
            document.getElementById('pointList').options[point_index] = null;
            createEncodings();
        }

        if (points.length > 0) {
            if (point_index == 0) {
                point_index++;
            }

            highlight(point_index - 1);
        }
    }
}


// Create the encoded polyline and level strings. If moveMap is true
// move the map to the location of the first point in the polyline.
function createEncodings(moveMap) {
    var i = 0;

    // move if moveMap is true.
    if (moveMap) {
        map.setCenter(
            new google.maps.LatLng(points[0].Latitude, points[0].Longitude),
            map.getZoom());
    }
    coordinates = []
    for(i = 0; i < points.length; ++i) {
        coordinates[i] = new google.maps.LatLng(points[i].Latitude, points[i].Longitude)
    }
    if(polyline){
        polyline.setMap(null)
    }
    if (points.length > 1) {
        polyline = new google.maps.Polyline({
            path: coordinates,
            strokeColor: "#0000FF",
            strokeOpacity: 1.0,
            strokeWeight: 2,
            map: map
        });
    }

}

function centerMap() {
    var address = document.getElementById('txtAddress').value;
    if (search_point) search_point.setMap(null);
    if (address.length > 0) {
        var geocoder = new google.maps.Geocoder();

        geocoder.geocode({
            'address': address
        },
        function(results, status) {
            if (status == google.maps.GeocoderStatus.OK) {
                map.setCenter(results[0].geometry.location);
                search_point = createMarker(results[0].geometry.location, 'red')
                search_proximity_area(results[0].geometry.location)
            }
        });
    }
}


function createMarker(point, color) {
    var image = new google.maps.MarkerImage("http://labs.google.com/ridefinder/images/mm_20_" + color + ".png",
        new google.maps.Size(12, 20),
        new google.maps.Point(0,0),
        new google.maps.Point(6, 20)
        )
    var shadow = new google.maps.MarkerImage( "http://labs.google.com/ridefinder/images/mm_20_shadow.png",
        new google.maps.Size(22, 20),
        new google.maps.Point(0,0),
        new google.maps.Point(6, 20)
        )
    var shape = {
        coord: [1, 1, 1, 20, 18, 20, 18 , 1],
        type: 'poly'
    };
    var newMarker = new google.maps.Marker({
        position: point,
        map: map,
        shadow: shadow,
        icon: image,
        shape: shape,
        draggable: true
    });

    return newMarker;
}

// Create the Google Map to be used.
function createMap() {
    var latlng = new google.maps.LatLng(45.76201437142477, 4.834842681884766);

    var myOptions =
    {
        zoom: 15,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

    google.maps.event.addListener(map, "click", function(event) {
        document.getElementById('txtLatitude').value = event.latLng.lat();
        document.getElementById('txtLongitude').value = event.latLng.lng();
        
        if (marker == null) {
            
            marker = createMarker(event.latLng, "green");
            

            google.maps.event.addListener(marker, "drag", function(event) {
                document.getElementById('txtLatitude').value = event.latLng.lat();
                document.getElementById('txtLongitude').value = event.latLng.lng();
            });
        } else {
            marker.setPosition(event.latLng);
        }

    })


}


// Move the map to the selected point in the point list.
function jumpToPoint() {
    var pointList = document.getElementById('pointList');
    if (pointList.selectedIndex >= 0) {
        var point = points[pointList.selectedIndex];
        map.setCenter(new google.maps.LatLng(point.Latitude, point.Longitude), 
            map.getZoom());
    }
}


function sendPoints(){
    val = ""
    for(i = 0; i < $("#pointList")[0].options.length; i++){
        val += $("#pointList")[0].options[i].innerHTML
        if(i < $("#pointList")[0].options.length -1) val += ";";
    }
    $("#area_points_list")[0].value = val
    $("#area_form")[0].submit()
}

function drawArea(points_ary, area_id){
    coordinates = []
    for (i=0; i<points_ary.length; i++){
        coordinates[i] = new google.maps.LatLng(points_ary[i][0], points_ary[i][1]);
    }
    coordinates[points_ary.length] = new google.maps.LatLng(points_ary[0][0], points_ary[0][1]);

    var monpolygone = new google.maps.Polygon({
        paths: coordinates,
        strokeColor: "#990000",
        strokeOpacity: 1,
        strokeWeight: 1,
        fillColor: "#ff0000",
        fillOpacity: 0.2,
        map: map
    })
    google.maps.event.addListener(monpolygone, "click", function(event){
        remote_edition(area_id)
    })
    areas.push(monpolygone)
    index_areas.push(area_id)

}

function addPointsFromList(point_list){
    ary_points = point_list.split(";")
    for (i=0; i<ary_points.length; i++){

        coordinates = ary_points[i].split(",")
        createPoint(coordinates[0], coordinates[1], 3);
        createEncodings(false);

    }

}

function remote_edition(area_id){
    $.ajax({
        url: "/areas/" + area_id + "/edit.js",
        dataType: "html",
        success: function(html){
            datas = html.split("########################")
            $("#area_block")[0].innerHTML = datas[0]
            deleteAllPoints();
            addPointsFromList(datas[2]);
        },
        error: function(data, test, error){ alert("error" + test + " ### "+ error)}
    });
}

function search_proximity_area(point_to_search){
    $.ajax({
        url: "/areas/proximity_area.js",
        data: "latitude="+point_to_search.lat()+"&longitude="+point_to_search.lng(),
        dataType: "html",
        success: function(html){
            alert(html)
        },
        error: function(data, test, error){ alert("error" + test + " ### "+ error)}
    });
}