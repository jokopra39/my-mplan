import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mplan/mixin/chat.dart';
import 'package:mplan/mixin/firstload.dart';

class Coba {
  test(String value) {
    Fluttertoast.showToast(
        msg: "This is Center Short Toast = $value",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 13.0);
    //afterload(this);
    
  }
  // testChat(String value) {
  //   Fluttertoast.showToast(
  //       msg: "This is Center Short Toast = $value",
  //       toastLength: Toast.LENGTH_SHORT,
  //       gravity: ToastGravity.BOTTOM,
  //       timeInSecForIosWeb: 1,
  //       backgroundColor: Colors.grey,
  //       textColor: Colors.white,
  //       fontSize: 13.0);
  //   //afterload(this);
  //   afterLoadChart(this);
  // }
}
