import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api/card.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);
  final String title;
//  final databaseReference = Firestore.instance;
//  void createRecord() async {
//    final databaseReference = Firestore.instance;
//    DocumentReference ref = await databaseReference.collection("pricing").add({
//      'dollar':dollar,
//      'euro': euro,
//      'lbd':lbd,
//      'saodia': saodia,
//    });
//    print(ref.documentID);
//  }
//  String dollar='';
//  String euro='';
//  String lbd='';
//  String saodia='';
//
//  void getData() {
//    databaseReference
//        .collection("books")
//        .getDocuments()
//        .then((QuerySnapshot snapshot) {
//      snapshot.documents.forEach((f) => print('${f.data}}'));
//    });
//  }

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  _buildCard({Config config, Color backgroundColor = Colors.transparent}) {
    return Container(
      height: 152.0,
      width: double.infinity,
      child: Container(
        child: WaveWidget(
          config: config,
          backgroundColor: backgroundColor,
          size: Size(double.infinity, double.infinity),
          waveAmplitude: 5,
        ),
      ),
    );
  }

  MaskFilter _blur;
  final List<MaskFilter> _blurs = [
    null,
    MaskFilter.blur(BlurStyle.normal, 10.0),
    MaskFilter.blur(BlurStyle.inner, 10.0),
    MaskFilter.blur(BlurStyle.outer, 10.0),
    MaskFilter.blur(BlurStyle.solid, 16.0),
  ];
  int _blurIndex = 0;
  MaskFilter _nextBlur() {
    if (_blurIndex == _blurs.length - 1) {
      _blurIndex = 0;
    } else {
      _blurIndex = _blurIndex + 1;
    }
    _blur = _blurs[_blurIndex];
    return _blurs[_blurIndex];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(),
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 10.0,
        backgroundColor: Colors.blueGrey[800],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: Firestore.instance.collection("pricing").snapshots(),
          builder: (context, snapshot){

            if (snapshot.data == null)
              return Center(child: CircularProgressIndicator());
            return Column(
              children: <Widget>[
                SizedBox(height: 50.0,
                  child:Text(snapshot.data.documents[0]["date"]),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.60,
                  width: MediaQuery.of(context).size.width * 0.90,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: Firestore.instance.collection("pricing").snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.data == null)
                        return Center(child: CircularProgressIndicator());
                      print(snapshot.data.documents[0]["dollar"]);
                      return ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        children: [
                          // Text(timeago.format(DateTime.tryParse(timestamp.toDate().toString())).toString()),
                          CardItem(
                              "سعر الدولار اليوم",
                              Colors.red,
                              "assets/img/dollar.jpg",
                              FontAwesomeIcons.dollarSign,
                              snapshot.data.documents[0]["dollar"].toString()),
                          CardItem(
                              "سعر اليورو اليوم",
                              Colors.orange,
                              "assets/img/euro.jpg",
                              FontAwesomeIcons.euroSign,
                              snapshot.data.documents[0]["euro"].toString()),
                          CardItem(
                              "سعر الليره اللبنانية اليوم",
                              Colors.green,
                              "assets/img/lbd.jpg",
                              FontAwesomeIcons.coins,
                              snapshot.data.documents[0]["lbd"].toString()),
                          CardItem(
                              "سعر الريال السعودي اليوم",
                              Colors.lightBlue,
                              "assets/img/sodia.jpg",
                              FontAwesomeIcons.solidFlag,
                              snapshot.data.documents[0]["sar"].toString()),
                        ],
                      );
                    },
                  ),
                ),
                _buildCard(
                  config: CustomConfig(
                    gradients: [
                      [Colors.red, Color(0xEEF44336)],
                      [Colors.red[800], Color(0x77E57373)],
                      [Colors.orange, Color(0x66FF9800)],
                      [Colors.yellow, Color(0x55FFEB3B)]
                    ],
                    durations: [35000, 19440, 10800, 6000],
                    heightPercentages: [0.20, 0.23, 0.25, 0.30],
                    blur: _blur,
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                )
              ],
            );
          }

//            child: Column(
//            children: <Widget>[
//              SizedBox(height: 50.0,
//              child:Text(snapshot.data.documents[0]["date"]),
//              ),
//              Container(
//                height: MediaQuery.of(context).size.height * 0.60,
//                width: MediaQuery.of(context).size.width * 0.90,
//                child: StreamBuilder<QuerySnapshot>(
//                  stream: Firestore.instance.collection("pricing").snapshots(),
//                  builder: (context, snapshot) {
//                    if (snapshot.data == null)
//                      return Center(child: CircularProgressIndicator());
//                    print(snapshot.data.documents[0]["dollar"]);
//                    return ListView(
//                      shrinkWrap: true,
//                      scrollDirection: Axis.horizontal,
//                      children: [
//                   // Text(timeago.format(DateTime.tryParse(timestamp.toDate().toString())).toString()),
//                        CardItem(
//                            "سعر الدولار اليوم",
//                            Colors.red,
//                            "assets/img/dollar.jpg",
//                            FontAwesomeIcons.dollarSign,
//                            snapshot.data.documents[0]["dollar"].toString()),
//                        CardItem(
//                            "سعر اليورو اليوم",
//                            Colors.orange,
//                            "assets/img/euro.jpg",
//                            FontAwesomeIcons.euroSign,
//                            snapshot.data.documents[0]["euro"].toString()),
//                        CardItem(
//                            "سعر الليره اللبنانية اليوم",
//                            Colors.green,
//                            "assets/img/lbd.jpg",
//                            FontAwesomeIcons.coins,
//                            snapshot.data.documents[0]["lbd"].toString()),
//                        CardItem(
//                            "سعر الريال السعودي اليوم",
//                            Colors.lightBlue,
//                            "assets/img/sodia.jpg",
//                            FontAwesomeIcons.solidFlag,
//                            snapshot.data.documents[0]["sar"].toString()),
//                      ],
//                    );
//                  },
//                ),
//              ),
//              _buildCard(
//                config: CustomConfig(
//                  gradients: [
//                    [Colors.red, Color(0xEEF44336)],
//                    [Colors.red[800], Color(0x77E57373)],
//                    [Colors.orange, Color(0x66FF9800)],
//                    [Colors.yellow, Color(0x55FFEB3B)]
//                  ],
//                  durations: [35000, 19440, 10800, 6000],
//                  heightPercentages: [0.20, 0.23, 0.25, 0.30],
//                  blur: _blur,
//                  gradientBegin: Alignment.bottomLeft,
//                  gradientEnd: Alignment.topRight,
//                ),
//              )
//            ],
//          ),
        ),
      ),
    );
  }
}
