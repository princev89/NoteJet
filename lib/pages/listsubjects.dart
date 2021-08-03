import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notejet/pages/webview.dart';

class SubjectList extends StatefulWidget {
  final String collectionname;
  final String listType;

  const SubjectList({Key key, this.collectionname, this.listType})
      : super(key: key);

  @override
  _SubjectListState createState() => _SubjectListState();
}

class _SubjectListState extends State<SubjectList> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection(widget.collectionname)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          widget.listType.toString(),
          style: TextStyle(color: Colors.black87),
        ),
        backgroundColor: Colors.white,
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
                child: ExpansionTile(
                  title: Card(
                    elevation: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 30,
                            width: 30,
                            child: Image(image: NetworkImage(data['imgUrl'])),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            data['name'],
                            style:
                                GoogleFonts.monda(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  children: [
                    data['unit1'] != null
                        ? buildUnitCard(context, "Unit 1", data['unit1'])
                        : SizedBox(
                            height: 0,
                          ),
                    data['unit2'] != null
                        ? buildUnitCard(context, "Unit 2", data['unit2'])
                        : SizedBox(
                            height: 0,
                          ),
                    data['unit3'] != null
                        ? buildUnitCard(context, "Unit 3", data['unit3'])
                        : SizedBox(
                            height: 0,
                          ),
                    data['unit4'] != null
                        ? buildUnitCard(context, "Unit 4", data['unit4'])
                        : SizedBox(
                            height: 0,
                          ),
                    data['unit5'] != null
                        ? buildUnitCard(context, "Unit 5", data['unit5'])
                        : SizedBox(
                            height: 0,
                          )
                  ],
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
        onTap: () {
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
