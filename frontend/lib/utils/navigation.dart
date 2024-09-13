import 'package:flutter/material.dart';

class Navigation{
  final BuildContext context;

  Navigation({required this.context});


  void pushNamedNavigation(String path){
    Navigator.pushNamed(context, path);
  }

  void materialNavigation(String path, Widget Function() widgetBuilder){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widgetBuilder(),
      ),
    );
  }

  void popNavigation(){
    Navigator.pop(context);
  }
}