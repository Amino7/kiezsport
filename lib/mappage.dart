import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiezsport/firestoreTutorial.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:overlay_container/overlay_container.dart';

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

class Court {
  String id;

}

class _MyMapPageState extends State<MapPage> {

  bool _dropdownShown = false;

  void _toggleDropdown() {
    setState(() {
      _dropdownShown = !_dropdownShown;
    });
  }

  // AB HIER WERDEN DIE BUTTONS ERSTELLT
  Widget _buildSettingsButton(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: settingsPressed,
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

  Widget _buildPlusButton(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: _toggleDropdown,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          border: Border.all(
              width: 5,
              color: Colors.white
          ),
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

  Widget _buildSettingsAndPlusButton() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: Container(
            child: _buildSettingsButton(
                  () => print('The Settings'),
              AssetImage(
                'assets/images/settings.png',
              ),
            ),
          ),
        ),
        Container(
          child: _buildPlusButton(
                () => print('Add a sports field'),
            AssetImage(
              'assets/images/plus.png',
            ),
          ),
        ),
      ],
    );
  }

  //Laden der Filterbuttons zum Filtern der Sportarten
  Widget _buildSocialBtn1(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: searchBasketball,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          border: Border.all(
            width: 3,
            color: Colors.white
          ),
          shape: BoxShape.circle,
          color: Colors.amber[300],
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtn2(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: searchTennis,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          border: Border.all(
              width: 3,
              color: Colors.white
          ),
          shape: BoxShape.circle,
          color: Colors.cyan[700],
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

  Widget _buildSocialBtn3(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: searchVolleyball,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          border: Border.all(
              width: 3,
              color: Colors.white
          ),
          shape: BoxShape.circle,
          color: Colors.deepOrange[200],
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

  Widget _buildSocialBtn4(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: searchSoccer,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          border: Border.all(
              width: 3,
              color: Colors.white
          ),
          shape: BoxShape.circle,
          color: Colors.green[300],
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
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn1(
            () => print('Search for basketball fields'),
            AssetImage(
              'assets/images/basketball.png',
            ),
          ),
          _buildSocialBtn2(
            () => print('Search for table tennis'),
            AssetImage(
              'assets/images/tennis.png',
            ),
          ),
          _buildSocialBtn3(
            () => print('Search for volleyball fields'),
            AssetImage(
              'assets/images/volleyball.png',
            ),
          ),
          _buildSocialBtn4(
            () => print('Search for soccer fields'),
            AssetImage(
              'assets/images/football.png',
            ),
          ),
        ],
      ),
    );
  }


  //AB HIER WERDEN GOOGLE MAPS UND DIE MARKER EINGEBUNDEN
  GoogleMapController mapController;
  BitmapDescriptor _markerIcon;

  final LatLng _center = const LatLng(52.520008, 13.404954);

  Position position;
  bool mapToggle = false;
  bool markerToggle = false;
  var markersammlung = [];
  var currentMarker;

  final Map<String, Marker> _markers = {};

  // EINBINDUNG DES AKTUELLEN STANDORTS
  @override
  void initState() {
    //_child=RippleIndicator("Getting Location");
    //getCurrentLocation();
    super.initState();
    setState(() {
      mapToggle = true;
      populateClients();
    });
    _setMarkerIcon();
  }


  void _setMarkerIcon() async {
    _markerIcon = await BitmapDescriptor.fromAssetImage(ImageConfiguration(), 'assets/images/pinBasketball.png');
//    switch(type) {
//      case 'basketball':
//        {
//          _markerIcon = await BitmapDescriptor.fromAssetImage(
//              ImageConfiguration(), 'assets/images/pinBasketball.png');
//        }
//      break;
//      case 'tischtennis':
//        {
//          _markerIcon = await BitmapDescriptor.fromAssetImage(
//              ImageConfiguration(), 'assets/images/pinBasketball.png');
//        }
//      break;
//
//      case 'volleyball':
//        {
//          _markerIcon = await BitmapDescriptor.fromAssetImage(
//              ImageConfiguration(), 'assets/images/pinBasketball.png');
//        }
//      break;
//
//      case 'soccer':
//        {
//          _markerIcon = await BitmapDescriptor.fromAssetImage(
//              ImageConfiguration(), 'assets/images/pinBasketball.png');
//        }
//      break;
//    }
  }

  populateClients() {
    Firestore.instance.collection('courts').getDocuments().then((docs) {
      if (docs.documents.isNotEmpty) {
        setState(() {
          markerToggle = true;
        });
        for (int i = 0; i < docs.documents.length; ++i) {
          var data = [docs.documents[i].documentID, docs.documents[i].data];
          markersammlung.add(data);

          print('======================================================');
          print(data);
          //initMarker(docs.documents[i].data);
        }
        print('###################################################');
        print(markersammlung);
      }
    });
  }



//FÜR DISPRIBUTION AUF ANDROID ZUR ERMITTLUNG DES STANDORTS
//  void getCurrentLocation() async {
//    Position res = await Geolocator().getCurrentPosition();
//    setState(() {
//      position = res;
////    _child = mapWidget();
//    });
//  }

//  void _onMapCreated(GoogleMapController controller) {
//    mapController = controller;
//  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    mapController = controller;

    setState(() {
      _markers.clear();
      for (final court in markersammlung) {
        final marker = Marker(
          markerId: MarkerId(court[0]),
          position: LatLng(court[1]['position'].latitude, court[1]['position'].longitude),
          infoWindow: InfoWindow(
            title: court[1]['sportType'],
            //snippet: court.address,
          ),
          icon: _markerIcon
        );
        _markers[court[1]['sportType']] = marker;
      }
      print('*******************');
      print(_markers);
    });
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
                //target: LatLng(position.latitude, position.longitude),
                target: _center,
                zoom: 12.0,
              ),
              markers: _markers.values.toSet(),
            ),
            Align(
              alignment: Alignment.topRight,
              child: _buildSettingsAndPlusButton(),
            ),
            OverlayContainer(
              show: _dropdownShown,
              // Let's position this overlay to the right of the button.
              position: OverlayContainerPosition(
                // Left position.
                20,
                // Bottom position.
                -200,
              ),
              // The content inside the overlay.
              child: Container(
                height: 250,
                width: 370,
                padding: const EdgeInsets.all(20),
                margin: const EdgeInsets.only(top: 5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: const Color(0xFF2196f3),
                      blurRadius: 4,
                      spreadRadius: 2,
                    )
                  ],
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(30.0),
                      topRight: const Radius.circular(30.0),
                      bottomLeft: const Radius.circular(30.0),
                      bottomRight: const Radius.circular(30.0),
                    )
                ),
                child: Text("I render outside the \nwidget hierarchy."),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: _buildSocialBtnRow(),
            ),
          ],
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
  void searchTennis() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirestoreTut()),
    );
  }
  void searchVolleyball() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirestoreTut()),
    );
  }
  void searchSoccer() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirestoreTut()),
    );
  }
  void settingsPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirestoreTut()),
    );
  }
  void addField() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => FirestoreTut()),
    );
  }

//  List<Placemark> placemark;
//  String _adress;
//  void getAdress(double latitude, double longtitude) async {
//    placemark =
//    await Geolocator().placemarkFromCoordinates(latitude, longtitude);
//    _adress = placemark[0].name.toString() +
//        ", Postal Code:" +
//        placemark[0].postalCode.toString();
//    setState(() {
//      _child = mapWidget();
//    });
//  }
}

