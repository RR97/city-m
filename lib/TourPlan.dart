import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pretzlhunt/navDrawer.dart';
import 'tours.dart';


class TourPlan extends StatefulWidget {
  @override
  _TourPlanState createState() => _TourPlanState();
}

class _TourPlanState extends State<TourPlan> {
  List<Tour> tours = Tours.getToursList();
  Tour chosenTour;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plan a tour')
      ),
      drawer: NavDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DropdownButton<Tour>(
            value: chosenTour,
            onChanged: (Tour newVal) {
              setState(() {
                chosenTour = newVal;
              });
            },
            items: tours.map<DropdownMenuItem<Tour>>((Tour value) {
              return DropdownMenuItem<Tour>(
                value: value,
                child: Text(value.name),
              );
            }).toList(),
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
    );
    throw UnimplementedError();
  }

  void _chooseTransport(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlanTransport(),
      ));
  }
}

class PlanTransport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Choose Transport')),
      body: Center(
        child: Text('Empty!'),
      )
    );
  }


}

