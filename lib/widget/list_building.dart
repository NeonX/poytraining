import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:poytraining/models/build_model.dart';
import 'package:poytraining/screens/add_building.dart';
import 'package:poytraining/utility/my_constant.dart';

class ListBuilding extends StatefulWidget {
  @override
  _ListBuildingState createState() => _ListBuildingState();
}

class _ListBuildingState extends State<ListBuilding> {
  // Field
  List<BuildModel> listBuildModel = List();

  // Method

  @override
  void initState() {
    super.initState();
    readData();
  }

  Future<void> readData() async {
    if (listBuildModel.length > 0) {
      
      listBuildModel.clear();
      // listBuildModel.removeWhere((BuildModel buildModel) {
      //   return buildModel.id != null;
      // });
    }

    Response response = await Dio().get(MyConstant().urlAPIreadAll);

    var result = json.decode(response.data);

    print('Result = $result');

    for (var map in result) {
      BuildModel buildModel = BuildModel.fromJson(map);
      setState(() {
        listBuildModel.add(buildModel);
      });
    }
  }

  Widget addBuildingButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 15.0, bottom: 15.0),
              child: FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  MaterialPageRoute materialPageRoute =
                      MaterialPageRoute(builder: (BuildContext buildContext) {
                    return AddBuilding();
                  });
                  Navigator.of(context)
                      .push(materialPageRoute)
                      .then((response) {
                    readData();
                  });
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget showListView() {
    return ListView.builder(
      itemBuilder: (BuildContext buildContext, int index) {
        return Row(
          children: <Widget>[
            showImage(index),
            showText(index),
          ],
        );
      },
      itemCount: listBuildModel.length,
    );
  }

  Widget showImage(int index) {
    return Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.width * 0.4,
        child: Image.network(
          listBuildModel[index].urlImage,
          fit: BoxFit.cover,
        ));
  }

  Widget showText(int index) {
    return Column(
      children: <Widget>[
        Text(listBuildModel[index].name),
        Text(listBuildModel[index].detail),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        showListView(),
        addBuildingButton(),
      ],
    );
  }
}
