import 'package:flutter/material.dart';
// import 'package:parcel_pro/components/map_widget.dart';
import 'package:parcel_pro/components/left_menu_widget.dart';
import 'package:parcel_pro/components/map_widget.dart';
import 'package:parcel_pro/components/right_menu_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //return Scaffold(
    // appBar: AppBar(
    //   title: Text('Parcel Pro'),
    //   centerTitle: true,
    //   backgroundColor: Color.fromARGB(255, 0, 153, 255),
    // ),
    //body: left_menu_widget(),
    //);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            child: MyMapWidget(),
          ),
          left_menu_widget(),
          right_menu_widget(),
        ],
      ),
    );
  }
}
