import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BillGeneration extends StatefulWidget {
  @override
  _BillGenerationState createState() => _BillGenerationState();
}


class _BillGenerationState extends State<BillGeneration> {

  final Firestore _firestore = Firestore.instance;
  String house;
  int currentReading, phone;
  int current_year = DateTime
      .now()
      .year;
  int current_month = DateTime
      .now()
      .month;

  void _generateBill(String house, int currentReading) async {
    await _firestore.collection('readings')
        .document('$current_year')
        .collection('$current_month')
        .document(house)
        .setData({
      'current': currentReading,
      'day': DateTime
          .now()
          .day,
    });
    print('added!');

    await _firestore.collection('tenants').getDocuments().then((
        QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        //print('f is ${f.data}');
        if (f.data['house'] == house) {
          phone = f.data['phone'];
        }
      });
    });

    phone = 910000000000 + phone;
    print('phone for $house is $phone');
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
