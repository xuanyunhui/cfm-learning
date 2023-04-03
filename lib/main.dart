import 'package:cfm_learning/qimen.dart';
import 'package:flutter/material.dart';

import 'cycle_hex_decades.dart';
import 'drawerbuilder.dart';
import 'life_place.dart';
import 'true_solar_time.dart';

void main() {
  runApp(const MyApp());
}

class Routes {
  static const homePage = '/';

  static const palacePage = '/lifepalace';

  static const qimenPage = '/qimen';

  static const solarTimePage = '/solartime';

  static const cycleHexDecades = '/cyclehexdecades';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: Routes.homePage,
      routes: {
        Routes.homePage: (context) => const MyHomePage(title: 'Home Page'),
        Routes.palacePage: (context) => const Palace(),
        Routes.qimenPage: (context) => const QiMenContent(),
        Routes.solarTimePage: (context) => const SolarTimeScreen(),
        Routes.cycleHexDecades: (context) => const CycleHexDecades(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  int _counter = 0;

  int screenIndex = 0;
  late bool showNavigationDrawer;

  void handleScreenChanged(int selectedScreen) {
    setState(() {
      screenIndex = selectedScreen;
    });
  }

  void openDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '作者偷懒留着这个项目默认页面，也许未来可以加点东西到这里。',
            ),
            const Text(
              'The author is lazy and keeps the default page of this project, maybe we can add something here in the future.',
            ),
            const Text(
              'Penulis malas dan menyimpan halaman lalai projek ini, mungkin kita boleh menambah sesuatu di sini pada masa hadapan.'),
            const Text(
              'Автор ленив и держит страницу этого проекта по умолчанию, возможно, мы сможем что-то добавить сюда в будущем.'),
            const Text('ผู้เขียนขี้เกียจและเก็บหน้าเริ่มต้นสำหรับโครงการนี้ บางทีเราอาจจะเพิ่มบางอย่างที่นี่ในอนาคต'),
            const Text(
              'Der Autor ist faul und behält die Standardseite dieses Projekts, vielleicht können wir in Zukunft etwas hinzufügen.',
            ),
            const Text(
              'L\'auteur est paresseux et garde la page par défaut de ce projet, peut-être pourrons-nous ajouter quelque chose ici à l\'avenir.',
            ),
            const Text(
              'El autor es perezoso y mantiene la página predeterminada de este proyecto, tal vez podamos agregar algo aquí en el futuro.',
            ),
            const Text(
              'O autor é preguiçoso e mantém a página padrão deste projeto, talvez possamos adicionar algo aqui no futuro.',
            ),
            const SizedBox(height: 20),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
      drawer: const NavigationDrawerBuilder(),
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
