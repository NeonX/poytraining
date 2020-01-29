import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:poytraining/models/user_model.dart';
import 'package:poytraining/screens/my_service.dart';
import 'package:poytraining/screens/register.dart';
import 'package:poytraining/utility/my_style.dart';
import 'package:poytraining/utility/normal_dialog.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Field
  String user, password;

  // Method

  Widget signInButton() {
    return RaisedButton(
      color: MyStyle().txtColor,
      child: Text(
        'Sign In',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      onPressed: () {
        if (user == null ||
            user.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'Have space', 'Please fill Userand Password');
        } else {
          checkAuthen();
        }
      },
    );
  }

  Future<void> checkAuthen() async {
    String url =
        'https://www.androidthai.in.th/pte/getUserWhereUserPoy.php?isAdd=true&user=$user';

    Response response = await Dio().get(url);
    print('Response is $response');
    if (response.toString() == 'null') {
      normalDialog(context, 'User False', 'No User \'$user\' in database');
    } else {
      var result = json.decode(response.data);

      print('Result is $result');

      for (var map in result) {
        UserModel userModel = UserModel.fromMap(map);

        if (userModel.password == password) {
          print('Welcome ${userModel.name}');

          //MaterialPageRoute materialPageRoute = MaterialPageRoute(builder: (BuildContext context) { return MyService(); });

          MaterialPageRoute materialPageRoute =
              MaterialPageRoute(builder: (BuildContext context) => MyService());
          Navigator.of(context).pushAndRemoveUntil(materialPageRoute,
              (Route<dynamic> route) {
            return false;
          });
        } else {
          normalDialog(context, 'Password False', 'Please try again');
        }
      }
    }
  }

  Widget signUpButton() {
    return OutlineButton(
      borderSide: BorderSide(color: MyStyle().txtColor),
      child: Text(
        'Sign Up',
        style: TextStyle(color: MyStyle().txtColor),
      ),
      onPressed: () {
        print('You Click Sign Up');
        MaterialPageRoute materialPageRoute =
            MaterialPageRoute(builder: (BuildContext buildContext) {
          return Register();
        });
        Navigator.of(context).push(materialPageRoute);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        signInButton(),
        SizedBox(width: 5.0),
        signUpButton(),
      ],
    );
  }

  Widget userPassword() {
    return Container(
      child: TextField(
        onChanged: (String string) {
          password = string.trim();
        },
        obscureText: true,
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade600)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyStyle().txtColor)),
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().txtColor,
            ),
            hintText: 'Password :',
            hintStyle: TextStyle(
              color: MyStyle().txtColor,
            )),
      ),
      width: 250.0,
    );
  }

  Widget userForm() {
    return Container(
      child: TextField(
        onChanged: (String string) {
          user = string.trim();
        },
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.yellow.shade600)),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: MyStyle().txtColor)),
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().txtColor,
            ),
            hintText: 'User :',
            hintStyle: TextStyle(
              color: MyStyle().txtColor,
            )),
      ),
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
      'Flutter Workshop',
      style: MyStyle().h1Main,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
                colors: <Color>[Colors.white, MyStyle().mainColor],
                radius: 1.0)),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                showLogo(),
                showAppName(),
                userForm(),
                userPassword(),
                SizedBox(height: 20.0),
                showButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
