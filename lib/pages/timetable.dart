import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeTable extends StatefulWidget {
  @override
  _TimeTableState createState() => _TimeTableState();
}

class _TimeTableState extends State<TimeTable> {
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('TTCSE4B').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Time Table')),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data() as Map<String, dynamic>;
              var timetable = data['classes'];

              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Start",
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                      Text(document.id.toUpperCase(),
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                      Text("End",
                          style:
                              GoogleFonts.roboto(fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    child: ListView.builder(
                        itemCount: timetable.length,
                        itemBuilder: (BuildContext context, int index) => Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(timetable[index]['start'],
                                      style: GoogleFonts.poppins()),
                                  Text(timetable[index]['subject'],
                                      style: GoogleFonts.poppins()),
                                  Text(timetable[index]['end'],
                                      style: GoogleFonts.poppins()),
                                ],
                              ),
                            )),
                  )
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
