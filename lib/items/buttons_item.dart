import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonItem extends StatelessWidget {

  final IconData icon;
  final Color color;
  final Function play;

  ButtonItem({
    @required this.icon,
    @required this.color,
    @required this.play
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        IconButton(icon: Icon(icon),
         iconSize: 50,
         color: color,
         onPressed: play,)
      ],
      
    );
  }
}