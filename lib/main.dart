import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

void main() {
  runApp(Mp3Finder());
}

class Mp3Finder extends StatelessWidget {
  const Mp3Finder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mp3Finder",
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    );
  }
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getsongs();
  }

  List songlist = [];
  List mp3songlist = [];
  AudioPlayer audioPlayer = AudioPlayer();

  //find all data in download directory
  void getsongs() async {
    if (await Permission.storage.request().isGranted) {
      Directory dir = Directory("/storage/emulated/0/Download");
      try {
        List<FileSystemEntity> songdata;
        songdata = await dir.listSync(recursive: true, followLinks: false);
        setState(() {
          songlist.addAll(songdata);
          findmp3();
        });
      } catch (e) {
        print(e);
      }
    }
  }

  //separate only mp3 files
  Future findmp3() async {
    for (var i = 0; i < songlist.length; i++) {
      // mp3 data true or false
      bool mp3data =
          songlist[i].toString().replaceAll("'", "").split(".").last == "mp3";

      if (mp3data == true) {
        setState(() {
          mp3songlist.add(songlist[i]
              .toString()
              .replaceAll("File: ", "")
              .replaceAll("'", ""));
        });
      }
    }
  }

  playAudio(String path) {
    try {
      audioPlayer.play("$path");
    } catch (e) {
      print(e);
    }
  }

  pauseAudio() async {
    try {
      await audioPlayer.pause();
    } catch (e) {
      print(e);
    }
  }

  resumeAudio() async {
    try {
      await audioPlayer.resume();
    } catch (e) {
      print(e);
    }
  }

  stopAudio() async {
    try {
      await audioPlayer.stop();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Mp3 Find And Play"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Column(
                children: mp3songlist
                    .map((e) => GestureDetector(
                          onTap: () {
                            playAudio(e.toString());
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            margin: EdgeInsets.all(5),
                            color: Colors.indigo[200],
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              e.toString().split("/").last,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ))
                    .toList(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        pauseAudio();
                      },
                      icon: Icon(
                        Icons.pause,
                        size: 40,
                      )),
                  IconButton(
                      onPressed: () {
                        resumeAudio();
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        size: 40,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () {
                        stopAudio();
                      },
                      icon: Icon(
                        Icons.stop,
                        size: 40,
                        color: Colors.red,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
