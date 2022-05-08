import 'package:flutter/material.dart';

class Dummy extends StatefulWidget {
  @override
  _DummyState createState() => _DummyState();
}

class _DummyState extends State<Dummy> {
  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(h * 0.08),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
              icon:
              Icon(Icons.arrow_back_rounded, color: Colors.black, size: 25),
              onPressed: () {
                Navigator.pop(context);
              }),
          centerTitle: true,
          title: Container(
            padding: EdgeInsets.only(top: 8),
            child: Image.asset(
              'images/logo.png',
              fit: BoxFit.contain,
              height: 35,
            ),
          ),
        ),
      ),
      body: ListView(),
    );
  }
}
