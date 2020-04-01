import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BillGeneration extends StatefulWidget {
  @override
  _BillGenerationState createState() => _BillGenerationState();
}


class _BillGenerationState extends State<BillGeneration> {

  final Firestore _firestore = Firestore.instance;
  String house;
  int currentReading, previousReading;
  String monthOfReading = '${DateTime
      .now()
      .month}',
      yearOfReading = '${DateTime
          .now()
          .year}';
  int phone, bill;
  int currentYear = DateTime
      .now()
      .year;

  int previousReadingYear = DateTime
      .now()
      .year;

  //to display current month as default month of reading
  TextEditingController defaultMonth = TextEditingController()
    ..text = '${DateTime
        .now()
        .month}';
  TextEditingController defaultYear = TextEditingController()
    ..text = '${DateTime
        .now()
        .year}';


  //this function adds current reading to db and retrieves phone number

  void _generateBill(String house, int currentReading, String monthOfReading,
      int previousReadingMonth,
      String yearOfReading) async {
    //this if statement makes sure that the previous reading is in the previous month even when years change
    if (previousReadingMonth == 0) {
      setState(() {
        previousReadingMonth = 12;
        previousReadingYear = currentYear - 1;
      });
    }
    else {
      setState(() {
        previousReadingMonth = int.parse(monthOfReading) - 1;
        previousReadingYear = int.parse(yearOfReading);
      });
    }

    print(
        'prevYear is $previousReadingYear and prevMonth is $previousReadingMonth');


//    print(
//        ' for $house, currReading is $currentReading, for month $monthOfReading, and year $yearOfReading');

    //adding current reading to db

    setState(() {
      bill = 0;
      previousReading = 0;
    });

    if (house != null && currentReading != null && monthOfReading != null &&
        yearOfReading != null) {
      await _firestore.collection('readings')
          .document('$yearOfReading')
          .collection('$monthOfReading')
          .document(house)
          .setData({
        'house': house,
        'current': currentReading,
        'day': DateTime
            .now()
            .day,
        'bill': 0,
      });
      print('added! current readin is $currentReading');

      //retrieving previous reading from db


      await _firestore.collection('readings')
          .document('$previousReadingYear')
          .collection('$previousReadingMonth')
          .getDocuments().then((QuerySnapshot snapshot) {
        snapshot.documents.forEach((f) {
          if (f.data['house'] == house) {
            previousReading = f.data['current'];
          }
        });
      });
      if (previousReading == null) {
        setState(() {
          previousReading = 0;
        });
      }
      print('previous reading is $previousReading');

//calculate bill amount

      setState(() {
        bill = currentReading - previousReading;
      });

      await _firestore.collection('readings')
          .document('$yearOfReading')
          .collection('$monthOfReading')
          .document(house)
          .updateData({
        'current': currentReading,
        'bill': bill,
      });

      //bill added

//gets phone number from particular house number
/*
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
*/
    } //in case input parameters are null
    else {
      print('one or more data givn is null');
    }
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
                  setState(() {
                    house = value;
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.home),
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
                  setState(() {
                    currentReading = int.parse(value);
                  });
                },
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.grade),
                  labelText: 'Current Reading',
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: TextField(
                controller: defaultMonth,
                onChanged: (value) {
                  setState(() {
                    monthOfReading = value;
                  });
                },
                decoration: InputDecoration(
                  //icon:Icon(Icons.add,),
//                    suffix: IconButton(
//                      onPressed: (){
//                        print('icon pressed and onthofReading is $monthOfReading');
//                        setState(() {
//                          defaultMonth.text=(int.parse(monthOfReading)+1).toString();
//                        });
//                      },
//                      icon:Icon(Icons.add,),
//                    ),
                  labelText: 'Month of reading',
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),

              ),
            ),

            Container(
              margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: TextField(
                controller: defaultYear,
                onChanged: (value) {
                  setState(() {
                    yearOfReading = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Year of reading',
                  border: new OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            RaisedButton(
              onPressed: () {
                print(
                    ' for $house, currReading is $currentReading, for month $monthOfReading, and year $yearOfReading with prevreadingMonth as ${int
                        .parse(monthOfReading) - 1}');
                _generateBill(
                    house, currentReading, monthOfReading,
                    int.parse(monthOfReading) - 1, yearOfReading);
              },
              child: Text('Generate bill'),
            ),

            Text('bill is $bill'),

          ],
        ),
      ),
    );
  }
}
