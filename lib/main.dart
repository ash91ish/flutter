import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "get json",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: getjson(),
    );
  }
}

class getjson extends StatefulWidget {
  const getjson({Key? key}) : super(key: key);

  @override
  _getjsonState createState() => _getjsonState();
}

class _getjsonState extends State<getjson> {
  @override
  void initState() {
    super.initState();
    jsondata();
  }

  List<dynamic> jsonlist = [];

  void jsondata() async {
    if (Platform.isAndroid) {
      http.Response response = await http
          .get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));
      if (response.statusCode == 200) {
        List<dynamic> jdata = jsonDecode(response.body);
        setState(() {
          jsonlist.addAll(jdata);
        });
        print(jdata.length);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("get json data"),
      ),
      body: Container(
        child: Column(
          children: [
            Container(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  for (var i = 0; i < 10; i++)
                    Container(
                      height: 200,
                      width: MediaQuery.of(context).size.width / 1.05,
                      alignment: Alignment.center,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(""),
                    )
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: jsonlist
                      .map((e) => Row(
                            children: [
                              Container(
                                height: 120,
                                width: MediaQuery.of(context).size.width / 2,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Text(""),
                              ),
                              Column(
                                children: [
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Text(
                                        "${e['title']}",
                                        maxLines: 2,
                                        style: TextStyle(fontSize: 18),
                                      )),
                                  Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.5,
                                      child: Text(
                                        "${e['body']}",
                                        maxLines: 2,
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              )
                            ],
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
