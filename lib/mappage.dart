import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiezsport/firestoreTutorial.dart';

class SecondRoute extends StatelessWidget {
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
      home: new MapPage(),
    );
  }
}

class MapPage extends StatefulWidget {
  @override
  _MyMapPageState createState() => new _MyMapPageState();
}

class _MyMapPageState extends State<MapPage> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(52.520008, 13.404954);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  //Laden des Facebook und Google Buttons/Images für die LOGIN Page
  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: buttonPressed,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
                () => print('Search for basketball fields'),
            AssetImage(
              'assets/images/basketball.svg',
            ),
          ),
          _buildSocialBtn(
                () => print('Search for table tennis'),
            AssetImage(
              'assets/images/tennis.svg',
            ),
          ),
          _buildSocialBtn(
                () => print('Search for volleyball fields'),
            AssetImage(
              'assets/images/volleyball.svg',
            ),
          ),
          _buildSocialBtn(
                () => print('Search for soccer fields'),
            AssetImage(
              'assets/images/football.svg',
            ),
          ),
        ],
      ),
    );
  }

  //Laden der Google Map
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kiezsport Map'),
          backgroundColor: const Color(0xFF2196f3),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 12.0,
            ),
          ),
            Padding(
              padding: const EdgeInsets.only(top:30.0),
              child: _buildSocialBtnRow(),
            ),
        ],
       ),
      ),
    );
  }
  void buttonPressed(){Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => FirestoreTut()),);
  }

}