import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Map<String,dynamic> data;

  Home(this.data);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pretzel Hunt'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
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
                  color: Colors.blue,
                  textColor: Colors.white,
                  padding: EdgeInsets.all(5),
                  child: Text('Scan Location'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/plan');
                  },
                  color: Colors.blue,
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
  }
}