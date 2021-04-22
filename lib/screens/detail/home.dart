import 'dart:async';

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
    interval = 60 / wpm.toInt();

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
    await flutterTts
        .speak(text.toLowerCase().replaceAll("ə", "e").replaceAll("x", "h").replaceAll("ğ", "k"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                Spacer(),
                Spacer(),
                Expanded(
                  child: Text(
                    list[listIndex],
                    style: TextStyle(fontSize: 25),
                  ),
                ),
                Spacer(),
                ElevatedButton.icon(
                  onPressed: () => {
                    start
                        ? () {
                            this.listIndex = 0;
                            play = false;
                            this._timer.cancel();
                          }
                        : _startTimer(),
                    play = true,
                    start = !start
                  },
                  icon: Icon(
                      start
                          ? Icons.stop_circle_outlined
                          : Icons.play_circle_outline,
                      size: 28),
                  label: Text(start ? "STOP" : "START"),
                ),
                ElevatedButton.icon(
                  onPressed: start
                      ? () => {
                            play = !play,
                            play ? this._timer.cancel() : _startTimer(),
                          }
                      : null,
                  icon: Icon(
                      play
                          ? Icons.pause_circle_outline
                          : Icons.play_circle_outline,
                      size: 28),
                  label: Text(play ? "PAUSE" : "RESUME"),
                ),
                Spacer(),
                Wrap(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        label: Text("PREV"),
                        onPressed: play
                            ? null
                            : () {
                                setState(() {
                                  (this.listIndex <= 0)
                                      // ignore: unnecessary_statements
                                      ? null
                                      : this.listIndex--;
                                });
                              },
                        icon: Icon(Icons.skip_previous_outlined),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton.icon(
                        label: Text("NEXT"),
                        onPressed: play
                            ? null
                            : () {
                                setState(() {
                                  (this.listIndex >= list.length - 1)
                                      // ignore: unnecessary_statements
                                      ? null
                                      : this.listIndex++;
                                });
                              },
                        icon: Icon(Icons.skip_next_outlined),
                      ),
                    ),
                  ],
                ),
                Wrap(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: FloatingActionButton(
                        elevation: 10,
                        backgroundColor: say ? Colors.red : Colors.green,
                        child: Icon(
                          say ? Icons.stop : Icons.speaker,
                          size: 30,
                        ),
                        onPressed: () {
                          setState(() {
                            say ? flutterTts.stop() : speak();
                            say = !say;
                          });
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(22.0),
                      child: FloatingActionButton.extended(
                        onPressed: () async {
                          await flutterTts.speak(list[listIndex]
                              .toLowerCase()
                              .replaceAll("ə", "e")
                              .replaceAll("x", "h")
                              .replaceAll("ğ", "k"));
                        },
                        elevation: 10,
                        icon: Icon(Icons.speaker),
                        label: Text("SPEAK"),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
