import 'dart:collection';
import 'dart:js_util';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:parcel_pro/components/left_menu_widget.dart';
import 'dart:convert';

import 'package:parcel_pro/components/right_menu_edit_widget.dart';
import 'package:parcel_pro/components/right_menu_delete_widget.dart';
import 'package:parcel_pro/components/right_menu_insert_widget.dart';
import 'package:parcel_pro/components/right_menu_info_widget.dart';
import 'package:parcel_pro/components/right_menu_parcel_info.dart';

class MyMapWidget extends StatefulWidget {
  @override
  _MapWidgetState createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MyMapWidget> {
  GoogleMapController? _control;
  late GoogleMap map;
  Set<Polygon> _polygon = HashSet<Polygon>();
  var id = 0;

  var displayRight = false;
  var selectDelete = false;
  var selectEdit = false;
  List<LatLng> outers = [];
  List<List<LatLng>> inners = [];
  String rightText = "";
  var polygonId = -1;
  var menuId = 0;
  void setMenuId(int id) {
    setState(() {
      menuId = id;
    });
  }

  @override
  Widget build(BuildContext context) {
    map = GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: LatLng(29.654388, -82.337451), // Initial map center
          zoom: 12.0, // Initial zoom level
        ),
        onCameraIdle: mapUpdate,
        onMapCreated: onMap,
        polygons: _polygon);

    return Scaffold(
      body: Row(
        children: <Widget>[
          left_menu_widget(setMenuId),
          Expanded(
            child: map,
          ),
          (() {
            switch (menuId) {
              case 0:
                return const Opacity(opacity: 0.0);
              case 1:
                displayRight = false;
                return right_menu_edit_widget(
                  callback: () => setState(() {
                    selectEdit = false;
                    menuId = 0;
                  }),
                  rightMenuState: menuId,
                  selectEdit: selectEdit,
                  parcelText: rightText,
                  polygonId: polygonId,
                  innerRings: inners,
                  outerRings: outers,
                );
              case 2:
                displayRight = false;
                return right_menu_insert_widget(
                    callback: () => setState(() {
                          menuId = 0;
                          mapUpdate();
                        }),
                    rightMenuState: menuId);
              case 3:
                displayRight = false;
                return right_menu_delete_widget(
                  callback: () => setState(() {
                    menuId = 0;
                    selectDelete = false;
                  }),
                  rightMenuState: menuId,
                  parcelText: rightText,
                  selectDelete: selectDelete,
                  polygonId: polygonId, //I think this is right?
                );
              case 4:
                displayRight = false;
                return right_menu_info_widget(
                    callback: () => setState(() => menuId = 0),
                    rightMenuState: menuId);
              default:
                return const Opacity(opacity: 0.0);
            }
          }()),
          if (displayRight)
            right_menu_parcel_info(
                rightMenuText: rightText,
                callback: () => setState(() {
                      displayRight = false;
                      this.mapUpdate();
                    }),
                polygonId: polygonId)
        ],
      ),
    );
  }

  var running = false;
  void mapUpdate() async {
    if (!running) {
      running = true;
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

      final ringRegex = RegExp("([0-9 ,-\.][0-9][0-9 ,-\.]+)");
      _polygon.clear();

      for (dynamic i in data['parcels']) {
        List<LatLng> outerRing = [];
        List<List<LatLng>> innerRings = [];
        var objID = i['objectid'];
        var polyText = i['st_astext'].toString();
        var rings = ringRegex.allMatches(polyText);

        for (var i = 0; i < rings.length; i++) {
          if (i == 0) {
            for (String j in rings.elementAt(0).group(0)!.split(",")) {
              List<String> k = j.split(" ");
              outerRing.add(LatLng(double.parse(k[1]), double.parse(k[0])));
            }
          } else {
            List<LatLng> inner = [];
            for (String j in rings.elementAt(i).group(0)!.split(",")) {
              List<String> k = j.split(" ");
              inner.add(LatLng(double.parse(k[1]), double.parse(k[0])));
            }
            innerRings.add(inner);
          }
        }

        map.polygons.add(Polygon(
            polygonId: PolygonId(objID.toString()),
            points: outerRing,
            holes: innerRings,
            fillColor: Colors.green.withOpacity(0.3),
            strokeColor: Colors.green,
            geodesic: true,
            strokeWidth: 4,
            onTap: () => _onParcelTap(objID)));
        id++;
      }
      setState(() {});
      running = false;
    }
  }

  void onMap(GoogleMapController controller) {
    _control = controller;
  }

  void _onParcelTap(int polygonId) async {
    print("Parcel with ID: $polygonId was clicked!");

    final parceluri =
        Uri.http('3.94.113.50', '/parcel', {"objectid": polygonId.toString()});
    final response = await http.get(parceluri);

    var data = json.decode(response.body);

    var text = "";

    for (var entry in data.entries) {
      text += "${entry.key}: ${entry.value}\n";
    }

    if (menuId == 1) {
      final ringRegex = RegExp("([0-9 ,-\.][0-9][0-9 ,-\.]+)");
      List<LatLng> outerRing = [];
      List<List<LatLng>> innerRings = [];
      var polyText = "";
      // var objID = data.entries['objectid'];
      for (var entry in data.entries) {
        if (entry.key == 'st_astext') {
          polyText = entry.value;
        }
      }
      // var polyText = data.entries['st_astext'].toString();
      var rings = ringRegex.allMatches(polyText);

      for (var i = 0; i < rings.length; i++) {
        if (i == 0) {
          for (String j in rings.elementAt(0).group(0)!.split(",")) {
            List<String> k = j.split(" ");
            outerRing.add(LatLng(double.parse(k[1]), double.parse(k[0])));
          }
        } else {
          List<LatLng> inner = [];
          for (String j in rings.elementAt(i).group(0)!.split(",")) {
            List<String> k = j.split(" ");
            inner.add(LatLng(double.parse(k[1]), double.parse(k[0])));
          }
          innerRings.add(inner);
        }
      }

      setState(() {
        inners = innerRings;
        outers = outerRing;
        //rightText = ptext;
        this.polygonId = polygonId;
        selectEdit = true;
      });
    } else if (menuId == 3) {
      var ptext = "";
      List vals = [
        "oaddr1",
        "ocity",
        "ostate",
        "ozipcd",
        "phyaddr1",
        "phycity",
        "phyzip"
      ];
      for (var entry in data.entries) {
        if (vals.contains(entry.key)) {
          ptext += "${entry.key}: ${entry.value}\n";
        }
      }
      setState(() {
        rightText = ptext;
        this.polygonId = polygonId;
        selectDelete = true;
      });
    } else {
      setState(() {
        menuId = 0;
        displayRight = true;
        rightText = text;
        this.polygonId = polygonId;
      });
    }
  }
}
