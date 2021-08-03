import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          'branch': branch,
          'semester': semester,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  String branch = "";
  String semester = "";
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
              CupertinoButton(
                color: CupertinoColors.darkBackgroundGray,
                onPressed: () {
                  showCupertinoModalPopup<void>(
                    context: context,
                    builder: (BuildContext context) => CupertinoActionSheet(
                      title: branch.length == 0
                          ? Text('Select Branch')
                          : Text(branch),
                      actions: <CupertinoActionSheetAction>[
                        CupertinoActionSheetAction(
                          child: const Text('CSE/IT'),
                          onPressed: () {
                            branch = "cseit";
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Select Branch'),
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
                      title: const Text('Select Semester'),
                      actions: <CupertinoActionSheetAction>[
                        CupertinoActionSheetAction(
                          child: const Text('1st'),
                          onPressed: () {
                            semester = "1";
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('2nd'),
                          onPressed: () {
                            semester = "2";
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('3rd'),
                          onPressed: () {
                            semester = "3";
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('4th'),
                          onPressed: () {
                            semester = "4";
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('5th'),
                          onPressed: () {
                            semester = "5";
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('6th'),
                          onPressed: () {
                            semester = "6";
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('7th'),
                          onPressed: () {
                            semester = "7";
                            Navigator.pop(context);
                          },
                        ),
                        CupertinoActionSheetAction(
                          child: const Text('8th'),
                          onPressed: () {
                            semester = "8";
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  );
                },
                child: const Text('Select Semester'),
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
