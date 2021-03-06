import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:notejet/pages/home.dart';
import 'package:notejet/pages/signup.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
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

Widget buildPassword() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Password',
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
                Icons.lock_outline,
                color: Colors.blueAccent[100],
              ),
              hintText: 'Password'),
        ),
      )
    ],
  );
}

class _LogInState extends State<LogIn> {
  String email;
  String password;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff008ff9),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 100, horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'NoteJet',
                style: GoogleFonts.lato(
                    textStyle: TextStyle(fontSize: 30, color: Colors.white)),
              ),
              Text(
                'Log In',
                style: GoogleFonts.poppins(
                  textStyle: TextStyle(fontSize: 22, color: Colors.white),
                ),
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
                        fontSize: 14,
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
                      onChanged: (value) {
                        this.email = value;
                      },
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
              ),
              SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Password',
                    style: TextStyle(
                        fontSize: 14,
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
                      onChanged: (value) {
                        this.password = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.only(top: 10),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.blueAccent[100],
                          ),
                          hintText: 'Password'),
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 25),
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    print('done');
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (FirebaseAuth.instance.currentUser != null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("successfully login with " + email),
                      ));
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.green,
                        content: Text("Sorry login with " + email),
                      ));
                    }
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.blueAccent, fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      padding: EdgeInsets.all(25),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Don\'t have an Account? ',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500)),
                  TextSpan(
                      text: 'Sign Up',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold))
                ])),
              )
            ],
          ),
        ));
  }
}
