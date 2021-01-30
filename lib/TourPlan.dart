import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'tour.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class TourPlan extends StatefulWidget {
  final List<Tour> tours;

  TourPlan(this.tours);

  @override
  _TourPlanState createState() => _TourPlanState();
}

class _TourPlanState extends State<TourPlan> {
  Tour chosenTour;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Plan a tour'),
          automaticallyImplyLeading: false,
        ),
        // drawer: NavDrawer(),
        body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DropdownButton<Tour>(
                  value: chosenTour,
                  onChanged: (Tour newVal) {
                    setState(() {
                      chosenTour = newVal;
                    });
                  },
                  items: widget.tours.map<DropdownMenuItem<Tour>>((Tour tour) =>
                      DropdownMenuItem<Tour>(
                        value: tour,
                        child: Text(tour.name),
                      )).toList(),
                ),
                RaisedButton(
                  child: Text(
                    'Next',
                    style: TextStyle(fontSize: 21),
                  ),
                  onPressed: () {
                    _chooseTransport(context);
                  },
                )
              ],
            )
        )
    );
  }

  void _chooseTransport(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PlanTransport(chosenTour),
        ));
  }
}

class PlanTransport extends StatefulWidget {
  final Tour tour;
  PlanTransport(this.tour);

  @override
  _PlanTransportState createState() => _PlanTransportState();

}

class _PlanTransportState extends State<PlanTransport> {
  String chosenTransportType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Choose Transport')),
        body: Column(
          children: <Widget>[
            Expanded(
              child: FlutterMap(
                options: new MapOptions(
                  center: new LatLng(51.5, -0.09),
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
                        point: new LatLng(0,0),
                        builder: (ctx) =>
                        new Container(
                          child: new FlutterLogo(),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListView.separated(
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return new Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Radio(
                        value: widget.tour.transportTypes[index].toString(),
                        groupValue: chosenTransportType,
                        onChanged: _chooseTransport,
                      ),
                      new Text('${widget.tour.transportTypes[index]} - Total time: ')
                    ],
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
                itemCount: widget.tour.transportTypes.length
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  child: Center(
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 21),
                    ),
                  ),
                  onPressed: () {
                    _checkOutRoute(context);
                  },
                )
              ],
            ),
          ],
        )
    );
  }

  void _chooseTransport(String transport) {
    setState(() {
      chosenTransportType = transport;
    });
  }
  void _checkOutRoute(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FinishPlan(chosenTransportType),
        ));
  }
}

class FinishPlan extends StatelessWidget {
  final String transportType;
  FinishPlan(this.transportType);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Starting Tour')),
      body: Placeholder(
        color: Colors.grey,
        fallbackHeight: 300,
        fallbackWidth: 150,
        strokeWidth: 10,
      )
    );
  }

}