import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
//import 'package:parcel_pro/components/map_widget.dart';
import 'package:parcel_pro/components/right_menu_widget.dart';

class left_menu_widget extends StatefulWidget {
  @override
  left_menu_widget_state createState() => left_menu_widget_state();
}

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
        return right_menu_widget(callback:() => setState(() => rightMenuState = 0),rightMenuState: rightMenuState);
      case 2:
        return right_menu_widget(callback:() => setState(() => rightMenuState = 0),rightMenuState: rightMenuState);
      case 3:
        return right_menu_widget(callback:() => setState(() => rightMenuState = 0),rightMenuState: rightMenuState);
      case 4:
        return right_menu_widget(callback:() => setState(() => rightMenuState = 0),rightMenuState: rightMenuState);
      default:
        return const Opacity(opacity: 0.0);

    
    }
  }
}

