import 'package:flutter/material.dart';
import 'package:notejet/pages/chats.dart';
import 'package:notejet/pages/home.dart';
import 'package:notejet/pages/update_profile.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => new _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int i = 0;
  var pages = [new HomePage(), new Chats(), new UpdateProfile()];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: pages[i],
      bottomNavigationBar: new BottomNavigationBar(
        items: [
          new BottomNavigationBarItem(
            icon: new Icon(Icons.home),
            title: new Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.photo_library),
            title: new Text('Blog'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.book),
            title: new Text('Library'),
          ),
          new BottomNavigationBarItem(
            icon: new Icon(Icons.notifications),
            title: new Text('Notifications'),
          ),
        ],
        currentIndex: i,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            i = index;
          });
        },
      ),
    );
  }
}
