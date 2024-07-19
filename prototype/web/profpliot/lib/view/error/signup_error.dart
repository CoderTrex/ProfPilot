import 'package:flutter/material.dart';
import 'dart:core';

class ErrorDialog extends StatelessWidget {
  final String errorMessage;

  const ErrorDialog({Key? key, required this.errorMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String emailErrorMessage = _parseEmailErrorMessage(errorMessage);

    return AlertDialog(
      title: Text("Error"),
      content: Text(emailErrorMessage),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // 팝업을 닫습니다.
          },
          child: Text("OK"),
        ),
      ],
    );
  }

  String _parseEmailErrorMessage(String errorMessage) {
    String errormsg = " ";
    bool flag = false;

    for (int i = 0; i < errorMessage.length; i++) {
      if (!flag) {
        if (errorMessage[i] == "]") {
          flag = true;
        }
      } else {
        errormsg += errorMessage[i];
      }
    }
    return errormsg;
  }
}
