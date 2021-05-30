import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Components/LocationScanner.dart';
import 'Components/MyMap.dart';
import 'Components/TourPlan.dart';
import 'tour.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'Components/FirstPage.dart';

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