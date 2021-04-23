import 'dart:async';

import 'package:demo1/screens/detail/body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomeScreen extends StatefulWidget {
  String text;
  double wpm;

  HomeScreen({
    this.text,
    this.wpm,
  });

  List<String> text2List(String text) {
    List<String> result;
    result = text.split(" ");
    return result;
  }

  @override
  State<StatefulWidget> createState() {
    return _HomeState(list: text2List(text), wpm: this.wpm, text: text);
  }
}

class _HomeState extends State<HomeScreen> {
  String text;
  List<String> list;

  double wpm;
  bool start = false;
  bool play = false;
  bool say = false;
  int listIndex = 0;
  double interval;
  Timer _timer;

  //Text 2 Speech
  final FlutterTts flutterTts = FlutterTts();

  _HomeState({this.list, this.wpm, this.text});

  void _startTimer() {
    interval = 60 / widget.wpm.toInt();

    _timer = Timer.periodic(Duration(milliseconds: (interval * 1000).toInt()),
        (timer) {
      setState(() {
        if (listIndex < list.length - 1 && start && play) {
          listIndex++;
        } else if (!(listIndex < list.length - 1)) {
          start = false;
          play = false;
          listIndex = 0;
          _timer.cancel();
        } else if (!start && play) {
          listIndex = 0;
          play = false;
          _timer.cancel();
        } else {
          _timer.cancel();
        }
      });
    });
  }

  speak() async {
    await flutterTts.setLanguage("tr-TR");
    await flutterTts.speak(text
        .toLowerCase()
        .replaceAll("ə", "e")
        .replaceAll("x", "h")
        .replaceAll("ğ", "k"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: Body(
        text: widget.text,
        list: widget.text2List(widget.text),
        wpm: widget.wpm,
      ),
    );
  }
}
