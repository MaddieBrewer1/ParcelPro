import 'package:flutter/material.dart';
import 'package:parcel_pro/components/right_menu_widget.dart';
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
      // routes: {
      //   '/' : (context) => MapScreen(),
      //   'Edit' : (context) => right_menu_widget(),
      //   'Insert' :(context) => right_menu_widget(),
      //   'delete' :(context) => right_menu_widget(),
      //   'settings' :(context) => right_menu_widget(),
      // },
    );
  }
}
