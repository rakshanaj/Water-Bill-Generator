import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PreviousList extends StatefulWidget {
  @override
  _PreviousListState createState() => _PreviousListState();
}

class _PreviousListState extends State<PreviousList> {

  int selectedYear;

  final Firestore _firestore = Firestore.instance;


  Widget _buildBody(BuildContext context) {
    int year = 2020;
    for (var month = 1; month < 13; month++) {
      return StreamBuilder<QuerySnapshot>(
        stream: _firestore
            .collection('readings')
            .document('$year')
            .collection('$month')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return LinearProgressIndicator();
          return DataTable(
            columns: _columnList(),
            //rows: _buildList(context, snapshot.data.documents),
            rows: _rowList(),
          );
        },
      );
    }
  }


  List<DataColumn> _columnList() {
    List months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];

    List<DataColumn> list = [];
    for (var i = 0; i < 11; i++) {
      if (i == 0) {
        list.add(DataColumn(
            label: Text('house')
        ));
      }
      else {
        list.add(DataColumn(
          label: Text(months[i + 1]),
        ));
      }
    }
    return list;
  }

  List<DataRow> _rowList() {
    List<DataRow> list = [];
    List<DataCell> cells = [];
    for (var i = 1; i < 8
    ; i++) {
      cells = [];
      cells.add(
          DataCell(Text('Hx'))
      );
      for (var j = 1; j < 12; j++) {
        cells.add(DataCell(Text('value')));
      }
      list.add(DataRow(cells: cells));
    }
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
