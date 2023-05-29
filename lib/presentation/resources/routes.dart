import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/presentation/main_screen/main_screen_view.dart';
import 'package:yugioh_card_creator/presentation/resources/strings.dart';

import '../../application/dependency_injection.dart';
import '../../presentation/settings_screen/settings_view.dart';

class RouteNames {
  static const String main = "/";
  static const String settings = "/settings";
}

class RouteGenerator {
  static Route getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.main:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteNames.main),
            builder: (_) => MainScreenView());
      case RouteNames.settings:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteNames.settings),
            builder: (_) => const SettingsView()
        );
      default:
        return unDefinedRoute();
    }
  }

  static Route unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text(Strings.noRouteFound),
              ),
              body: const Center(child: Text(Strings.noRouteFound)),
            ));
  }
}
