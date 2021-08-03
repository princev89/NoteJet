import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notejet/pages/listsubjects.dart';
import 'package:notejet/pages/update_profile.dart';
import 'package:notejet/widgets/blogs.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String branch = "";
  String semester = "";
  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser.email)
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        print(documentSnapshot.get('branch'));
        setState(() {
          branch = documentSnapshot.get('branch');
          semester = documentSnapshot.get('semester');
        });
      } else {
        print('Document does not exist on the database');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'NoteJet',
          style: TextStyle(color: Colors.black87),
        ),
        leading: Icon(Icons.notes, color: Colors.black54),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: Color(0xfff2f5f7),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        // image: DecorationImage(
                        //   image: NetworkImage(
                        //       'https://i.pinimg.com/originals/32/b8/77/32b877ed4aa7778cc7d43ebb7d95a6f1.png'),
                        //   fit: BoxFit.cover,
                        // ),
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(30))),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          FirebaseAuth.instance.currentUser.displayName,
                          style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.black45),
                        ),
                        branch.length != 0
                            ? Text(
                                branch.toUpperCase(),
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              )
                            : Text('Loading Branch'),
                        branch.length != 0
                            ? Text(
                                "Semester No: " + semester,
                                style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black45),
                              )
                            : Text('Loading Semester'),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    branch.length == 0
                        ? ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                                "Update your profile before using other options"),
                          ))
                        : Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubjectList(
                                collectionname:
                                    branch.toString() + semester.toString(),
                                listType: "Notes",
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
                          child: Image.network(
                              'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3a/Book-icon-bible.png/480px-Book-icon-bible.png'),
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
                  onTap: () {},
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
                        child: Image.network(
                            'https://png.pngtree.com/element_our/png_detail/20181208/notes-icon-png_265236.jpg'),
                      ),
                      Text(
                        "Books",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
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
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: Text(
                          "Work in Progress.... You may able to access in next update."),
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
                        child: Image.network(
                            'https://icon-library.com/images/discussion-icon/discussion-icon-13.jpg'),
                      ),
                      Text(
                        "Discussion",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                    ]),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UpdateProfile()),
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
                        child: Image.network(
                            'https://www.shareicon.net/data/512x512/2016/06/30/788856_edit_512x512.png'),
                      ),
                      Text(
                        "Update Profile",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black54),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Blogs For You',
                    style: GoogleFonts.poppins(color: Colors.black38),
                  )),
            ),
            if (branch == "cseit")
              Container(
                height: 200,
                child: BlogsRow(
                  collectionname: 'cseitblogs',
                ),
              ),
            // if (branch == "cseit")
            //   Container(
            //     height: 200,
            //     child: BlogsRow(
            //       collectionname: 'cseitblogs',
            //     ),
            //   )
          ],
        ),
      ),
    );
  }
}
