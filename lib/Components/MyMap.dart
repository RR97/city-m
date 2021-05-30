import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class MyMap extends StatefulWidget{
  MyMap({Key key}) : super(key: key);

  @override
  _MyMap createState() => _MyMap();

}

class _MyMap extends State<MyMap>{
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My visited Locations')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: FlutterMap(
              options: new MapOptions(
                center: new LatLng(48.137154, 11.576124),
                zoom: 13.0,
              ),
              layers: [
                new TileLayerOptions(
                    urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']
                ),
                new MarkerLayerOptions(
                  markers: [
                    new Marker(
                      width: 80.0,
                      height: 80.0,
                      point: new LatLng(48.137154, 11.576124),
                      builder: (ctx) =>
                      new Container(
                        child: new Image.asset('assets/images/breze.png', width: 16, height: 16,),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              ButtonBar(
                children: <Widget>[],
              )
            ],
          ),
        ],
      ),
    );
  }
}