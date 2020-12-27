import 'package:TestESB/helper/constant.dart';
import 'package:TestESB/ui/category_page/category_page.dart';
import 'package:TestESB/ui/home_page/home_page.dart';
import 'package:TestESB/ui/update_page/update_page.dart';
import 'package:flutter/material.dart';

class Routers {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Paths.homepage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case Paths.updatepage:
        return MaterialPageRoute(builder: (_) => UpdatePage());
      case Paths.categorypage:
        return MaterialPageRoute(builder: (_) => CategoryPage());
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}
