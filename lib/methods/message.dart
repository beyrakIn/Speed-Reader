import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

message({BuildContext context, String title, String message}) {
  var alert = new AlertDialog(
    title: Text(title),
    content: Text(message),
  );

  showDialog(
    context: context,
    builder: (BuildContext context) => alert,
  );
}
