import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class DownloadProgress extends StatefulWidget {
  final filename;
  final url;
  DownloadProgress({Key key, this.url, this.filename}) : super(key: key);

  @override
  _DownloadProgressState createState() => _DownloadProgressState();
}

class _DownloadProgressState extends State<DownloadProgress> {
  String progressString = "Click Here to Start Downloading";

  Future<void> downloadFile() async {
    var dir = await getExternalStorageDirectory();
    Dio dio = Dio();

    try {
      print(dir);
      await dio.download(
          widget.url, "${dir.path}${widget.url.toString().substring(28)}",
          onReceiveProgress: (rec, total) {
        print("Rec: $rec, Total: $total");
        setState(() {
          progressString = ((rec / total) * 100).toStringAsFixed(0) + "%";
        });
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      progressString = 'Download Completed\n Check this Path: ' +
          "${dir.path}${widget.url.toString().substring(28)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_element

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: CupertinoButton(
                color: CupertinoColors.activeGreen,
                onPressed: () {
                  downloadFile();
                },
                child: Text(
                  progressString,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
