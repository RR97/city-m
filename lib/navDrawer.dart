import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.deepPurple,
            ),
            accountName: new Text('Max Pretzelman'),
            currentAccountPicture: new Image.asset(
              'assets/images/LoeweMax.png',
              width: 128,
              height: 128,
            ), accountEmail: Text('musterEmail@test.de'),
          ),
          ListTile(
            leading: Icon(Icons.loupe),
            title: Text('Scan a location'),
            onTap: () {
              Navigator.pushNamed(context, '/scan');
            },
          ),
          ListTile(
            leading: Icon(Icons.directions_bike),
            title: Text('Plan a tour'),
            onTap: () {
              Navigator.pushNamed(context, '/plan');
            },
          ),
          ListTile(
            leading: Icon(Icons.map),
            title: Text('My Locations (soon available)'),
            enabled: false,
            onTap: () {
              Navigator.pushNamed(context, '/myMap');
            },
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings (available on existing account)'),
            enabled: false,
            onTap: () {
              Navigator.pushNamed(context, '/');
            },
          ),
        ],
      ),
    );
  }
}