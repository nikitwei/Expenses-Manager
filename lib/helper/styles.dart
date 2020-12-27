import 'package:TestESB/helper/constant.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Styles {
  static final primaryColor = Colors.blue,
      colorGreen = const Color(0xff4caf50),
      colorGray = const Color(0xff616161),
      baseTextStyle = const TextStyle(fontFamily: 'Poppins'),
      smallTextStyle = baseTextStyle.copyWith(
        fontSize: 9.0,
        color: colorGray,
      ),
      largeTextStyle = baseTextStyle.copyWith(
        fontSize: 20.0,
      ),
      titleTextStyle = baseTextStyle.copyWith(
          color: Colors.white, fontSize: 18.0, fontWeight: FontWeight.w600),
      headerTextStyle = baseTextStyle.copyWith(
          color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.w400);

  static String toIDTime(DateTime dateTime) {
    final _dateTime = DateFormat('dd/MM/yyyy');
    String result = _dateTime.format(dateTime);
    return result;
  }

  static String toIDR(double amount) {
    final _amount = NumberFormat("#,##0", "id_ID");
    String result = _amount.format(amount);
    return StaticString.currencySymbol + " $result";
  }
}
