import 'dart:html';

import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
//import 'package:parcel_pro/components/map_widget.dart';
import 'package:parcel_pro/components/right_menu_widget.dart';
import 'package:parcel_pro/components/right_menu_edit_widget.dart';
import 'package:parcel_pro/components/right_menu_insert_widget.dart';
import 'package:parcel_pro/components/right_menu_delete_widget.dart';
import 'package:parcel_pro/components/right_menu_settings_widget.dart';

class left_menu_widget extends StatefulWidget {
  @override
  left_menu_widget_state createState() => left_menu_widget_state();
}

class left_menu_widget_state extends State<left_menu_widget> {
  double _width = 0.05;
  double fontsize = 0;
  bool open = false;
  Icon arrowIcon = Icon(Icons.arrow_forward_ios);
  String editLabel = 'Edit\nParcel';
  String insertLabel = 'Insert\nParcel';
  String deleteLabel = 'Delete\nParcel';
  String settingsLabel = 'Settings';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Align(
      alignment: Alignment.topLeft,
      child: AnimatedContainer(
        width: MediaQuery.of(context).size.width * _width,
        color: Colors.blueGrey,
        duration: const Duration(milliseconds: 200),
        curve: Curves.fastOutSlowIn,
        child: Column(
          children: [
            IconButton(
              iconSize: 25,
              icon: arrowIcon,
              color: Colors.white,
              onPressed: () => setState(() {
                open = !open;
                if (open) {
                  fontsize = 15;
                  _width = 0.15;
                  arrowIcon = Icon(Icons.arrow_back_ios);
                  //editLabel = ' Edit Parcel';
                  // insertLabel = ' Insert Parcel';
                  // deleteLabel = ' Delete Parcel';
                  // settingsLabel = 'Settings';
                } else {
                  fontsize = 0;
                  _width = 0.05;
                  arrowIcon = Icon(Icons.arrow_forward_ios);
                  //editLabel = '';
                  // insertLabel = '';
                  // deleteLabel = '';
                  // settingsLabel = '';
                }
              }),
            ),
            const Spacer(
              flex: 1,
            ),
            TextButton.icon(
              //edit
              onPressed: () => setState(() => {}),
              icon: const Icon(
                Icons.edit_outlined,
                color: Colors.white,
                size: 40,
              ),
              label: Text(
                editLabel,
                style: TextStyle(color: Colors.white, fontSize: fontsize),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            TextButton.icon(
              //insert
              onPressed: () => setState(() => {}),
              icon: const Icon(
                Icons.arrow_downward_outlined,
                color: Colors.white,
                size: 40,
              ),
              label: Text(
                insertLabel,
                style: TextStyle(color: Colors.white, fontSize: fontsize),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            TextButton.icon(
              //delete
              onPressed: () => setState(() => {}),
              icon: const Icon(
                Icons.cancel_outlined,
                color: Colors.white,
                size: 40,
              ),
              label: Text(
                deleteLabel,
                style: TextStyle(color: Colors.white, fontSize: fontsize),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
            TextButton.icon(
              //settings
              onPressed: () => setState(() => {}),
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 40,
              ),
              label: Text(
                settingsLabel,
                style: TextStyle(color: Colors.white, fontSize: fontsize),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    ));
  }
}
/*
class left_menu_widget_state extends State<left_menu_widget> {
  late List<CollapsibleItem> _items;
  late int rightMenuState;

  List<CollapsibleItem> get _generateItems {
    return [
      CollapsibleItem(
        text: 'Edit Parcel',
        icon: Icons.edit_outlined,
        onPressed: () => setState(() => rightMenuState = 1),
      ),
      CollapsibleItem(
        text: 'Insert Parcel',
        icon: Icons.arrow_downward_outlined,
        onPressed: () => setState(() => rightMenuState = 2),
      ),
      CollapsibleItem(
        text: "Delete Parcel",
        icon: Icons.cancel_outlined,
        onPressed: () => setState(() => rightMenuState = 3),
      ),
      CollapsibleItem(
        text: "Settings",
        icon: Icons.settings,
        onPressed: () => setState(() => rightMenuState = 4),
      )
    ];
  }

  @override
  void initState() {
    super.initState();
    _items = _generateItems;
    rightMenuState = 0;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CollapsibleSidebar(
        //isCollapsed: MediaQuery.of(context).size.width <= 800,
        items: _items,
        title: "Parcel Pro", //dont need this
        showTitle: false,
        toggleTitleStyle: const TextStyle(fontSize: 15),

        selectedIconBox: Colors.transparent,
        unselectedTextColor: Colors.white,
        unselectedIconColor: Colors.white,
        backgroundColor: const Color.fromARGB(56, 88, 88, 88),
        selectedTextColor: Colors.white,
        selectedIconColor: Colors.white,
        textStyle: const TextStyle(fontSize: 15),
        iconSize: 30,

        minWidth: 70,
        topPadding: 50,
        borderRadius: 0,
        screenPadding: 0,
        sidebarBoxShadow: [
          BoxShadow(
            color: const Color.fromARGB(56, 88, 88, 88).withOpacity(1),
            blurRadius: 0,
            offset: Offset.zero,
          ),
        ],
        body: _body(context),
      ),
    );
  }

  Widget _body(
    BuildContext context,
  ) {
    switch (rightMenuState){
      case 0:
        return const Opacity(opacity: 0.0);
      case 1:
        return right_menu_edit_widget(callback:() => setState(() => rightMenuState = 0),rightMenuState: rightMenuState);
      case 2:
        return right_menu_insert_widget(callback:() => setState(() => rightMenuState = 0),rightMenuState: rightMenuState);
      case 3:
        return right_menu_delete_widget(callback:() => setState(() => rightMenuState = 0),rightMenuState: rightMenuState);
      case 4:
        return right_menu_settings_widget(callback:() => setState(() => rightMenuState = 0),rightMenuState: rightMenuState);
      default:
        return const Opacity(opacity: 0.0);

    
    }
  }
}*/

