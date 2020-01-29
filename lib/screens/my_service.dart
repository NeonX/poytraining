import 'package:flutter/material.dart';
import 'package:poytraining/utility/my_style.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
        backgroundColor: MyStyle().barColor,
      ),
    );
  }
}
