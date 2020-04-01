import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PreviousList extends StatefulWidget {
  @override
  _PreviousListState createState() => _PreviousListState();
}

class _PreviousListState extends State<PreviousList> {
  final Firestore _firestore = Firestore.instance;
  String x;

  Future<String> _getValue(String house, String month, String year) async {
    await _firestore
        .collection('readings')
        .document(year)
        .collection(month)
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        if (f.data['house'] == house) {
          x = f.data['bill'].toString();
          return x;
        }
        return 'no';
      });
    });
  }

  List<Widget> _buildCells(int count, bool isHouse) {
    return List.generate(
      count,
      (index) => Container(
        alignment: Alignment.center,
        width: 120.0,
        height: 60.0,
        color: Colors.white,
        margin: EdgeInsets.all(4.0),
        child: isHouse
            ? index == 0
                ? Text(
                    'House number',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      //fontStyle: FontStyle.italic,
                    ),
                  )
                : index < 3
                    ? Text('f$index')
                    : index > 5 ? Text('t${index - 5}') : Text('s${index - 2}')
            : Text('${_getValue('f1', '3', '2020')}'),
      ),
    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
      count,
      (index) => Row(
        children: _buildCells(10, false),
      ),
    );
  }

  List<Widget> _buildColumns(int count) {
    return List.generate(
        count,
        (index) => Column(
              children: _buildCells(9, false),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous readings'),
      ),
      body: Column(
        children: <Widget>[
          //_headers(10, 10),
          SingleChildScrollView(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildCells(9, true),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      //children: _buildRows(9),
                      children: _buildColumns(8),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
