import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:poytraining/utility/my_style.dart';
import 'package:poytraining/utility/normal_dialog.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  // Field
  File file;
  String name, user, password;

  //Method
  Widget passwordForm() {
    Color color = Colors.green.shade700;

    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (String string) {
          password = string.trim();
        },
        style: TextStyle(color: color),
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color)),
          helperStyle: TextStyle(color: color),
          helperText: 'Type your password in blank',
          labelText: 'Password :',
          labelStyle: TextStyle(color: color),
          icon: Icon(
            Icons.lock,
            size: 36.0,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget userForm() {
    Color color = Colors.blue.shade700;

    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (String string) {
          user = string.trim();
        },
        style: TextStyle(color: color),
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color)),
          helperStyle: TextStyle(color: color),
          helperText: 'Type your user in blank',
          labelText: 'User :',
          labelStyle: TextStyle(color: color),
          icon: Icon(
            Icons.account_box,
            size: 36.0,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget nameForm() {
    Color color = Colors.yellow.shade700;

    return Container(
      margin: EdgeInsets.only(left: 30.0, right: 30.0),
      child: TextField(
        onChanged: (String string) {
          name = string.trim();
        },
        style: TextStyle(color: color),
        decoration: InputDecoration(
          enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: color)),
          helperStyle: TextStyle(color: color),
          helperText: 'Type your name in blank',
          labelText: 'Display Name :',
          labelStyle: TextStyle(color: color),
          icon: Icon(
            Icons.face,
            size: 36.0,
            color: color,
          ),
        ),
      ),
    );
  }

  Widget galleryButton() {
    return IconButton(
      icon: Icon(Icons.add_a_photo),
      onPressed: () {
        getPhoto(ImageSource.gallery);
      },
    );
  }

  Future<void> getPhoto(ImageSource imageSource) async {
    try {
      var object = await ImagePicker.pickImage(
        source: imageSource,
        maxWidth: 800.0,
        maxHeight: 800.0,
      );

      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget cameraButton() {
    return IconButton(
      icon: Icon(Icons.add_a_photo),
      onPressed: () {
        getPhoto(ImageSource.camera);
      },
    );
  }

  Widget showButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[cameraButton(), galleryButton()],
    );
  }

  Widget showAvatar() {
    return Container(
      padding: EdgeInsets.all(20.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.5,
      child: file == null ? Image.asset('images/avatar.png') : Image.file(file),
    );
  }

  Widget registerButton() {
    return IconButton(
      icon: Icon(Icons.cloud_upload),
      onPressed: () {
        if (file == null) {
          normalDialog(context, 'No Avatar', 'Please Click Camera or Gallery');
        } else if (name == null ||
            name.isEmpty ||
            user == null ||
            user.isEmpty ||
            password == null ||
            password.isEmpty) {
          normalDialog(context, 'No Info', 'Please fill your information');
        } else {
          processUploadAvatar();
        }
      },
    );
  }

  Future<void> processUploadAvatar()async{

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
        actions: <Widget>[registerButton()],
        backgroundColor: MyStyle().barColor,
      ),
      body: ListView(
        children: <Widget>[
          showAvatar(),
          showButton(),
          nameForm(),
          userForm(),
          passwordForm(),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
