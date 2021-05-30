import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pretzelhunt/localStorage/writeToReadFromLocalStorage.dart';
import 'location.dart';

class ScanLocationQR extends StatefulWidget {
  @override
  _ScanLocationQR createState() => _ScanLocationQR();
}

class _ScanLocationQR extends State<ScanLocationQR> {
  QueryDocumentSnapshot<Location> _foundLocation;

  @override
  void initState() {
    super.initState();
  }

  Future<void> addLocation() async {
    var userData = await readContent();
    var data = jsonDecode(userData);
    if (data['locations'] != null) {
      writeContent(jsonEncode({ 'locations': data.locations.add(_foundLocation.id) }));
    } else {
      writeContent(jsonEncode({ 'locations': [_foundLocation.id] }));
    }
    setState(() {
      _foundLocation = null;
    });
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    List<QueryDocumentSnapshot<Location>> location;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    final destinationsRef = FirebaseFirestore.instance
        .collection('destinations')
        .withConverter<Location>(
          fromFirestore: (snapshot, _) => Location.fromJson(snapshot.data()),
          toFirestore: (location, _) => location.toJson(),
        );

    location = await destinationsRef
        .where('QRcodeString', isEqualTo: barcodeScanRes)
        .get()
        .then((snapshot) => snapshot.docs);

    setState(() {
      _foundLocation = location[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Builder(builder: (BuildContext context) {
      return Container(
          alignment: Alignment.center,
          child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Visibility(
                  visible: (_foundLocation != null),
                  child: Column(
                    children: <Widget>[
                      Text('Found Location : ${_foundLocation?.get('name')}\n',
                          style: TextStyle(fontSize: 20)),
                      Flex(
                        direction: Axis.horizontal,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: () => addLocation(),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(19.0))),
                            ),
                            child: Text('Add Location'),
                          ),
                          ElevatedButton(
                            onPressed: () => {},
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(19.0)
                                ),
                              ),
                            ),
                            child: Text(
                              "Start route",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () => scanQR(),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(19.0)
                                ),
                              ),
                            ),
                            child: Text(
                              "Scan other location",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Visibility(
                    visible: (_foundLocation == null),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(25, 25, 25, 10),
                          child: Text(
                            'Scan a QR code for a location in Munich and learn more about the place and its surroundings.'
                            ' For logged in users the location will be added to their Visited Map.',
                            style:
                                TextStyle(fontSize: 21, fontFamily: 'Calibri'),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () => scanQR(),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(19.0))),
                          ),
                          child: Text(
                            "Scan Location QR",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )),
              ]));
    }));
  }
}
