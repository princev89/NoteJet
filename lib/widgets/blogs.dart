import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notejet/pages/webview.dart';

class BlogsRow extends StatefulWidget {
  final String collectionname;

  const BlogsRow({Key key, this.collectionname}) : super(key: key);

  @override
  _BlogsRowState createState() => _BlogsRowState();
}

class _BlogsRowState extends State<BlogsRow> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection(widget.collectionname)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
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

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: new ListView(
            scrollDirection: Axis.horizontal,
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebViewPage(
                              url: data['contentUrl'],
                            )),
                  );
                },
                child: Card(
                    elevation: 1,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: Image.network(
                              data['imgUrl'],
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: 20,
                            color: Colors.blue,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                data['title'],
                                style: GoogleFonts.roboto(color: Colors.white),
                              ),
                            ),
                          )
                        ])),
              );
            }).toList(),
          ),
        );
      },
    );
  }
}
