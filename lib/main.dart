import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretzlhunt/localStorage/writeToReadFromLocalStorage.dart';
import 'package:pretzlhunt/MyScanner.dart';
import 'package:pretzlhunt/navDrawer.dart';
import 'package:pretzlhunt/MyMap.dart';
import 'package:pretzlhunt/TourPlan.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pretzel Hunt',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: 'Pretzel Hunt'),
        '/scan': (context) => MyScanner(),
        '/plan': (context) => TourPlan(),
        '/myMap': (context) => MyMap()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController nameController = TextEditingController();
  Map<String,dynamic> data;

  void saveName(String name) {
    setState(() {
      data['name'] = name;
    });
    writeContent(jsonEncode(data));
  }

  void uploadProfilePicture() {
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    readContent().then((String value) {
      setState(() {
        data = jsonDecode(value);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    if(data != null && data.isNotEmpty) {
      return Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text(widget.title),
        ),
        drawer: NavDrawer(name: data['name']),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Invoke "debug painting" (press "p" in the console, choose the
            // "Toggle Debug Paint" action from the Flutter Inspector in Android
            // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
            // to see the wireframe for each widget.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
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
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    padding: EdgeInsets.all(5),
                    child: Text('Scan Location'),
                  ),
                  RaisedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/plan');
                      },
                    color: Colors.deepPurple,
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
                  color: Colors.deepPurple,
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
  }
}
