import 'package:TestESB/helper/constant.dart';
import 'package:flutter/material.dart';

class FormDialog {
  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    Function onPressed, {
    bool isConfirmationDIalog = false,
    String buttonText2 = "",
    Function onPressed2,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              FlatButton(
                onPressed: () => onPressed(),
                child: Text(buttonText),
              ),
              Visibility(
                visible: isConfirmationDIalog,
                child: FlatButton(
                  onPressed: () => onPressed2(),
                  child: Text(buttonText2),
                ),
              ),
            ],
          );
        });
  }

  static void input(
    BuildContext context,
    TextEditingController controller,
    String title,
    String labelText,
    String buttonTextYes,
    Function onPressedYes,
    String buttonTextNo,
    Function onPressedNo,
  ) {
    final _formKeyDialogs = GlobalKey<FormState>();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: Form(
              key: _formKeyDialogs,
              child: TextFormField(
                validator: (value) => value.isEmpty
                    ? "$labelText ${StaticString.alertBlank}"
                    : null,
                decoration: InputDecoration(labelText: labelText),
                controller: controller,
              ),
            ),
            actions: [
              FlatButton(
                onPressed: () => onPressedNo(),
                child: Text(buttonTextNo),
              ),
              FlatButton(
                onPressed: () => _formKeyDialogs.currentState.validate()
                    ? onPressedYes()
                    : null,
                child: Text(buttonTextYes),
              ),
            ],
          );
        });
  }
}
