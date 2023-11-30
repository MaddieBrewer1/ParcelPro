import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:parcel_pro/components/map_widget.dart';
import 'package:http/http.dart' as http;

class right_menu_parcel_info extends StatelessWidget {
  final String rightMenuText;
  final VoidCallback callback;
  final int polygonId;
  const right_menu_parcel_info(
      {Key? key,
      required this.rightMenuText,
      required this.callback,
      required this.polygonId})
      : super(key: key);

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
                  onPressed: () => callback(),
                )),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.white, fontSize: 20.0),
                children: [
                  WidgetSpan(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
                      child: Icon(
                        Icons.edit_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  TextSpan(text: 'Parcel Information'),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SelectableText(
                  //should we wrap with single child scroll view to prevent overflow?
                  rightMenuText,
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              style: flatButtonStyle,
              onPressed: () async {
                final deleteURI = Uri.http('3.94.113.50', '/deleteParcel', {
                  "objectid": polygonId.toString(),
                  "key": "3127639894533413"
                });
                final response = await http.get(deleteURI);
                callback();
              },
              child: Text('Delete this Parcel'),
            ),
          ],
        ),
      ),
    ));
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
