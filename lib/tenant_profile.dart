import 'package:flutter/material.dart';

class TenanatProfile extends StatefulWidget {
  @override
  _TenanatProfileState createState() => _TenanatProfileState();
}

class _TenanatProfileState extends State<TenanatProfile> {
  final _formkey = GlobalKey<FormState>();

  String house, name;
  int phone, year, month;

  void _setTenantDetails(
      String house, String name, int phone, int month, int year) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Tenant Profile'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Form(
          key: _formkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextFormField(
                  validator: (val) {
                    house = val;
                    if (val.length != 2)
                      return 'Invalid house number';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'House number',
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
//                    borderSide: new BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextFormField(
                  validator: (val) {
                    name = val;
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
//                    borderSide: new BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextFormField(
                  validator: (val) {
                    phone = int.parse(val);
                    if (val.length != 10)
                      return 'Invalid phone number';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Phone number',
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
//                    borderSide: new BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextFormField(
                  validator: (val) {
                    month = int.parse(val);
                    if (val.length != 2)
                      return 'Invalid month';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Month of arrival MM',
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
//                    borderSide: new BorderSide(),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: TextFormField(
                  validator: (val) {
                    year = int.parse(val);
                    if (val.length != 4)
                      return 'Invalid year of arrival';
                    else
                      return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Year of arrival YYYY',
                    border: new OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
//                    borderSide: new BorderSide(),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {
                  _setTenantDetails(house, name, phone, month, year);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
