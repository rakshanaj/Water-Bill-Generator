import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PreviousList extends StatefulWidget {
  @override
  _PreviousListState createState() => _PreviousListState();
}

class _PreviousListState extends State<PreviousList> {

  @override
  void initState() {
    super.initState();
    y = 0;
  }

  int selectedYear;

  final Firestore _firestore = Firestore.instance;
  String x;
  int y;

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
          (index) =>
          Container(
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
                : Text('bruh what'),
            //: Text('${_getValue('f1', '3', '2020')}'),
          ),
    );
  }

  Widget _buildData(String month, String year, String house) {
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('readings')
          .document(year)
          .collection(month)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final houses = snapshot.data.documents;
          List<MonthReads> monthlyreadings = [];
          print('y is $y');
          if (y == 0) {
            monthlyreadings.add(MonthReads(
              house: house,
              month: month,
              year: year,
              current: int.parse(month),
            ));
            y++;
          }
          for (var h in houses) {
            if (h.data['house'] == house) {
              final fbHouse = h.data['house'];
              final fbCurrent = h.data['current'];

              final box = MonthReads(
                month: month,
                year: year,
                house: fbHouse,
                current: fbCurrent,
              );

              monthlyreadings.add(box);
            }
//            else if(house == 's2'){
//              final box = MonthReads(
//                month: month,
//                year: year,
//                house: house,
//                current: 0,
//              );
//
//              monthlyreadings.add(box);
//            }
          }

          return Column(

            children: monthlyreadings,
          );
        }
        return Text('not yet bro');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous readings'),
      ),
      body: ListView(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width / 2,
                margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      selectedYear = int.parse(value);
                    });
                  },
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.date_range),
                    labelText: 'Year',
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {},
                child: Text('Year'),
              ),
            ],
          ),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        _buildData('3', '2020', 'f1'),
                        _buildData('3', '2020', 'f2'),
                        _buildData('3', '2020', 's1'),
                        _buildData('3', '2020', 's2'),
                        _buildData('3', '2020', 's3'),
                        _buildData('3', '2020', 't1'),
                        _buildData('3', '2020', 't2'),
                        _buildData('3', '2020', 't3'),
                      ],
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

class MonthReads extends StatelessWidget {
  final String month;
  final String year;
  final int current;
  final String house;

  MonthReads({this.house, this.year, this.month, this.current});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 120.0,
      height: 60.0,
      color: Colors.white,
      margin: EdgeInsets.all(4.0),
      child: Text('$current'),
    );
  }
}
