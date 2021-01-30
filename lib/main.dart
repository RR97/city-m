import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretzelhunt/localStorage/writeToReadFromLocalStorage.dart';
import 'package:pretzelhunt/LocationScanner.dart';
import 'package:pretzelhunt/MyMap.dart';
import 'package:pretzelhunt/TourPlan.dart';
import 'tour.dart';
import 'navigationRoutes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          // return SomethingWentWrong();
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('tours').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {

              if (snapshot.hasError) {
                return Text("Something went wrong");
              }

              if (snapshot.hasData) {
                List<Tour> tours = snapshot.data.docs.map(
                        (doc) => new Tour(doc['name'], doc['info'], doc['destinations'], doc['transportTypes'])).toList();

                return MaterialApp(
                  title: 'Pretzel Hunt',
                  theme: ThemeData(
                    primarySwatch: Colors.blue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                  ),
                  initialRoute: '/',
                  routes: {
                    '/': (context) => MyHomePage(title: 'Pretzel Hunt', tours: tours),
                    '/scan': (context) => LocationScanner(),
                    '/plan': (context) => TourPlan(tours),
                    '/myMap': (context) => MyMap()
                  },
                );
              }

              return new Directionality(
                  textDirection: TextDirection.ltr,
                  child: new Text('Loading'));
            },
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(width: 0.0, height: 0.0);
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.tours}) : super(key: key);

  final String title;
  final List<Tour> tours;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

GlobalKey<NavigatorState> _pageNavigatorKey = GlobalKey<NavigatorState>();

class _MyHomePageState extends State<MyHomePage> {
  Future<String> userData;
  Map<String, dynamic> data;
  TextEditingController nameController = TextEditingController();
  int _selectedIndex = 0;

  void saveName(String name) {
    writeContent(jsonEncode({ 'name': name }));
  }

  void uploadProfilePicture() {
  }

  @override
  void initState() {
    super.initState();
    userData = readContent();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: userData,
      builder: (context, result) {
        if (result.hasData) {
          data = jsonDecode(result.data);
          if(data != null && data.isNotEmpty) {
            return Scaffold(
              body: Navigator(
                key: _pageNavigatorKey,
                onGenerateRoute: (RouteSettings settings) {
                  WidgetBuilder builder;
                  switch (settings.name) {
                    case '/':
                      builder = (BuildContext context) => Home(data);
                      break;
                    case '/scan':
                      builder = (BuildContext context) => LocationScanner();
                      break;
                    case '/plan':
                      builder = (BuildContext context) => TourPlan(widget.tours);
                      break;
                  }
                  return MaterialPageRoute(
                      builder: builder,
                      settings: settings
                  );
                },
              ),
              bottomNavigationBar: BottomNavigationBar(
                items: [
                  for (final route in navigationRoutes)
                    BottomNavigationBarItem(
                      label: route.name,
                      icon: route.icon,
                    )
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue,
                onTap: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                  _pageNavigatorKey.currentState.pushNamed(navigationRoutes.elementAt(index).path);
                },
              ),
            );
          } else {
            return Scaffold(
              body: Padding(
                padding: EdgeInsets.fromLTRB(60, 160, 60, 0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Text('What is your name?'),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: nameController,
                      ),
                    ),
                    Container(
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Colors.blue,
                        child: Text('Save'),
                        onPressed: () {
                          saveName(nameController.text);
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}

class Home extends StatelessWidget {
  final Map<String,dynamic> data;

  Home(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pretzel Hunt'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  Image.asset(
                    'assets/images/LoeweMax.png',
                    width: 175,
                    height: 175,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          data['name'],
                          style: TextStyle(
                            fontSize: 29,
                            fontFamily: 'Calibri',
                          ),
                        ),
                        Text(
                          '\nPoints earned: ' + (data['points'] ?? 0).toString(),
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: 'Calibri',
                          ),
                        ),
                        Text(
                          'Locations visited: ' + (data['locations']?.length ?? 0).toString(),
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: 'Calibri',
                          ),
                        ),
                        Text(
                          'Routes traveled: ' + (data['routes']?.length ?? 0).toString(),
                          style: TextStyle(
                            fontSize: 19,
                            fontFamily: 'Calibri',
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/scan');
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(5),
                  child: Text('Scan Location'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/plan');
                  },
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(5),
                  child: Text('Start a route'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}