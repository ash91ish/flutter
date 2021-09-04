import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Hero UI Design",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.pink),
      home: HeroUi(),
    );
  }
}

class HeroUi extends StatefulWidget {
  const HeroUi({Key? key}) : super(key: key);

  @override
  _HeroUiState createState() => _HeroUiState();
}

class _HeroUiState extends State<HeroUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Hero UI Design"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              for (var i = 0; i < 6; i++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 500),
                            pageBuilder: (BuildContext context,
                                    Animation<double> animation,
                                    Animation<double> secondaryanimation) =>
                                Second_Screen(
                                  data: "$i",
                                ),
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return Align(
                                child: FadeTransition(
                                  opacity: animation,
                                  child: child,
                                ),
                              );
                            }));
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    height: 100,
                    width: 100,
                    child: Hero(
                      tag: "$i",
                      child: CircleAvatar(
                        backgroundColor: Colors.pink,
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class Second_Screen extends StatefulWidget {
  final data;
  const Second_Screen({Key? key, @required this.data}) : super(key: key);

  @override
  _Second_ScreenState createState() => _Second_ScreenState();
}

class _Second_ScreenState extends State<Second_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Second screen"),
      ),
      body: Container(
        child: Column(
          children: [
            Hero(
              tag: widget.data,
              child: Container(
                color: Colors.pink,
                margin: EdgeInsets.all(15),
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
              ),
            )
          ],
        ),
      ),
    );
  }
}
