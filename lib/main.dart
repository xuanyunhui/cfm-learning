import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'cycle_hex_decades.dart';
import 'home.dart';
import 'life_place.dart';
import 'true_solar_time.dart';
import 'timeset_calendar.dart';
import 'qimen.dart';

void main() {
  runApp(const MyApp());
}

class Routes {
  static const homePage = '/';

  static const palacePage = '/lifepalace';

  static const qimenPage = '/qimen';

  static const solarTimePage = '/solartime';

  static const cycleHexDecades = '/cyclehexdecades';

  static const timesetCalendar = '/timesetcalendar';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('zh', 'CN'), // Chinese
        Locale('ms', 'MY'), // Malay (Malaysia)
        Locale('en', 'US'), // English
        Locale('id', 'ID'), // Indonesian
        Locale('ru', 'RU'), // Russian
        Locale('th', 'TH'), // Thai
        Locale('de', 'DE'), // German
      ],
      title: 'Flutter Demo',
      theme: ThemeData(
          useMaterial3: true, colorSchemeSeed: const Color(0xffbe3455)),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: Routes.homePage,
      routes: {
        Routes.homePage: (context) => const MyHomePage(title: 'Home Page'),
        Routes.palacePage: (context) => const Palace(),
        Routes.qimenPage: (context) => const QiMenContent(),
        Routes.solarTimePage: (context) => const SolarTimeScreen(),
        Routes.cycleHexDecades: (context) => const CycleHexDecades(),
        Routes.timesetCalendar: (context) => const TimesetCalendar(),
      },
    );
  }
}

class ExampleDestination {
  const ExampleDestination(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<ExampleDestination> destinations = <ExampleDestination>[
  ExampleDestination(
      'page 0', Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
  ExampleDestination(
      'page 1', Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
  ExampleDestination(
      'page 2', Icon(Icons.text_snippet_outlined), Icon(Icons.text_snippet)),
  ExampleDestination(
      'page 3', Icon(Icons.invert_colors_on_outlined), Icon(Icons.opacity)),
];
