import 'package:demo1/components/Button.dart';
import 'package:demo1/methods/message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

import '../detail/home.dart';

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
                ),
              ),
              Spacer(),
              Button(
                buttonText: "START READ",
                icon: Icon(Icons.play_circle_outline, size: 28),
                text: textController.text,
                wpm: wpmValue,
                function: () => {
                  (textController.text.isEmpty)
                      ? message(
                          context: context,
                          title: "Hey, You!❌",
                          message: "Enter your text😑")
                      : Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                          return HomeScreen(
                            text: textController.text,
                            wpm: wpmValue,
                          );
                        }))
                },
              ),
              Button(
                buttonText: "SCAN IMAGE",
                icon: Icon(Icons.qr_code_scanner_outlined, size: 28),
                function: () => {
                  message(
                    context: context,
                    title: "Good news✌",
                    message: "Coming soon😄"
                  )
                },
              ),
              Spacer(),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
