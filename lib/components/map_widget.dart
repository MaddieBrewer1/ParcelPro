import 'dart:collection';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyMapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MyMapWidget> {
  GoogleMapController? _control;
  late GoogleMap map;
  Set<Polygon> _polygon = HashSet<Polygon>();
  var id = 0;
  
  @override
  Widget build(BuildContext context) {
    map = GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(29.654388, -82.337451), // Initial map center
          zoom: 12.0, // Initial zoom level
        ),
        onCameraIdle: mapUpdate,
        onMapCreated: onMap,
        polygons: _polygon
    );

    return map;
  }

  void mapUpdate() async {
    var bounds = await _control!.getVisibleRegion();
    final queryParams = {
      "lat1": bounds.southwest.latitude.toString(),
      "long1": bounds.southwest.longitude.toString(),
      "lat2": bounds.northeast.latitude.toString(),
      "long2": bounds.northeast.longitude.toString()
    };
    final uri = Uri.http("3.94.113.50", '', queryParams);
    final response = await http.get(uri);

    Map<String, dynamic> data = json.decode(response.body);
    List<Polygon> polygons;

    _polygon.clear();
    for (dynamic i in data['parcels']){
      List<LatLng> latlngs = [];
      var objID = i['objectid'];
      var polyText = i['st_astext'].toString();
      polyText = polyText.replaceAll(RegExp("([a-zA-Z()])*"), "");

      for (String j in polyText.split(",")){
        List<String> k = j.split(" ");
        latlngs.add(LatLng(double.parse(k[1]), double.parse(k[0])));
      }

      map.polygons.add(Polygon(polygonId: PolygonId(objID.toString())
        , points: latlngs
        , fillColor: Colors.green.withOpacity(0.3)
        , strokeColor: Colors.green
        , geodesic: true
        , strokeWidth: 4
        , onTap: () => _onParcelTap(objID)));
      id++;
    }
    
    setState(() {
    });
  }

  void onMap(GoogleMapController controller){
    _control = controller;
  }

  void _onParcelTap(int polygonId) async {
    print("Parcel with ID: $polygonId was clicked!");

    final parceluri = Uri.http('3.94.113.50','/parcel', {"objectid": polygonId.toString()});
    final response = await http.get(parceluri);

    var data = json.decode(response.body);
    print("returned info: $data");
  }
}
