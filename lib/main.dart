import 'package:TestESB/helper/constant.dart';
import 'package:TestESB/helper/routers.dart';
import 'package:TestESB/helper/styles.dart';
import 'package:flutter/material.dart';
import 'package:TestESB/ui/home_page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Styles.primaryColor),
      initialRoute: Paths.homepage,
      onGenerateRoute: Routers.generateRoute,
      home: HomePage(),
    );
  }
}
