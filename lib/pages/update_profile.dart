import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notejet/pages/home.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(FirebaseAuth.instance.currentUser.email)
        .set({
          'branch': 'cseit',
          'year': int.parse(year),
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String branch = "";
  String year = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white24,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: Column(
            children: [
              Text(
                'Update Profile',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 30), color: Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoButton(
                color: CupertinoColors.darkBackgroundGray,
                onPressed: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      title: const Text('Select Year'),
                      actions: <CupertinoActionSheetAction>[
                        CupertinoActionSheetAction(
                          child: const Text('1st'),
                          onPressed: () {
                            setState(() {
                              year = "1";
                            });
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('2nd'),
                          onPressed: () {
                            setState(() {
                              year = "2";
                            });
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('3rd'),
                          onPressed: () {
                            setState(() {
                              year = "3";
                            });
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('4th'),
                          onPressed: () {
                            setState(() {
                              year = "4";
                            });
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: year.length > 0
                    ? Text("Selected year : " + year)
                    : Text('Select Year'),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 25),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    print('done');
                    addUser();
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Profile Updated"),
                    ));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => HomePage()));
                  },
                  child: Text(
                    'Update Profile',
                    style: TextStyle(color: Colors.blue, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.all(25),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
            ],
          ),
        ));
  }
}
