import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';
import 'package:parcel_pro/components/map_widget.dart';

class right_menu_delete_widget extends StatelessWidget {
final int rightMenuState;
final VoidCallback callback;
const right_menu_delete_widget({
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
          width: MediaQuery.of(context).size.width * 0.15 ,
          color: Color.fromARGB(255, 88, 88, 88),
          child: Column(
             children: [
              Container(
                alignment: Alignment.topLeft,
                child: 
                  CloseButton(
                    color: Color.fromARGB(255, 236, 236, 236),
                    onPressed:() =>callback(),
                    )
              ),

              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                  children: [
                    WidgetSpan(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: Icon(Icons.cancel_outlined, color: Colors.white,),
                      ),
                    ),
                    TextSpan(text: 'Delete Parcel'),
                  ],
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 120.0) ,
                child: Text('Select Parcel', style: TextStyle(color: Colors.white, fontSize: 18.0),)
              ),

              ],
          ),
      ),
      ) 
    );
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