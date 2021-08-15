import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notejet/admob_service.dart';
import 'package:notejet/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notejet/pages/signup.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

const primaryColor = const Color(0xff19324a);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  AdMobService.initialize();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  static final String oneSignalAppId = "3744f44f-34cb-4e45-a468-9a0b4b48ee63";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteJet',
      theme: ThemeData(
        primaryColor: primaryColor,
      ),
      home: FirebaseAuth.instance.currentUser != null ? HomePage() : SignUp(),
      debugShowCheckedModeBanner: false,
    );
  }

  Future<void> initPlatformState() async {
    OneSignal.shared.setAppId(oneSignalAppId);
  }
}
