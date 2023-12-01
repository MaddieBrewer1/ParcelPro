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
  late List<List<TextFormField>> editInnerFields;

  //TextEditingController textController = TextEditingController();

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
        //editInnerFields = buildInnerFields
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
          //for(List<TextFormField> list in EditInnerFields)

          //for (List<LatLng> list in widget.innerRings)
          for (int i = 0; i < widget.innerRings.length; i++)
            Column(
              children: [
                EditInnerCoordinates(
                    context,
                    editInnerFields[i] =
                        buildInnerFields(widget.innerRings[i], i)),
                IconButton(
                    onPressed: () => setState(() {
                          LatLng newLatLng = LatLng(0.0, 0.0);
                          //list.add(newLatLng);
                          widget.innerRings[i].add(newLatLng);
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
                      // print("confirm clicked");
                      // print("Outer");
                      // for (int i = 0; i < editFields.length; i++) {
                      //   print(editFields[i].controller?.text);
                      // }
                      // print("holes");
                      // for (int i = 0; i < editInnerFields.length; i++) {
                      //   print("hole " + i.toString());
                      //   for (int j = 0; j < editInnerFields[i].length; j++) {
                      //     print(editInnerFields[i][j].controller?.text);
                      //   }
                      // }

                      var polyText = "MULTIPOLYGON(((";
                      for (TextFormField widget in editFields) {
                        try {
                          String latlng = widget.controller!.text;
                          var latlngarray = latlng.split(",");
                          polyText +=
                              latlngarray[1] + " " + latlngarray[0] + ",";
                        } catch (e) {}
                      }
                      polyText = polyText.substring(0, polyText.length - 1);
                      polyText += ")";

                      for (List<TextFormField> list in editInnerFields) {
                        polyText += ",(";
                        for (TextFormField widget in list) {
                          try {
                            String latlng = widget.controller!.text;
                            var latlngarray = latlng.split(",");
                            polyText +=
                                latlngarray[1] + " " + latlngarray[0] + ",";
                            if (list == editInnerFields.last &&
                                widget == list.last) {
                              polyText =
                                  polyText.substring(0, polyText.length - 1);
                            }
                          } catch (e) {}
                        }
                        polyText += ")";
                      }

                      polyText += "))";

                      print(polyText);
                      //dynamic id = widget.polygonId;
                      final editURI = Uri.http('3.94.113.50', '/editParcel', {
                        "objectid": widget.polygonId.toString(),
                        "polygon": polyText,
                        "key": "3127639894533413"
                      });

                      final response = await http.get(editURI);
                      widget.callback();

                      // try {
                      //   var start = inserts[0].controller!.text;
                      //   var latlngarray = start.split(",");
                      //   polyText += latlngarray[1] + " " + latlngarray[0] + ")))";
                      // } catch (e) {}

                      // final deleteURI = Uri.http('3.94.113.50', '/insertParcel', {
                      //   "polygon": polyText,
                      //   "key": "3127639894533413"
                      // });

                      // final response = await http.get(deleteURI);
                      // widget.callback();
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
        ],
      );
    }
  }

  List<TextFormField> buildFields() {
    List<TextFormField> temp = [];
    for (int i = 0; i < widget.outerRings.length; i++) {
      // print(widget.outerRings[i]);
      temp.add(EditTextField(i, widget.outerRings, true));
    }
    return temp;
  }

  List<TextFormField> buildInnerFields(List<LatLng> latlng, int index) {
    if (index == 0) {
      editInnerFields.clear();
    }
    List<TextFormField> temp = [];
    for (int i = 0; i < latlng.length; i++) {
      temp.add(EditTextField(i, latlng, false));
    }
    editInnerFields.add(temp);
    return temp;
  }

  String latLngToString(LatLng latlng) {
    String tempString = latlng.toString();
    String resultString = tempString.replaceAll(RegExp('([^0-9 ,-\.])'), '');
    return resultString;
  }

  LatLng stringToLatLng(String string) {
    var splitString = string.split(',');
    for (var strings in splitString) {
      strings = strings.replaceAll(' ', '');
    }
    return LatLng(double.parse(splitString[0]), double.parse(splitString[1]));
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

  TextFormField EditTextField(int i, List<LatLng> list, bool ring) {
    TextEditingController textController = TextEditingController();
    textController.text = latLngToString(list[i]);
    return TextFormField(
      style: TextStyle(color: Colors.white),
      //initialValue: latLngToString(list[i]),
      controller: textController,
      onChanged: (value) {
        setState(() {
          if (ring) {
            widget.outerRings[i] = stringToLatLng(value);
          } else {
            widget.innerRings[widget.innerRings.indexOf(list)][i] =
                stringToLatLng(value);
          }
        });
      },
      decoration: InputDecoration(
          suffixIcon: IconButton(
            icon: Icon(Icons.close),
            onPressed: () => setState(() {
              //list.removeAt(i);
              if (ring) {
                widget.outerRings.removeAt(i);
              } else {
                widget.innerRings[widget.innerRings.indexOf(list)].removeAt(i);
              }
            }),
            color: Colors.white,
          ),
          filled: true,
          fillColor: Color.fromARGB(255, 69, 90, 100)),
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
