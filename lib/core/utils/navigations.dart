import 'package:flutter/material.dart';

class Navigations {
  // function to push
  void push(BuildContext context, {required String screen, final arguments}) {
    Navigator.of(context).pushNamed(
      screen, arguments: arguments, 
    );
  }

  void pop(BuildContext context) {
    Navigator.of(context).pop();
  }
}
