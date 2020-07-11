import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'mappage.dart';
import 'firestoreTutorial.dart';

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

//Laden des Facebook und Google Buttons/Images für die LOGIN Page
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
