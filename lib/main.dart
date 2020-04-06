import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:water_bill_manager/bill_generation.dart';
import 'package:water_bill_manager/previous_list.dart';
import 'package:water_bill_manager/previous_readings.dart';
import 'package:water_bill_manager/tenant_profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/billGeneration': (context) => BillGeneration(),
        '/tenant': (context) => TenentProfile(),
        '/previousList': (context) => PreviousList(),
        '/previousReadings': (context) => PreviousReadings(),
      },
      home: MyHomePage(title: 'Water Bill Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Firestore _firestore = Firestore.instance;

  Future testFirebase() async {
    print('here');
    return await _firestore.collection('test').document('1').setData({
      'test': 'test1',
      'test2': 'blah',
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text('Generate bill'),
              onPressed: () {
                Navigator.pushNamed(context, '/billGeneration');
              },
            ),
            RaisedButton(
              child: Text('Tenant Details'),
              onPressed: () {
                Navigator.pushNamed(context, '/tenant');
              },
            ),

            RaisedButton(
              child: Text('View previous readings'),
              onPressed: () {
                Navigator.pushNamed(context, '/previousList');
              },
            ),

            RaisedButton(
              child: Text('test for prev readings'),
              onPressed: () {
                Navigator.pushNamed(context, '/previousReadings');
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
