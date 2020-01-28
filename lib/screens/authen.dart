import 'package:flutter/material.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Field

  // Method
  

  Widget userForm() {
    return Container(
      child: TextField(),
      width: 250.0,
    );
  }

  Widget showLogo() {
    return Container(
      child: Image.asset('images/logo.png'),
      width: 125.0,
    );
  }

  Widget showAppName() {
    return Text(
      'poytraining',
      style: TextStyle(
          fontSize: 20,
          color: Colors.red.shade900,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            showLogo(),
            showAppName(),
            userForm(),
            userForm(),
          ],
        ),
      ),
    );
  }
}
