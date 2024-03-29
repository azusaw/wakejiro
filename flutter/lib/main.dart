import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_sample/screens/home_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'common/theme_color.dart';
import 'models/app_database.dart';

void main() => runApp(
      ProviderScope(
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [const Locale("ja")],
      theme: ThemeData.light().copyWith(
          colorScheme: ColorScheme.light().copyWith(
              primary: ThemeColor.primary, secondary: ThemeColor.accent),
          primaryColor: ThemeColor.primary,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          )),
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: ColorScheme.dark().copyWith(
              primary: ThemeColor.primary, secondary: ThemeColor.accent),
          primaryColor: ThemeColor.primary,
          pageTransitionsTheme: PageTransitionsTheme(
            builders: <TargetPlatform, PageTransitionsBuilder>{
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
              TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
            },
          )),
      home: HomeScreen(),
    );
  }
}
