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

  Widget _buildBody(BuildContext context) {
    int year = 2020,
        month = 3;
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore
          .collection('readings')
          .document('$year')
          .collection('$month')
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();
        return DataTable(
          columns: [
            DataColumn(label: Text('House Number')),
            DataColumn(label: Text('month $month')),
          ],
          rows: _buildList(context, snapshot.data.documents),
        );
      },
    );
  }

  List<DataRow> _buildList(BuildContext context,
      List<DocumentSnapshot> snapshot) {
    return snapshot.map((data) => _buildListItem(context, data)).toList();
  }

  DataRow _buildListItem(BuildContext context, DocumentSnapshot data) {
    final record = Record.fromSnapshot(data);

    return DataRow(
        cells: [
          DataCell(Text(record.house)),
          DataCell(Text('${record.current}')),
        ]
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous readings'),
      ),
      body: _buildBody(context),
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


class Record {
  final String house;
  final int day, current, bill;
  final DocumentReference reference;

  Record.fromMap(Map<String, dynamic> map, {this.reference})
      : assert(map['house'] != null),
        assert(map['current'] != null),
        assert(map['bill'] != null),
        assert(map['day'] != null),
        house = map['house'],
        current = map['current'],
        day = map['day'],
        bill = map['bill'];

  Record.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(snapshot.data, reference: snapshot.reference);

}
