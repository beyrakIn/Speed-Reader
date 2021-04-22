import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final String text;
  final String buttonText;
  final double wpm;
  final Icon icon;
  final VoidCallback function;

  const Button(
      {Key key, this.text, this.wpm, this.buttonText, this.icon, this.function})
      : super(key: key);

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
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
