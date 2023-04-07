import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cycle_hex_decades.dart';
import 'home.dart';
import 'life_place.dart';
import 'provider/theme_settings.dart';
import 'settings.dart';
import 'true_solar_time.dart';
import 'timeset_calendar.dart';
import 'qimen.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // final int themeindex = sharedPreferences.getInt('theme') ?? 0;

  // ignore: prefer_const_constructors
  runApp(MyApp());
}

class Routes {
  static const homePage = '/';

  static const palacePage = '/lifepalace';

  static const qimenPage = '/qimen';

  static const solarTimePage = '/solartime';

  static const cycleHexDecades = '/cyclehexdecades';

  static const timesetCalendar = '/timesetcalendar';

  static const settings = '/settings';
}

class MyApp extends StatelessWidget {
  // final int themeIndex;
  const MyApp({super.key});
  // const MyApp({super.key, required this.themeIndex});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeSettings(),
        builder: (context, snapshot) {
          final settings = Provider.of<ThemeSettings>(context);
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
              useMaterial3: true,
              colorScheme:
                  settings.getlightColorScheme(), // settings.themeData.light
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              colorScheme: settings.getdarkColorScheme(),
            ),
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
            initialRoute: Routes.homePage,
            routes: {
              Routes.homePage: (context) =>
                  const MyHomePage(title: 'Home Page'),
              Routes.palacePage: (context) => const Palace(),
              Routes.qimenPage: (context) => const QiMenContent(),
              Routes.solarTimePage: (context) => const SolarTimeScreen(),
              Routes.cycleHexDecades: (context) => const CycleHexDecades(),
              Routes.timesetCalendar: (context) => const TimesetCalendar(),
              Routes.settings: (context) => const Settings()
            },
          );
        });
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
