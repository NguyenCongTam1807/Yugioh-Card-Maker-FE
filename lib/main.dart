import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yugioh_card_creator/application/dependency_injection.dart';

import 'application/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  initAppModule();
  runApp(const MyApp());
}
