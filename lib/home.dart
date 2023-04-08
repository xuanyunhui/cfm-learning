import 'package:flutter/material.dart';

import 'drawerbuilder.dart';
import 'generated/l10n.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

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
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text(S.of(context).homeTitle),
      ),
      body: Center(
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
            Text('${Localizations.of<MaterialLocalizations>(context, MaterialLocalizations)!.formatFullDate(DateTime.now())}.'),
            Text(
              S.of(context).homeDescribe,
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