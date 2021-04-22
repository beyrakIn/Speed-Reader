import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:demo1/main.dart';

import '../home.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();
  double wpmValue = 250;
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
          child: Column(
            children: [
              Spacer(),
              TextFormField(
                decoration: InputDecoration(labelText: 'Enter your text'),
                controller: textController,
              ),
              Spacer(),
              Text("Enter WPM"),
              Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
                  child: SpinBox(
                    min: 50,
                    max: 2000,
                    value: wpmValue,
                    step: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      contentPadding: const EdgeInsets.all(0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        this.wpmValue = value;
                      });
                    },
                  )),
              Spacer(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                  onPressed: () => {
                    (textController.text.isEmpty)
                        ? message(context)
                        : Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return HomeScreen(
                            text: textController.text,
                            wpm: wpmValue,
                          );
                        }))
                  },
                  icon: Icon(Icons.play_circle_outline, size: 28),
                  label: Text("START READ"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: FloatingActionButton.extended(
                  onPressed: null, //_read,
                  icon: Icon(Icons.qr_code_scanner_outlined, size: 28),
                  label: Text("SCAN IMAGE"),
                ),
              ),
              Spacer(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  message(BuildContext context) {
    var title = "Hey, You!❌";
    var message = "Enter your text😑";

    var alert = new AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(
      context: context,
      builder: (BuildContext context) => alert,
    );
  }

}
