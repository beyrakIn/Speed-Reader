import 'package:demo1/screens/home/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _text = "TEXT";

/*
  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        waitTap: true,
      );

      setState(() {
        print(texts[0].value);
      });
    } on Exception {
      texts.add(new OcrText('Failed to recognize text.'));
    }
  }
*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.tealAccent,
      appBar: AppBar(
        centerTitle: true,
        title: new Text("Speed Reader✌", textAlign: TextAlign.center),
        actions: [],
        elevation: 0,
      ),
      body: Body()
    );
  }
}
