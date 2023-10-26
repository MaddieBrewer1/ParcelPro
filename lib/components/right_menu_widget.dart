import 'package:flutter/material.dart';
//import 'package:collapsible_sidebar/collapsible_sidebar.dart';
//import 'package:parcel_pro/components/map_widget.dart';

// class right_menu_widget extends StatefulWidget {
//   @override
//   right_menu_widget_state createState() => right_menu_widget_state();
// }

class right_menu_widget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Align(
      alignment: Alignment.topRight,
      child: Container(
        // child: Text("THis is text"),
        width: MediaQuery.of(context).size.width * 0.15,
        color: Colors.grey,
        child: const Column(
          children: [
            Text("This is the right sidebar"),
          ],
        ),
      ),
    ));
  }
}
