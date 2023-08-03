import 'dart:io';

import 'package:chooose/app.dart';
import 'package:chooose/firebase_options.dart';
import 'package:chooose/revenue_cat_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Purchases.setLogLevel(LogLevel.debug);

  if (Platform.isIOS) {
    final configuration = PurchasesConfiguration(revenueCatApiKey);
    await Purchases.configure(configuration);
  }

  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.bottom],
  );

  if (!Platform.isLinux) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    await FirebaseAppCheck.instance.activate(
      androidProvider: AndroidProvider.debug,
      appleProvider: AppleProvider.appAttest,
    );

    final analytics = FirebaseAnalytics.instance;
    await analytics.logAppOpen();
  }

  runApp(
    const ProviderScope(
      child: App(),
    ),
  );
}
