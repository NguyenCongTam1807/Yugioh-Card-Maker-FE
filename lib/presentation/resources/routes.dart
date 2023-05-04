import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/presentation/resources/strings.dart';

import '../../presentation/card_creator_screen/card_creator_view.dart';
import '../../presentation/settings_screen/settings_view.dart';

class RouteNames {
  static const String cardCreator = "/";
  static const String settings = "/settings";
}

class RouteGenerator {
  static Route getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.cardCreator:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteNames.cardCreator),
            builder: (_) => CardCreatorView());
      case RouteNames.settings:
        return MaterialPageRoute(builder: (_) => const SettingsView());
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
