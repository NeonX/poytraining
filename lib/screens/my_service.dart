import 'package:flutter/material.dart';
import 'package:poytraining/utility/my_style.dart';
import 'package:poytraining/widget/list_building.dart';

class MyService extends StatefulWidget {
  @override
  _MyServiceState createState() => _MyServiceState();
}

class _MyServiceState extends State<MyService> {
  // Field
  Widget currentWidget = ListBuilding();
  // Method
  Widget showDrawer() {
    return Drawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Service'),
        backgroundColor: MyStyle().barColor,
      ),
      drawer: showDrawer(),
      body: currentWidget,
    );
  }
}
