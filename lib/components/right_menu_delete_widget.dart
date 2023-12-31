import 'package:flutter/material.dart';
//import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:parcel_pro/components/map_widget.dart';
import 'package:http/http.dart' as http;

class right_menu_delete_widget extends StatefulWidget {
  final int rightMenuState;
  final VoidCallback callback;
  final parcelText;
  final selectDelete;
  final int polygonId;
  const right_menu_delete_widget({
    Key? key,
    required this.rightMenuState,
    required this.callback,
    required this.parcelText,
    required this.selectDelete,
    required this.polygonId,
  }) : super(key: key);
  @override
  right_menu_delete_state createState() => right_menu_delete_state();
}

class right_menu_delete_state extends State<right_menu_delete_widget> {
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
                  TextSpan(text: 'Delete Parcel'),
                ],
              ),
            ),
            _container(context),
          ],
        ),
      ),
    ));
  }

  Widget _container(BuildContext context) {
    if (!widget.selectDelete) {
      return Container(
          margin: EdgeInsets.only(top: 120.0),
          child: Text(
            'Select Parcel',
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ));
    } else {
      return Column(
        children: [
          Container(
              margin: EdgeInsets.fromLTRB(15, 100, 15, 10),
              child: const Text(
                "Are you sure you would like to delete this parcel?",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
          Container(
              margin: const EdgeInsets.fromLTRB(15, 10, 15, 10),
              color: Colors.blueGrey[700],
              child: Text(
                widget.parcelText,
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(
                flex: 1,
              ),
              TextButton(
                  onPressed: () => widget.callback(),
                  style: flatButtonStyle,
                  child: const Text(
                    "Cancel",
                  )),
              const Spacer(
                flex: 1,
              ),
              TextButton(
                  //untested
                  onPressed: () async {
                    final deleteURI = Uri.http('3.94.113.50', '/deleteParcel', {
                      "objectid": widget.polygonId.toString(),
                      "key": "3127639894533413"
                    });
                    final response = await http.get(deleteURI);
                    widget.callback();
                  },
                  style: flatButtonStyle,
                  child: const Text(
                    "Delete",
                  )),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ],
      );
    }
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
