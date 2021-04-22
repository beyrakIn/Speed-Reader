import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeButton extends StatefulWidget {
  final String text;
  final String buttonText;
  final double wpm;
  final Icon icon;
  final VoidCallback function;

  const HomeButton(
      {Key key, this.text, this.wpm, this.buttonText, this.icon, this.function})
      : super(key: key);

  @override
  _HomeButtonState createState() => _HomeButtonState();
}

class _HomeButtonState extends State<HomeButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton.extended(
          onPressed: widget.function,
          icon: widget.icon,
          label: Text(widget.buttonText),
        ),
      ),
    );
  }
}
