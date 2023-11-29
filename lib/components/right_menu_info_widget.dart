import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:parcel_pro/components/map_widget.dart';

class right_menu_info_widget extends StatelessWidget {
  final int rightMenuState;
  final VoidCallback callback;
  const right_menu_info_widget({
    Key? key,
    required this.rightMenuState,
    required this.callback,
  }) : super(key: key);

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
            Text(
              "About Parcel Pro",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
              ),
            ),
            Spacer(
              flex: 3,
            ),
            Text(
              "Editing a Parcel",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "With the edit option, you can choose to either merge 2 parcels, split a parcel, or edit the coordinates of a parcel.",
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "   - Merging parcels will combine two separate parcels into a singular larger parcel.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "   - Splitting parcels will split a singluar parcel into two separate parcels.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "   - You can edit a parcel by altering the coordinates of the parcel.",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              "Inserting a Parcel",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "With the insert option, you can insert a parcel by entering its coordinates.",
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              "Deleting a Parcel",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "A parcel can be deleted by selecting it from the map",
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
            Spacer(
              flex: 2,
            ),
            Text(
              "Displaying Parcel\nInformation",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Simply click on a parcel in the map to display its information",
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
            Spacer(
              flex: 1,
            ),

            // RichText(
            //   text: TextSpan(
            //     style: TextStyle(color: Colors.white, fontSize: 20.0),
            //     children: [
            //       TextSpan(text: 'About ParcelPro'),
            //     ],
            //   ),
            // ),
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
