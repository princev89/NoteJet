import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:notejet/admob_service.dart';
import 'package:notejet/pages/addnote.dart';
import 'package:notejet/pages/chats.dart';
import 'package:notejet/pages/listsubjects.dart';
import 'package:notejet/pages/timetable.dart';
import 'package:notejet/pages/update_profile.dart';
import 'package:notejet/pages/writetous.dart';
import 'package:notejet/widgets/blogs.dart';
import 'package:upgrader/upgrader.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String branch = "";
  String year = "";
  bool isAdmin = false;

  Future<void> checkAdmin() async {
    FirebaseFirestore.instance
        .collection('admins')
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        setState(() {
          isAdmin = true;
        });
      }
    });
  }

  Future<void> getUser() async {
    print('getting user');
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.get('branch'));
        setState(() {
          branch = documentSnapshot.get('branch');
          year = documentSnapshot.get('year').toString();
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  void initState() {
    super.initState();
    if (!_isInterstitialAdReady) {
      _loadInterstitialAd();
    }
    getUser();
    checkAdmin();
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
    return Scaffold(
      backgroundColor: Color(0xff19324a),
      bottomNavigationBar: Container(
          height: 100,
          width: double.infinity,
          child: AdWidget(
            key: UniqueKey(),
            ad: AdMobService.creatBannerAd()..load(),
          )),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xff19324a),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    FirebaseAuth.instance.currentUser.displayName,
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Year: " + year.toString(),
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            ListTile(
              title: const Text('Update Profile'),
              onTap: () {
                if (_isInterstitialAdReady) {
                  _interstitialAd.show();
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UpdateProfile()),
                );
              },
            ),
            if (isAdmin == true)
              ListTile(
                title: Text('Add Notes'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddNotes()),
                  );
                },
              ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xff19324a),
        title: Text(
          'NoteJet',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: UpgradeAlert(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: Text(
                  FirebaseAuth.instance.currentUser.displayName,
                  style: GoogleFonts.poppins(
                      fontSize: 18, color: CupertinoColors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubjectList(
                              collectionname:
                                  branch.toString() + year.toString(),
                              listType: "Notes",
                              isNotes: true,
                            ),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            child: Image.asset('assets/images/book.png'),
                          ),
                          Text(
                            "Notes",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SubjectList(
                              collectionname:
                                  branch.toString() + year.toString(),
                              listType: "Quantum",
                              isNotes: false,
                            ),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                      child: Column(children: [
                        SizedBox(
                          height: 80,
                          child: Image.asset('assets/images/quantum.jpg'),
                        ),
                        Text(
                          "Quantum",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TimeTable(),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            child: Image.asset('assets/images/book.png'),
                          ),
                          Text(
                            "TimeTable",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WriteToUs(),
                          ));
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                      child: Column(children: [
                        SizedBox(
                          height: 80,
                          child: Image.asset('assets/images/discuss.jpg'),
                        ),
                        Text(
                          "Write To Us",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ]),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      if (_isInterstitialAdReady) {
                        _interstitialAd.show();
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Chats(
                                  year: 'chats' + year,
                                )),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.all(20),
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black38,
                                blurRadius: 5,
                                offset: Offset(0, 2))
                          ]),
                      child: Column(children: [
                        SizedBox(
                          height: 80,
                          child: Image.asset('assets/images/updateprofile.png'),
                        ),
                        Text(
                          "Chats",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                        ),
                      ]),
                    ),
                  )
                ],
              ),
              Divider(
                height: 30,
                thickness: 1,
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 26),
                        child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              'Blogs For You',
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.bold,
                                  color: CupertinoColors.white),
                            )),
                      ),
                      Container(
                        height: 150,
                        child: BlogsRow(
                          collectionname: 'cseitblogs',
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
