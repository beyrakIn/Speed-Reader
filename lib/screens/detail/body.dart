import 'dart:async';

import 'package:demo1/components/Banner.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Body extends StatefulWidget {
  String text;
  String text1 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit";
  List<String> list;
  double wpm;

  Body({this.text, this.list, this.wpm});

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool start = false;
  bool play = false;
  bool say = false;
  int currentIndex = 0;
  double interval;
  Timer _timer;
  final FlutterTts flutterTts = FlutterTts();

  void _startTimer() async {
    interval = 60 / widget.wpm.toInt();
    _timer = Timer.periodic(Duration(milliseconds: (interval * 1000).toInt()),
        (timer) {
      setState(() {
        if (currentIndex < widget.list.length - 1) {
          if (start && play) {
            currentIndex++;
          } else if (!start && play) {
            currentIndex = 0;
            play = false;
            _timer.cancel();
          } else {
            _timer.cancel();
          }
        } else {
          start = false;
          play = false;
          currentIndex = 0;
          _timer.cancel();
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Spacer(),
              Spacer(),
              Expanded(
                child: Text(
                  widget.list[currentIndex],
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Spacer(),
              ElevatedButton.icon(
                onPressed: () => {
                  if (start)
                    {
                      this.currentIndex = 0,
                      play = false,
                      // this._timer.cancel(),
                    }
                  else
                    {_startTimer()},
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
                                (this.currentIndex <= 0)
                                    // ignore: unnecessary_statements
                                    ? null
                                    : this.currentIndex--;
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
                                (this.currentIndex >= widget.list.length - 1)
                                    ? null
                                    : this.currentIndex++;
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
                          if (say) {
                            flutterTts.stop();
                          } else {
                            speak(widget.text1);
                          }
                          // say
                          //     ? () => {flutterTts.stop(), say = false}
                          //     : speak(widget.text);
                          say = !say;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(22.0),
                    child: FloatingActionButton.extended(
                      onPressed: () async {
                        await flutterTts.speak(widget.list[currentIndex]
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
              CustomBanner()
            ],
          ),
        ),
      ),
    );
  }

  speak(String text) async {
    await flutterTts.setLanguage("tr-TR");
    await flutterTts.speak(text
        .toLowerCase()
        .replaceAll("ə", "e")
        .replaceAll("x", "h")
        .replaceAll("ğ", "k"));

    setState(() {
      say = false;
    });
  }
}
