import 'package:flutter/material.dart';

class PersonEditor extends StatelessWidget {
  const PersonEditor({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Person Editor'),
      ),
      body: const SingleChildScrollView(
        child: ListBody(children: <Widget>[
          Placeholder(),
          Placeholder(),
        ]),
      ),
    );
  }
}
