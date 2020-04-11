import 'package:flutter/material.dart';

class PreviousReadings extends StatefulWidget {
  @override
  _PreviousReadingsState createState() => _PreviousReadingsState();
}

class _PreviousReadingsState extends State<PreviousReadings>
    with TickerProviderStateMixin {
  AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState

    animationController = AnimationController(
        duration: const Duration(milliseconds: 600), vsync: this);

    super.initState();
  }

  Widget _boxes(String img, String text1, String text2, Color color1,
      Color color2) {
    return SizedBox(
      //width of entire column basically
      width: 130,
      child: Stack(
        children: <Widget>[
          Padding(
            padding:
            const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 8),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.blueGrey.withOpacity(0.6),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0),
                ],
                gradient: LinearGradient(
                  colors: [color1, color2],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(54.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 54, left: 16, right: 8, bottom: 8),
                child: Container(
                  height: 80,
                  width: 400,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        text1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 0.2,
                          color: Colors.white,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                text2,
                                style: TextStyle(
                                  //fontFamily: FintnessAppTheme.fontName,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                  letterSpacing: 0.2,
                                  color: Colors.white.withOpacity(0.75),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(60, 0, 0, 0),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          shape: BoxShape.circle,
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                                color: Colors.black12.withOpacity(0.4),
                                offset: Offset(8.0, 8.0),
                                blurRadius: 8.0),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4),
                          child: Icon(
                            Icons.keyboard_arrow_right,
                            color: Colors.blueGrey,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.amber,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 8,
            left: 8,
            child: SizedBox(
              width: 50,
              height: 50,
              child: Image.asset(img),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text('Tenant Profile'),
      ),

//          Container(
//            height: MediaQuery.of(context).size.height * 0.05,
//            child: HouseListView(
//              mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
//                  CurvedAnimation(
//                      parent: animationController,
//                      curve: Interval((1 / 9) * 3, 1.0,
//                          curve: Curves.fastOutSlowIn))),
//              mainScreenAnimationController: animationController,
//            ),
//          ),
      body: Container(
        height: MediaQuery
            .of(context)
            .size
            .height * 0.8,
        margin: EdgeInsets.all(15),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                _boxes('assets/images/f.png', 'F1', 'xyz',
                    Colors.brown.shade700, Colors.brown.shade300),
                _boxes('assets/images/f.png', 'F2', 'Roshan',
                    Colors.brown.shade700, Colors.brown.shade300),
              ],
            ),
            Row(
              children: <Widget>[
                _boxes('assets/images/s.png', 'S1', 'Gowtham',
                    Colors.blue.shade900, Colors.lightBlueAccent.shade400),
                _boxes('assets/images/s.png', 'S2', 'Shane',
                    Colors.blue.shade900, Colors.lightBlueAccent.shade400),
                _boxes('assets/images/s.png', 'S3', 'Sathish',
                    Colors.blue.shade900, Colors.lightBlueAccent.shade400),
              ],
            ),
            Row(
              children: <Widget>[
                _boxes('assets/images/t.png', 'T1', 'Ankit',
                    Colors.red.shade900, Colors.red.shade200),
                _boxes('assets/images/t.png', 'T2', 'Shastri',
                    Colors.red.shade900, Colors.red.shade200),
                _boxes('assets/images/t.png', 'T3', 'boys',
                    Colors.red.shade900, Colors.red.shade200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
