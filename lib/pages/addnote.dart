import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({Key key}) : super(key: key);

  @override
  _AddNotesState createState() => _AddNotesState();
}

class _AddNotesState extends State<AddNotes> {
  String year;
  String subjectId;
  String subjectName;
  String quantum;
  String unit1;
  String unit2;
  String unit3;
  String unit4;
  String unit5;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Notes'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: CupertinoButton(
                  color: CupertinoColors.activeBlue,
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
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(0, 2))
                    ]),
                height: 50,
                child: TextField(
                  onChanged: (value) {
                    this.subjectId = value;
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      hintText: 'Enter Subject Id (EX: se, wt, cn)'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(0, 2))
                    ]),
                height: 50,
                child: TextField(
                  onChanged: (value) {
                    this.subjectName = value;
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      hintText: 'Enter Subject Name'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(0, 2))
                    ]),
                height: 50,
                child: TextField(
                  onChanged: (value) {
                    this.quantum = value;
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      hintText: 'Quantum Link'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(0, 2))
                    ]),
                height: 50,
                child: TextField(
                  onChanged: (value) {
                    this.unit1 = value;
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      hintText: 'Unit 1 Link'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(0, 2))
                    ]),
                height: 50,
                child: TextField(
                  onChanged: (value) {
                    this.unit2 = value;
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      hintText: 'Unit 2 Link'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(0, 2))
                    ]),
                height: 50,
                child: TextField(
                  onChanged: (value) {
                    this.unit3 = value;
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      hintText: 'Unit 3 Link'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(0, 2))
                    ]),
                height: 50,
                child: TextField(
                  onChanged: (value) {
                    this.unit4 = value;
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      hintText: 'Unit 4 Link'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black38,
                          blurRadius: 5,
                          offset: Offset(0, 2))
                    ]),
                height: 50,
                child: TextField(
                  onChanged: (value) {
                    this.unit5 = value;
                  },
                  keyboardType: TextInputType.text,
                  style: TextStyle(color: Colors.black87),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(top: 10, left: 10),
                      hintText: 'Unit 5 Link'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoButton(
                  child: Text('Add Note'),
                  onPressed: () {
                    CollectionReference collection = FirebaseFirestore.instance
                        .collection("cseit" + year.toString());
                    collection
                        .add(
                          {
                            'id': subjectId,
                            'name': subjectName,
                            'quantum': quantum,
                            'unit1': unit1,
                            'unit2': unit2,
                            'unit3': unit3,
                            'unit4': unit4,
                            'unit5': unit5,
                          },
                        )
                        .then((value) => print("User Added"))
                        .catchError(
                            (error) => print("Failed to add user: $error"));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
