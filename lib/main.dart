import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// von Amin erstmal auskommentiert
// void main() => runApp(MyApp());

// final dummySnapshot = [
//   {"name": "Filip", "votes": 15},
//   {"name": "Abraham", "votes": 14},
//   {"name": "Richard", "votes": 11},
//   {"name": "Ike", "votes": 10},
//   {"name": "Justin", "votes": 1},
// ];

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Baby Names',
//       home: MyHomePage(),

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Kiezsport App',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF2196f3),
        accentColor: const Color(0xFF2196f3),
        canvasColor: const Color(0xFFfafafa),
      ),
      home: new MyHomePage(),
    );
  }
}

//Amin
// class MyHomePage extends StatefulWidget {
// <<<<<<< Amin
//   @override
//   _MyHomePageState createState() {
//     return _MyHomePageState();
//   }
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Baby Name Votes')),
//       body: _buildBody(context),
//     );
//   }

//   Widget _buildBody(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: Firestore.instance.collection('baby').snapshots(),
//       builder: (context, snapshot) {
//         if (!snapshot.hasData) return LinearProgressIndicator();

//         return _buildList(context, snapshot.data.documents);
//       },
//     );
//   }

//   Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//     return ListView(
//       padding: const EdgeInsets.only(top: 20.0),
//       children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//     );
//   }

//   Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//     final record = Record.fromSnapshot(data);

//     return Padding(
//       key: ValueKey(record.name),
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Container(
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(5.0),
//         ),
//         child: ListTile(
//           title: Text(record.name),
//           trailing: Text(record.votes.toString()),
//             onTap: () => record.reference.updateData({'votes': FieldValue.increment(1)})        ),
//       ),
//     );
//   }
// }



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black,
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
                () => print('Login with Facebook'),
            AssetImage(
              'assets/images/facebook.png',
            ),
          ),
          _buildSocialBtn(
                () => print('Login with Google'),
            AssetImage(
              'assets/images/Google.png',
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: Colors.black,
//      appBar: new AppBar(
//        title: new Text('KIEZSPORT'),
//        backgroundColor: Colors.black,
//
//      ),
      body:
      new Container(
        child:
        new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom:30.0),
                child: new Text(
                  "KIEZSPORT",
                  style: new TextStyle(fontSize:32.0,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w800,
                      fontFamily: "Roboto"),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left:20.0, right: 20.0),
                child: new TextField(
                  style: new TextStyle(fontSize:21.0,
                    color: const Color(0xFFFFFFFF),
                    fontWeight: FontWeight.w500,
                    fontFamily: "Roboto",),
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3.0),
                    ),
                    prefixIcon: Icon(Icons.account_circle, color: Colors.white),
                    hintText: 'Name',
                    hintStyle: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left:20.0, right: 20.0),
                child: new TextField(
                  obscureText: true,
                  style: new TextStyle(fontSize:21.0,
                      color: const Color(0xFFFFFFFF),
                      fontWeight: FontWeight.w500,
                      fontFamily: "Roboto"),
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlueAccent, width: 3.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3.0),
                    ),
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    hintText: 'Passwort',
                    hintStyle: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.w300),
                  ),
                ),
              ),

              new RaisedButton(key:null, onPressed:buttonPressed,
                  color: const Color(0xFFFFFFFF),
                  child:
                  new Text(
                    "LOGIN",
                    style: new TextStyle(fontSize:24.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        letterSpacing: 1.5,
                        fontFamily: "Roboto"),
                  )
              ),

              Padding(
                padding: const EdgeInsets.only(top:30.0),
                child: _buildSocialBtnRow(),
              ),

            ]

        ),

        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),


    );

  }
  void buttonPressed(){Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SecondRoute()),);
  }

}


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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Kiezsport Map'),
          backgroundColor: const Color(0xFF2196f3),
        ),
        body: GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 12.0,
          ),
        ),
      ),
    );
  }

}
// Amins Record class
// class Record {
//   final String name;
//   final int votes;
//   final DocumentReference reference;

//   Record.fromMap(Map<String, dynamic> map, {this.reference})
//       : assert(map['name'] != null),
//         assert(map['votes'] != null),
//         name = map['name'],
//         votes = map['votes'];

//   Record.fromSnapshot(DocumentSnapshot snapshot)
//       : this.fromMap(snapshot.data, reference: snapshot.reference);

//   @override
//   String toString() => "Record<$name:$votes>";
// }

