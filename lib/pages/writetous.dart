import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WriteToUs extends StatefulWidget {
  const WriteToUs({Key key}) : super(key: key);

  @override
  _WriteToUsState createState() => _WriteToUsState();
}

Widget buildEmail() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Email',
        style: TextStyle(
            fontSize: 10, fontWeight: FontWeight.bold, color: Colors.white),
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
                  color: Colors.black38, blurRadius: 5, offset: Offset(0, 2))
            ]),
        height: 50,
        child: TextField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(color: Colors.black87),
          decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 10),
              prefixIcon: Icon(
                Icons.email,
                color: Colors.blueAccent[100],
              ),
              hintText: 'Email'),
        ),
      )
    ],
  );
}

class _WriteToUsState extends State<WriteToUs> {
  String email;
  String message;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white24,
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NoteJet',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 60), color: Colors.white),
              ),
              Text(
                'Write To Us',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(fontSize: 40), color: Colors.white),
              ),
              SizedBox(
                height: 60,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                      enabled: false,
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 10),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.blueAccent[100],
                          ),
                          hintText: FirebaseAuth.instance.currentUser.email),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Write To Us',
                    style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
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
                        this.message = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(top: 2, left: 2),
                      ),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 25),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    print(message);
                    CollectionReference users =
                        FirebaseFirestore.instance.collection('writetous');

                    // Call the user's CollectionReference to add a new user
                    await users.add({
                      'email':
                          FirebaseAuth.instance.currentUser.email, // John Doe
                      'message': message,
                      // 42
                    }).then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Thanks for writing....."),
                      ));
                    }).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text(
                            "There is some error....Please Try Again Later"),
                      ));
                    });
                  },
                  child: Text(
                    'Send',
                    style:
                        TextStyle(color: Colors.blueAccent[100], fontSize: 20),
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
