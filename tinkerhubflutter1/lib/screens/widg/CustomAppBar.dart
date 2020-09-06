import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [CustomIcon(cstmicon: Icons.menu,), CustomIcon(cstmicon: Icons.search)]);
  }
}

class CustomIcon extends StatelessWidget {
  IconData cstmicon;
  CustomIcon({@required this.cstmicon});

  @override
  Widget build(BuildContext context) {
    return Row(
      children:[
        Container( padding: EdgeInsets.all(5),decoration: BoxDecoration(border: Border.all(color: Colors.black12)),child: Icon(cstmicon),)
      ]
    );
  }
} 