import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretzlhunt/navDrawer.dart';
import 'package:pretzlhunt/scanLocationQR.dart';

class MyScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Scanner"),
      ),
      drawer: NavDrawer(),
      body: Center(
        child: ScanLocationQR(),
      ),
    );
  }
}