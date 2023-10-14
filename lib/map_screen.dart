import 'package:flutter/material.dart';
import 'package:parcel_pro/components/map_widget.dart';
import 'package:parcel_pro/components/left_menu_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Parcel Pro'),
      //   centerTitle: true,
      //   backgroundColor: Color.fromARGB(255, 0, 153, 255),
      // ),
      body: left_menu_widget(),
    );
  }
}
