import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavRoute {
  Icon icon;
  String name;
  String path;

  NavRoute(this.icon, this.name, this.path);
}

List<NavRoute> navigationRoutes = [
  NavRoute(Icon(Icons.home), 'Home', '/'),
  NavRoute(Icon(Icons.loupe), 'Scan a location', '/scan'),
  NavRoute(Icon(Icons.directions_bike), 'Plan a tour', '/plan')
];