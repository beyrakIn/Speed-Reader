import 'package:demo1/components/Banner.dart';
import 'package:demo1/components/Button.dart';
import 'package:demo1/methods/message.dart';
import 'package:demo1/screens/detail/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinbox/flutter_spinbox.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final textController = TextEditingController();
  double wpmValue = 250;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
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
            HomeButton(
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
            HomeButton(
              buttonText: "SCAN IMAGE",
              icon: Icon(Icons.qr_code_scanner_outlined, size: 28),
              function: () => {
                message(
                    context: context,
                    title: "Good news✌",
                    message: "Coming soon😄")
              },
            ),
            Spacer(),
            // Spacer(),
            CustomBanner()
          ],
        ),
      ),
    );
  }
}
