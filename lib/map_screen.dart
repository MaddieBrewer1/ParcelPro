import 'package:flutter/material.dart';
import 'package:parcel_pro/components/get_map_widget.dart';

class MapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Parcel Pro'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 0, 153, 255),
      ),
      body: MyMapWidget(),
    );
  }
}
