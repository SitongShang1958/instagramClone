// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FollowButton extends StatelessWidget {
  final Function()? function;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  final Color textColor;
  const FollowButton({super.key, this.function, required this.backgroundColor, required this.borderColor, required this.text, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 2),
      child: TextButton(
        onPressed: () {}, 
        child: Container(
          decoration:  BoxDecoration(
            color: backgroundColor,
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(5)
          ),
          alignment: Alignment.center,
          child: Text(text, style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
          width: 250,
          
        )
      ),
    );  
  }
}