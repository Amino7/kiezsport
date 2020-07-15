import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiezsport/firestoreTutorial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kiezsport/mappage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overlay_container/overlay_container.dart';

class AddMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Kiezsport Map',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MarkerPage(),
    );
  }
}


class MarkerPage extends StatefulWidget {
  @override
  _MarkerPageState createState() => new _MarkerPageState();
}

class _MarkerPageState extends State<MarkerPage> {

  //Standort aufrufen
    Position position;
    double latitude;
    double longitude;

    void getCurrentLocation() async {
      Position res = await Geolocator().getCurrentPosition();
      setState(() {
        position = res;
        print(position);
        print('*******');
        latitude = res.latitude;
        longitude = res.longitude;
        LatController.text = res.latitude.toString();
        LongController.text = res.longitude.toString();
  //    _child = mapWidget();
      });
    }

    void addNewCourt() async {
      setState(() {
        String Review = ReviewController.text;
        Firestore.instance.collection('courts').document()
            .setData({
          'position': GeoPoint(latitude, longitude),
          'sportType': sportType,
          'review': Review
        }).then((_) {
          backToMap();
        });
      });
    }

    void backToMap() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SecondRoute()),
      );
    }

  String sportType = 'Basketball';
  final ReviewController = TextEditingController();
  final LatController = TextEditingController();
  final LongController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kiezsport Map'),
          backgroundColor: const Color(0xFF2196f3),
        ),
        body: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Form(
            child: ListView(
              children: <Widget>[
                new DropdownButton<String>(
                  value: sportType,
                  onChanged: (String newValue) {
                    setState(() {
                      sportType = newValue;
                    });
                  },
                  items: <String>['Basketball', 'Table Tennis', 'Volleyball', 'Soccer'].map<DropdownMenuItem<String>> ((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                ),
                SizedBox(height: 16.0,),
                RaisedButton(
                  child: Text('Get Current Location'),
                  onPressed: getCurrentLocation,
                ),
                SizedBox(height: 16.0,),
                TextFormField(
                  readOnly: true,
                  enabled: false,
                  controller: LatController,
                  decoration: InputDecoration(
                      labelText: 'Latitude',
                      //labelText: position.latitude,
                      contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
                  child: TextFormField(
                    readOnly: true,
                    enabled: false,
                    controller: LongController,
                    decoration: InputDecoration(
                      labelText: 'Longitude',
                      //labelText: position.latitude,
                      contentPadding: new EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                    ),
                  ),
                ),
                TextFormField(
                  controller: ReviewController,
                  decoration: InputDecoration(
                    labelText: 'Review',
                    contentPadding: new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
                  ),
                ),
                SizedBox(height: 16.0,),
                RaisedButton(
                  child: Text('Submit'),
                  color: Colors.green[300],
                  onPressed:
                    addNewCourt, //
                ),
                RaisedButton(
                  child: Text('Cancel'),
                  color: Colors.deepOrange[200],
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SecondRoute()),
                    );// back
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void buttonPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirestoreTut()),
    );
  }
  void searchBasketball() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirestoreTut()),
    );
  }


}

