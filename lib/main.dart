import 'package:flutter/material.dart';
import 'package:parcel_pro/map_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Parcel Pro',
      home: MapScreen(),
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(

      // ),
    );
  }
}
