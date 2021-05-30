import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretzelhunt/ScanLocationQR.dart';

class LocationScanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location Scanner"),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: ScanLocationQR(),
      ),
    );
  }
}