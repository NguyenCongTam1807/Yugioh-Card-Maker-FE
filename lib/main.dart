import 'dart:async';
import 'dart:ui';

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yugioh_card_creator/application/dependency_injection.dart';
import 'package:yugioh_card_creator/presentation/resources/defaults.dart';
import 'package:yugioh_card_creator/presentation/resources/images.dart';

import 'amplifyconfiguration.dart';
import 'application/app.dart';
import 'firebase_options.dart';

Future<void> _configureAmplify() async {
  try {
    final auth = AmplifyAuthCognito();
    final storage = AmplifyStorageS3();
    await Amplify.addPlugins([auth, storage]);

    // call Amplify.configure to use the initialized categories in your app
    await Amplify.configure(amplifyconfig);
  } on Exception catch (e) {
    safePrint('An error occurred configuring Amplify: $e');
  }
}

Future<void> preloadImages(List<ImageProvider> providers) async {
  final ImageConfiguration config = ImageConfiguration(
    bundle: rootBundle,
    platform: defaultTargetPlatform,
  );

  late Completer completer;
  late ImageStreamListener listener;

  for (var provider in providers) {
    final ImageStream stream = provider.resolve(config);

    completer = Completer<void>();
    listener = ImageStreamListener((ImageInfo image, bool sync) {
      completer.complete();
      stream.removeListener(listener);
    }, onError: (Object exception, StackTrace? stackTrace) {
      completer.complete();
      stream.removeListener(listener);
      FlutterError.reportError(FlutterErrorDetails(
        context: ErrorDescription('image failed to load'),
        library: 'image resource service',
        exception: exception,
        stack: stackTrace,
        silent: true,
      ));
    });

    stream.addListener(listener);
    await completer.future;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await _configureAmplify();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await initAppModule();
  await preloadImages([
    const AssetImage(ImagePath.cardImageEditButton),
    const AssetImage(ImagePath.cardTypeEditButton),
    const AssetImage(ImagePath.defaultCardFrame),
    const AssetImage(ImagePath.defaultMonsterAttribute),
    const AssetImage(ImagePath.cardLevelStar),
    const AssetImage(CardDefaults.defaultCardImage),
  ]);
  runApp(MyApp());
}
