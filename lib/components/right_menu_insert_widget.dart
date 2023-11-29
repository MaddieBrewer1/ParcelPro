import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:parcel_pro/components/map_widget.dart';
import 'package:http/http.dart' as http;

class right_menu_insert_widget extends StatefulWidget {
  final int rightMenuState;
  final VoidCallback callback;
  const right_menu_insert_widget({
    Key? key,
    required this.rightMenuState,
    required this.callback,
  }) : super(key: key);
  @override
  right_menu_insert_state createState() => right_menu_insert_state();
}

class right_menu_insert_state extends State<right_menu_insert_widget> {
  late List<TextField> inserts;

  @override
  void initState() {
    super.initState();
    inserts = [insertTextField()];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Align(
      alignment: Alignment.topRight,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.15,
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
              text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        Icons.arrow_downward_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextSpan(text: 'Insert Parcel'),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  insertCoordinates(context, inserts),
                  IconButton(
                      onPressed: () => setState(() {
                            inserts.add(insertTextField());
                          }),
                      icon: Icon(
                        Icons.add_rounded,
                        color: Colors.white,
                      )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 15),
              child: TextButton.icon(
                onPressed: () async { //convert list to latitudes
                  var polyText = "MULTIPOLYGON(((";
                  for (TextField widget in inserts){
                    try {
                      String latlng = widget.controller!.text;
                      var latlngarray = latlng.split(",");
                      polyText += latlngarray[1] + " " + latlngarray[0] + ",";
                    } catch  (e) {}
                  }

                  try {
                    var start = inserts[0].controller!.text;
                    var latlngarray = start.split(",");
                    polyText += latlngarray[1] + " " + latlngarray[0] + ")))";
                  } catch (e) {}

                  final deleteURI = Uri.http('3.94.113.50', '/insertParcel', {
                    "polygon": polyText,
                    "key": "3127639894533413"
                  });

                  final response = await http.get(deleteURI);
                  widget.callback();
                },
                icon: Icon(
                  Icons.check_circle_outline,
                  color: Colors.white,
                  size: 25,
                ),
                label: Text(
                  "Done",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }

  Widget insertCoordinates(BuildContext context, List<Widget> inserts) {
    return Container(
      alignment: Alignment.center,
      height: inserts.length * 50,
      child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: inserts.length,
          itemBuilder: (BuildContext context, int index) {
            print(inserts.length);
            return inserts[index];
          }),
    );
  }

  TextField insertTextField() {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: Color.fromARGB(255, 69, 90, 100),
          hintStyle: TextStyle(color: Colors.white),
          hintText: "Enter Coordinate"),
      controller: TextEditingController(),
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
  backgroundColor: Colors.grey[800],
);
