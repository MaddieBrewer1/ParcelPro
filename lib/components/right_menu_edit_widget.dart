import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parcel_pro/components/map_widget.dart';
import 'package:http/http.dart' as http;

class right_menu_edit_widget extends StatefulWidget {
  final int rightMenuState;
  final VoidCallback callback;
  final parcelText;
  final selectEdit;
  final int polygonId;
  final List<LatLng> outerRings;
  final List<List<LatLng>> innerRings;

  const right_menu_edit_widget({
    Key? key,
    required this.rightMenuState,
    required this.callback,
    required this.parcelText,
    required this.selectEdit,
    required this.polygonId,
    required this.innerRings,
    required this.outerRings,
  }) : super(key: key);
  @override
  right_menu_edit_state createState() => right_menu_edit_state();
}

class right_menu_edit_state extends State<right_menu_edit_widget> {
  late List<TextFormField> editFields;
  late List<TextFormField> editInnerFields;

  @override
  void initState() {
    editFields = [];
    editInnerFields = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Align(
      alignment: Alignment.topRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.25,
        color: Colors.blueGrey,
        child: Column(
          children: [
            Container(
                alignment: Alignment.topLeft,
                child: CloseButton(
                  color: Color.fromARGB(255, 236, 236, 236),
                  onPressed: () => widget.callback(),
                )),
            RichText(
              text: const TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        Icons.cancel_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextSpan(text: 'Edit Parcel'),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                  scrollDirection: Axis.vertical, child: _container(context)),
            ),
          ],
        ),
      ),
    ));
  }

  Widget _container(BuildContext context) {
    if (!widget.selectEdit) {
      return Container(
          margin: EdgeInsets.only(top: 120.0),
          child: Text(
            'Select Parcel',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ));
    } else {
      setState(() {
        editFields = buildFields();
        // editInnerFields = buildInnerFields();
      });
      return Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(15, 100, 15, 10),
              child: const Text(
                "Edit Coordinates:",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
          EditCoordinates(context),
          IconButton(
              onPressed: () => setState(() {
                    LatLng newLatLng = LatLng(0.0, 0.0);
                    widget.outerRings.add(newLatLng);
                  }),
              icon: Icon(
                Icons.add_rounded,
                color: Colors.white,
              )),
          //EditCoordinates(context, widget.innerRings),
          for (List<LatLng> list in widget.innerRings)
            Column(
              children: [
                EditInnerCoordinates(context, buildInnerFields(list)),
                IconButton(
                    onPressed: () => setState(() {
                          LatLng newLatLng = LatLng(0.0, 0.0);
                          list.add(newLatLng);
                        }),
                    icon: Icon(
                      Icons.add_rounded,
                      color: Colors.white,
                    )),
              ],
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                    onPressed: () => widget.callback(),
                    style: flatButtonStyle,
                    child: const Text(
                      "Cancel",
                    )),
              ),
              const Spacer(
                flex: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextButton(
                    //untested
                    onPressed: () async {
                      //code for editing the parcel
                    },
                    style: flatButtonStyle,
                    child: const Text(
                      "Confirm",
                    )),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
          // Container(
          //     margin: EdgeInsets.only(bottom: 15),
          //     child: TextButton.icon(
          //       onPressed: () async { //convert list to latitudes
          //         var polyText = "MULTIPOLYGON(((";
          //         for (TextField widget in inserts){
          //           try {
          //             String latlng = widget.controller!.text;
          //             var latlngarray = latlng.split(",");
          //             polyText += latlngarray[1] + " " + latlngarray[0] + ",";
          //           } catch  (e) {}
          //         }

          //         try {
          //           var start = inserts[0].controller!.text;
          //           var latlngarray = start.split(",");
          //           polyText += latlngarray[1] + " " + latlngarray[0] + ")))";
          //         } catch (e) {}

          //         final deleteURI = Uri.http('3.94.113.50', '/insertParcel', {
          //           "polygon": polyText,
          //           "key": "3127639894533413"
          //         });

          //         final response = await http.get(deleteURI);
          //         widget.callback();
          //       },
          //       icon: Icon(
          //         Icons.check_circle_outline,
          //         color: Colors.white,
          //         size: 25,
          //       ),
          //       label: Text(
          //         "Done",
          //         style: TextStyle(color: Colors.white, fontSize: 20),
          //       ),
          //     ),
          //   )
        ],
      );
    }
  }

  // Widget innerRingLists() {
  //   List<Widget> fuckthis = [];
  //   for (List<LatLng> l in widget.innerRings) {
  //     fuckthis.add(EditCoordinates(context, l));
  //   }
  //   return (context, fuckthis)
  // }

  List<TextFormField> buildFields() {
    List<TextFormField> temp = [];
    for (int i = 0; i < widget.outerRings.length; i++) {
      // print(widget.outerRings[i]);
      temp.add(EditTextField(i, widget.outerRings));
    }
    return temp;
  }

  // List<TextFormField> buildInnerFields() {
  //   List<TextFormField> temp = [];
  //   for (int j = 0; j < widget.innerRings.length; j++) {
  //     for (int i = 0; i < widget.innerRings[j].length; i++) {
  //       print(widget.innerRings[i]);
  //       temp.add(EditTextField(i, widget.outerRings));
  //     }
  //   }

  //   return temp;
  // }
  List<TextFormField> buildInnerFields(List<LatLng> l) {
    List<TextFormField> temp = [];
    for (int i = 0; i < l.length; i++) {
      // print(l[i]);
      temp.add(EditTextField(i, l));
    }
    return temp;
  }

  String latLngToString(LatLng l) {
    String s = l.toString();
    String res = s.replaceAll(RegExp('([^0-9 ,-\.])'), '');
    return res;
  }

  Widget EditCoordinates(BuildContext context) {
    return Container(
      key: Key(editFields.length.toString()),
      alignment: Alignment.center,
      height: editFields.length * 50,
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: editFields.length,
          itemBuilder: (BuildContext context, int index) {
            return editFields[index];
          }),
    );
  }

  Widget EditInnerCoordinates(BuildContext context, List<TextFormField> t) {
    return Container(
      alignment: Alignment.center,
      height: t.length * 50,
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: t.length,
          itemBuilder: (BuildContext context, int index) {
            return t[index];
          }),
    );
  }

  TextFormField EditTextField(int i, List<LatLng> list) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      initialValue: latLngToString(list[i]),
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => setState(() {
              list.removeAt(i);
            }),
            color: Colors.white,
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 69, 90, 100)),
      //controller: TextEditingController(),
    );
  }
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
  primary: Colors.white,
  minimumSize: Size(88, 44),
  padding: EdgeInsets.symmetric(horizontal: 16.0),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2.0)),
  ),
  backgroundColor: Colors.blueGrey[700],
);
