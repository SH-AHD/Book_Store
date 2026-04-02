import 'package:flutter/material.dart';

void PushReplacementPage(BuildContext context , Widget newScreen){
  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>newScreen) );
}