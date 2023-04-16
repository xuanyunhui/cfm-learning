import 'package:cfm_learning/provider/selected_index.dart';
import 'package:cfm_learning/screens/theme_setting_screen.dart';
import 'package:cfm_learning/shared/services/theme_service_prefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import 'cycle_hex_decades.dart';
import 'generated/l10n.dart';
import 'home.dart';
import 'life_place.dart';
import 'provider/theme_settings.dart';
import 'settings.dart';
import 'shared/const/app_color.dart';
import 'shared/controllers/theme_controller.dart';
import 'shared/services/theme_service.dart';
import 'true_solar_time.dart';
import 'timeset_calendar.dart';
import 'qimen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // final int themeindex = sharedPreferences.getInt('theme') ?? 0;
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);
  // ignore: prefer_const_constructors

  final ThemeService themeService = ThemeServicePrefs();
  await themeService.init();

  final ThemeController themeController = ThemeController(themeService);
  await themeController.loadAll();

  runApp(ChangeNotifierProvider.value(
    value: themeController,
    child: MyApp(),
  ));
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(
      navigatorKey: _rootNavigatorKey,
      initialLocation: '/',
      routes: <RouteBase>[
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return ScaffoldWithNavBar(child: child);
          },
          routes: <RouteBase>[
            GoRoute(
              path: '/',
              builder: (BuildContext context, GoRouterState state) {
                return const Home();
              },
              routes: <RouteBase>[
                GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'settings',
                    builder: (context, state) => const Settings()),
                GoRoute(
                    parentNavigatorKey: _rootNavigatorKey,
                    path: 'cyclehexdecades',
                    builder: (context, state) => const CycleHexDecades()),
                GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: 'qimen/:date',
                  builder: (BuildContext context, GoRouterState state) {
                    final DateTime date = DateTime.parse(state.params['date']!);
                    return QiMenContent(date: date);
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/solartime',
              builder: (BuildContext context, GoRouterState state) {
                return const SolarTimeScreen();
              },
            ),
            GoRoute(
              path: '/qimen',
              builder: (BuildContext context, GoRouterState state) {
                return const QiMenContent();
              },
            ),
            GoRoute(
              path: '/lifepalace',
              builder: (BuildContext context, GoRouterState state) {
                return const Palace();
              },
            ),
            GoRoute(
              path: '/timesetcalendar',
              builder: (BuildContext context, GoRouterState state) {
                return const TimesetCalendar();
              },
            ),
          ],
        ),
      ]);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<SelectedIndex>(
              create: (context) => SelectedIndex()),
        ],
        child: Selector<ThemeController, Tuple3<ThemeData, ThemeData,ThemeMode>>(
            selector: (context, controller) =>
                Tuple3(
                  BuildThemeData.light(AppColor.customSchemes[controller.schemeIndex].light,),
                  BuildThemeData.dark(AppColor.customSchemes[controller.schemeIndex].dark),
                  controller.themeMode),
            builder: (context, theme, child) {
              return MaterialApp.router(
                routerConfig: _router,
                localizationsDelegates: const [
                  S.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: S.delegate.supportedLocales,
                title: '晨植五行学习工具',
                theme: theme.item1,
                darkTheme: theme.item2,
                themeMode: theme.item3,
              );
            }));
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration.zero, () async {
      Provider.of<SelectedIndex>(context, listen: false).index =
          _calculateSelectedIndex(context);
    });

    return Scaffold(
      body: child,
      bottomNavigationBar:
          Consumer<SelectedIndex>(builder: (context, selected, child) {
        return NavigationBar(
          selectedIndex: selected.index,
          onDestinationSelected: (int idx) {
            selected.index = idx;
            _onItemTapped(idx, context);
          },
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: S.of(context).homeTitle,
            ),
            NavigationDestination(
              icon: const Icon(Icons.business),
              label: S.of(context).solarTimeTitle,
            ),
            NavigationDestination(
              icon: const Icon(Icons.notification_important_rounded),
              label: S.of(context).qimenTitle,
            ),
            NavigationDestination(
              icon: const Icon(Icons.notification_important_rounded),
              label: S.of(context).lifePalaceTitle,
            ),
            NavigationDestination(
              icon: const Icon(Icons.notification_important_rounded),
              label: S.of(context).timesetTitle,
            ),
          ],
        );
      }),
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).location;
    // if (location.startsWith('/')) {
    //   return 0;
    // }
    if (location.startsWith('/solartime')) {
      return 1;
    }
    if (location.startsWith('/qimen')) {
      return 2;
    }
    if (location.startsWith('/lifepalace')) {
      return 3;
    }
    if (location.startsWith('/timesetcalendar')) {
      return 4;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go('/solartime');
        break;
      case 2:
        GoRouter.of(context).go('/qimen');
        break;
      case 3:
        GoRouter.of(context).go('/lifepalace');
        break;
      case 4:
        GoRouter.of(context).go('/timesetcalendar');
        break;
    }
  }
}

/// The details screen for either the A, B or C screen.
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen].
  const DetailsScreen({
    required this.label,
    super.key,
  });

  /// The label to display in the center of the screen.
  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Screen'),
      ),
      body: Center(
        child: Text(
          'Details for $label',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
