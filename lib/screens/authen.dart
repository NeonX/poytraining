import 'package:flutter/material.dart';
import 'package:poytraining/screens/register.dart';
import 'package:poytraining/utility/my_style.dart';

class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Field

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
      onPressed: () {},
    );
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
