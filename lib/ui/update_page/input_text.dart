import 'package:TestESB/helper/constant.dart';
import 'package:flutter/material.dart';

class IntputText extends StatefulWidget {
  dynamic input;
  TextEditingController controller;
  String labelText;
  Function(String) onChanged;
  IntputText(
      {Key key, this.input, this.controller, this.labelText, this.onChanged})
      : super(key: key);

  @override
  _IntputTextState createState() => _IntputTextState();
}

class _IntputTextState extends State<IntputText> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: (value) => widget.onChanged(value),
      controller: widget.controller,
      validator: (value) => value.isEmpty
          ? "${widget.labelText} ${StaticString.alertBlank}"
          : null,
      keyboardType: widget.input is DateTime
          ? TextInputType.datetime
          : widget.input is double
              ? TextInputType.number
              : TextInputType.text,
      decoration: InputDecoration(
        labelText: widget.labelText,
      ),
    );
  }
}
