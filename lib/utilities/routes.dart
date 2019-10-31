

import 'package:flutter/material.dart';
class Routes{
  void pushPage(BuildContext context, Page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Page));
  }void goBack(BuildContext context) {
    Navigator.pop(context);
  }
}

final routes = Routes();


