import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BillGeneration extends StatefulWidget {
  @override
  _BillGenerationState createState() => _BillGenerationState();
}

class _BillGenerationState extends State<BillGeneration> {

  final Firestore _firestore = Firestore.instance;
  String house;
  int currentReading;

  void _generateBill(String house, int currentReading) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Bill Generation'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: TextField(
                onChanged: (value) {
                  house = value;
                },
                decoration: InputDecoration(
                  labelText: 'House number',
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: TextField(
                onChanged: (value) {
                  currentReading = int.parse(value);
                },
                decoration: InputDecoration(
                  labelText: 'Current Reading',
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            RaisedButton(
              onPressed: () {
                _generateBill(house, currentReading);
              },
              child: Text('Generate bill'),
            ),

          ],
        ),
      ),
    );
  }
}
