import 'package:flutter/material.dart';

class CustomSwitch extends StatelessWidget {
  final bool value;
  final String textTrue;
  final String textFalse;
  final Function onTap;
  CustomSwitch({Key key, this.value, this.textFalse, this.textTrue, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final list = [textTrue, textFalse];
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customRadio(list[0], value),
              customRadio(list[1], !value),
            ],
          )
        ],
      ),
    );
  }

  Widget customRadio(String txt, bool value) {
    return Expanded(
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.blue),
            color: value ? Colors.blue : Colors.white,
          ),
          child: Center(
            child: Text(
              txt,
              style: TextStyle(color: value ? Colors.white : Colors.black),
            ),
          ),
        ),
      ),
    );
  }
}
