import 'dart:io';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Create Folder",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: CreateFolder(),
    );
  }
}

class CreateFolder extends StatefulWidget {
  const CreateFolder({Key? key}) : super(key: key);

  @override
  _CreateFolderState createState() => _CreateFolderState();
}

class _CreateFolderState extends State<CreateFolder> {
  TextEditingController _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    getpermission();
  }

  Future getpermission() async {
    await Permission.manageExternalStorage.request().isGranted;
    await Permission.storage.request().isGranted;
  }

  Future Folder(String data) async {
    Directory dir =
        await Directory("/storage/emulated/0/$data").create(recursive: false);
    print(dir);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        title: Text("Create Folder"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(hintText: "Enter Folder Name"),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (await Permission.manageExternalStorage
                      .request()
                      .isGranted) {
                    if (_controller.text.isNotEmpty) {
                      Folder(_controller.text);
                    } else {
                      print("Enter folder name");
                    }
                  }
                },
                child: Text("Create"))
          ],
        ),
      ),
    );
  }
}
