import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yugioh_card_creator/presentation/resources/strings.dart';

import '../../presentation/settings_screen/settings_view.dart';
import '../main_screen/card_creator_page/card_creator_view.dart';

class RouteNames {
  static const String cardCreator = "/";
  static const String settings = "/settings";
  static const String help = "/help";
}

class RouteGenerator {
  static Route getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RouteNames.cardCreator:
        return MaterialPageRoute(
            settings: const RouteSettings(name: RouteNames.cardCreator),
            builder: (_) => const CardCreatorView());
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
