import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:poytraining/utility/my_constant.dart';
import 'package:poytraining/utility/normal_dialog.dart';

class AddBuilding extends StatefulWidget {
  @override
  _AddBuildingState createState() => _AddBuildingState();
}

class _AddBuildingState extends State<AddBuilding> {
  // Field
  double lat, lon;
  LatLng latLng;
  File file;
  String name, detail, urlImage;
  String nameFile;

  // Method
  @override
  void initState() {
    super.initState();
    findLatLon();
  }

  Future<void> findLatLon() async {
    LocationData locationData = await findLocationData();

    setState(() {
      lat = locationData.latitude;
      lon = locationData.longitude;
    });

    // Duration duration = Duration(seconds: 5);
    // await Timer(duration, () {
    //   setState(() {
    //     lat = 13.759208;
    //     lon = 100.568766;
    //   });
    // });
  }

  Future<LocationData> findLocationData() async {
    var location = Location();

    try {
      return await location.getLocation();
    } catch (e) {}
  }

  Set<Marker> myMarker() {
    return <Marker>[
      Marker(position: latLng, markerId: MarkerId('myPosition')),
    ].toSet();
  }

  Widget mapPanel() {
    latLng = LatLng(lat, lon);
    CameraPosition cameraPosition = CameraPosition(
      target: latLng,
      zoom: 16,
    );
    return GoogleMap(
      markers: myMarker(),
      mapType: MapType.normal,
      initialCameraPosition: cameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {},
    );
  }

  Widget showMap() {
    return Container(
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
      height: MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      child:
          lat == null ? Center(child: CircularProgressIndicator()) : mapPanel(),
    );
  }

  Widget detailForm() {
    return Container(
      width: 250.0,
      child: TextField(
        decoration: InputDecoration(hintText: 'Detail :'),
        onChanged: (String string) {
          detail = string.trim();
        },
      ),
    );
  }

  Widget nameForm() {
    return Container(
      width: 250.0,
      child: TextField(
        decoration: InputDecoration(hintText: 'Name :'),
        onChanged: (String string) {
          name = string.trim();
        },
      ),
    );
  }

  Widget showImage() {
    return GestureDetector(
      onTap: () {
        print('Click Image');
        cameraAction();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.3,
        child: (file == null)
            ? Image.asset('images/camera.png')
            : Image.file(file),
      ),
    );
  }

  Future<void> cameraAction() async {
    try {
      var object = await ImagePicker.pickImage(
          source: ImageSource.camera, maxWidth: 800.0, maxHeight: 800.0);
      setState(() {
        file = object;
      });
    } catch (e) {}
  }

  Widget myContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          showImage(),
          nameForm(),
          detailForm(),
          showMap(),
        ],
      ),
    );
  }

  Widget addBuildingButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          child: RaisedButton(
            child: Text('Add Building'),
            onPressed: () {
              if (file == null) {
                normalDialog(context, 'No Image', 'Please Click Image');
              } else if (name == null ||
                  name.isEmpty ||
                  detail == null ||
                  detail.isEmpty) {
                normalDialog(
                    context, 'Have space', 'Please fill Name and Detail');
              } else {
                uploadImageToServer();
              }
            },
          ),
        ),
      ],
    );
  }

  Future<void> uploadImageToServer() async {
    Random random = Random();
    int i = random.nextInt(10000);
    nameFile = 'ipoy$i.jpg';

    try {
      Map<String, dynamic> map = Map();
      map['file'] = UploadFileInfo(file, nameFile);

      FormData formData = FormData.from(map);

      await Dio()
          .post(MyConstant().urlAPIsaveFile, data: formData)
          .then((response) {
              print('Response = $response');
              insertDataToServer();
          });
    } catch (e) {}
  }

  Future<void> insertDataToServer()async{

    urlImage = 'https://www.androidthai.in.th/pte/avatarPoyd/$nameFile';
    String url = 'https://www.androidthai.in.th/pte/addBuilding.php?isAdd=true&Name=$name&Detail=$detail&UrlImage=$urlImage&Lat=$lat&Lng=$lon';

    Response response = await Dio().get(url);

    if(response.toString() == 'true'){
      Navigator.of(context).pop();
    }else{
      normalDialog(context, 'Upload False', 'Please try again');
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Building'),
      ),
      body: Stack(
        children: <Widget>[
          addBuildingButton(),
          myContent(),
        ],
      ),
    );
  }
}
