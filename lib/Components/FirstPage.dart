import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretzelhunt/localStorage/writeToReadFromLocalStorage.dart';
import '../navigationRoutes.dart';
import 'package:pretzelhunt/tour.dart';
import 'Home.dart';
import 'TourPlan.dart';
import 'LocationScanner.dart';


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
                        child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          child: Text('Save', style: TextStyle(color: Colors.white)),
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