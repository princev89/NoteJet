import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:notejet/admob_service.dart';
import 'package:notejet/pages/webview.dart';

class SubjectList extends StatefulWidget {
  final String collectionname;
  final String listType;
  final bool isNotes;

  const SubjectList({Key key, this.collectionname, this.listType, this.isNotes})
      : super(key: key);

  @override
  _SubjectListState createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  @override
  void initState() {
    super.initState();
    print(widget.collectionname);
    print('inint');
    if (!_isInterstitialAdReady) {
      _loadInterstitialAd();
    }
  }

  // static String get interstitialAdUnitId => Platform.isAndroid
  //     ? 'ca-app-pub-3940256099942544/1033173712'
  //     : 'ca-app-pub-3940256099942544/1033173712';
  static String get interstitialAdUnitId => Platform.isAndroid
      ? 'ca-app-pub-9243136424645877/9718385107'
      : 'ca-app-pub-9243136424645877/9718385107';
  InterstitialAd _interstitialAd;

  bool _isInterstitialAdReady = false;

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: interstitialAdUnitId,
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          this._interstitialAd = ad;

          ad.fullScreenContentCallback = FullScreenContentCallback(
            onAdDismissedFullScreenContent: (ad) {
              print('dimissed');
            },
          );

          _isInterstitialAdReady = true;
        },
        onAdFailedToLoad: (err) {
          print('Failed to load an interstitial ad: ${err.message}');
          _isInterstitialAdReady = false;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection(widget.collectionname)
        .snapshots();
    return Scaffold(
      bottomNavigationBar: Container(
          height: 100,
          child: AdWidget(
            key: UniqueKey(),
            ad: AdMobService.creatBannerAd()..load(),
          )),
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          widget.listType.toString(),
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CupertinoActivityIndicator(
                radius: 20,
              ),
            );
          }

          return new ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: widget.isNotes == true
                    ? ExpansionTile(
                        title: Card(
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              data['name'],
                              style: GoogleFonts.monda(
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        children: [
                          data['unit1'] != null
                              ? buildUnitCard(
                                  context,
                                  "Unit 1",
                                  data['unit1'],
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          data['unit2'] != null
                              ? buildUnitCard(
                                  context,
                                  "Unit 2",
                                  data['unit2'],
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          data['unit3'] != null
                              ? buildUnitCard(
                                  context,
                                  "Unit 3",
                                  data['unit3'],
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          data['unit4'] != null
                              ? buildUnitCard(
                                  context,
                                  "Unit 4",
                                  data['unit4'],
                                )
                              : SizedBox(
                                  height: 0,
                                ),
                          data['unit5'] != null
                              ? buildUnitCard(context, "Unit 5", data['unit5'])
                              : SizedBox(
                                  height: 0,
                                )
                        ],
                      )
                    : GestureDetector(
                        onTap: () async {
                          if (_isInterstitialAdReady) {
                            _interstitialAd.show();
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WebViewPage(
                                      url: data['quantum'],
                                    )),
                          );
                        },
                        child: Card(
                          color: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              data['name'],
                              style: GoogleFonts.monda(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

Widget buildUnitCard(BuildContext context, name, url) {
  return Container(
    width: double.infinity,
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    child: GestureDetector(
        onTap: () async {
          // await launch(url);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebViewPage(
                      url: url,
                    )),
          );
        },
        child: Text(
          name,
          style: GoogleFonts.lato(
            fontSize: 20,
          ),
        )),
  );
}
