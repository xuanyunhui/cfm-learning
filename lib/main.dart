import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qimen/qimen.dart';

import 'cycle_hex_decades.dart';
import 'generated/l10n.dart';
import 'home.dart';
import 'life_place.dart';
import 'provider/theme_settings.dart';
import 'settings.dart';
import 'true_solar_time.dart';
import 'timeset_calendar.dart';
import 'qimen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // final int themeindex = sharedPreferences.getInt('theme') ?? 0;
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
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
  MyApp({super.key});

  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: "/",
        builder: (context, state) => const Home(),
        routes: <RouteBase>[
          GoRoute(path: "qimen", builder: (context, state) => const QiMenContent()),
          GoRoute(path: "settings", builder: (context, state) => const Settings()),
          GoRoute(path: "lifepalace", builder: (context, state) => const Palace()),
          GoRoute(path: "solartime", builder: (context, state) => const SolarTimeScreen()),
          GoRoute(path: "cyclehexdecades", builder: (context, state) => const CycleHexDecades()),
          GoRoute(path: "timesetcalendar", builder: (context, state) => const TimesetCalendar()),
      ],
      
    )
  ]);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => ThemeSettings(),
        builder: (context, snapshot) {
          final settings = Provider.of<ThemeSettings>(context);
          return MaterialApp.router(
            routerDelegate: _router.routerDelegate,
            routeInformationParser: _router.routeInformationParser,
            routeInformationProvider: _router.routeInformationProvider,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            title: 'Flutter Demo',
            theme: ThemeData(
                useMaterial3: true,
                colorScheme: settings.getlightColorScheme(),
                appBarTheme: const AppBarTheme(elevation: 4)),
            darkTheme: ThemeData(
                useMaterial3: true,
                colorScheme: settings.getdarkColorScheme(),
                appBarTheme: const AppBarTheme(elevation: 4)),
            // home: const MyHomePage(title: 'Flutter Demo Home Page'),
            // initialRoute: Routes.homePage,
            // routes: {
            //   Routes.homePage: (context) => const Home(),
            //   Routes.palacePage: (context) => const Palace(),
            //   Routes.qimenPage: (context) => const QiMenContent(),
            //   Routes.solarTimePage: (context) => const SolarTimeScreen(),
            //   Routes.cycleHexDecades: (context) => const CycleHexDecades(),
            //   Routes.timesetCalendar: (context) => const TimesetCalendar(),
            //   Routes.settings: (context) => const Settings()
            // },
          );
        });
  }
}
