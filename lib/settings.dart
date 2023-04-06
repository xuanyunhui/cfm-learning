import 'package:cfm_learning/drawerbuilder.dart';
import 'package:flutter/material.dart';

import 'extensions/enum_type.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<ColorsOfYear>> colorItems =
        <DropdownMenuItem<ColorsOfYear>>[];
    for (final ColorsOfYear color in ColorsOfYear.values) {
      colorItems.add(
          DropdownMenuItem<ColorsOfYear>(
            alignment: AlignmentDirectional.center,
            value: color,
            child: Text(color.displayTitle,
            style: TextStyle(backgroundColor: color.color()),
            )
          ));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('设置'),
      centerTitle: true),
      drawer: const NavigationDrawerBuilder(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: DropdownButtonFormField<ColorsOfYear>(
                  value: ColorsOfYear.vivaMagenta,
                  items: colorItems,
                  onChanged: (ColorsOfYear? color) {
                    print(color?.color());
                  },
                  decoration: const InputDecoration(
                    labelText: 'Theme',
                    border: OutlineInputBorder(),
                    isDense: true
                  ),
                ),),
    );
  }
}

