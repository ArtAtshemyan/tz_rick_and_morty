import 'package:flutter/material.dart';

import '/presentation/pages/navigation/navigation_page.dart';
import '../constants/app_strings.dart';

class Routes {
  static const String navRoute = "/";
  static const String homeRoute = "/home";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.navRoute:
        return MaterialPageRoute(builder: (_) => const NavigationPage());
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (_) => Container());
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text(
            AppStrings.strNoRouteFound,
          ),
        ),
        body: Center(
          child: Text(
            AppStrings.strNoRouteFound,
          ),
        ),
      ),
    );
  }
}
