import 'package:chooose/page/home_page.dart';
import 'package:chooose/page/list_page.dart';
import 'package:chooose/page/onboarding_page.dart';
import 'package:chooose/page/purchase_page.dart';
import 'package:chooose/page/tab_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chooose',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        textTheme: GoogleFonts.interTextTheme(),
      ),
      home: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final prefs = snapshot.data as SharedPreferences;
            if (prefs.getBool('onboarding') == null) {
              return const OnboardingPage();
            } else {
              return const TabPage();
            }
          } else {
            return Container();
          }
        },
        future: SharedPreferences.getInstance(),
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/list': (context) => const ListPage(),
        '/purchase': (context) => const PurchasePage(),
      },
    );
  }
}
