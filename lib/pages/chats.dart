import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Chats extends StatefulWidget {
  final year;
  Chats({Key key, this.year}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
  bool isChecked = false;
  final fieldText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference chats =
        FirebaseFirestore.instance.collection(widget.year);
    FirebaseAuth auth = FirebaseAuth.instance;

    Future<void> sendMessage(String msg) {
      // Call the user's CollectionReference to add a new user
      return chats
          .add({
            'uid': auth.currentUser.uid,
            'full_name': auth.currentUser.displayName, // John Doe
            'message': msg,
            'upload_time': FieldValue.serverTimestamp(), // Stokes and Sons
          })
          .then((value) => print("message Added"))
          .catchError((error) => print("Failed to add message: $error"));
    }

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Color(0xff19324a),
          title: Text(
            "Welcome " +
                FirebaseAuth.instance.currentUser.displayName.toString(),
            style: GoogleFonts.poppins(fontSize: 14),
          )),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: StreamBuilder<QuerySnapshot>(
          stream: chats.orderBy('upload_time', descending: false).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            final _controller = ScrollController();
            Timer(
              Duration(seconds: 1),
              () => _controller.jumpTo(_controller.position.maxScrollExtent),
            );
            return Column(
              children: [
                Expanded(
                  child: new ListView(
                    controller: _controller,
                    children:
                        snapshot.data.docs.map((DocumentSnapshot document) {
                      int len = document.get('message').toString().length;
                      return Padding(
                        padding: EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            auth.currentUser.uid == document.get('uid')
                                ? Padding(
                                    padding: EdgeInsets.only(
                                        left: 150 - len.toDouble(), right: 10),
                                    child: Container(
                                      width: 500,
                                      decoration: BoxDecoration(
                                          color: Color(0xff19324a),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 10),
                                            child: Text(
                                              document.get('full_name'),
                                              style: GoogleFonts.lato(
                                                  color: CupertinoColors
                                                      .activeGreen),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              document.get('message'),
                                              style: GoogleFonts.roboto(
                                                color: Colors.white,
                                                fontSize: 14,
                                                wordSpacing: 0.8,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.only(
                                      right: 150 - len.toDouble(),
                                      left: 5,
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Color(0xff19324a),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 4, horizontal: 10),
                                            child: Text(
                                              document.get('full_name'),
                                              style: GoogleFonts.lato(
                                                  color: CupertinoColors
                                                      .activeGreen),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Text(
                                              document.get('message'),
                                              style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontSize: 14,
                                                wordSpacing: 0.5,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                Container(
                    height: 60,
                    color: Color(0xffbbcecf),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: TextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(100),
                        ],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Type a message',
                          suffixIcon: IconButton(
                            icon: Icon(Icons.send, color: Colors.black),
                            onPressed: () {
                              //send message
                              sendMessage(fieldText.text);
                              fieldText.clear();
                            },
                          ),
                        ),
                        controller: fieldText,
                      ),
                    ))
              ],
            );
          },
        ),
      ),
    );
  }
}
