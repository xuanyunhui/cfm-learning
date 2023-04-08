import 'package:cfm_learning/drawerbuilder.dart';
import 'package:cfm_learning/provider/theme_settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'extensions/enum_type.dart';
import 'generated/l10n.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  void _setTheme(int index) async {
    final settings = Provider.of<ThemeSettings>(context, listen: false);
    settings.setTheme(index);
  }

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<ColorsOfYear>> colorItems =
        <DropdownMenuItem<ColorsOfYear>>[];
    for (final ColorsOfYear color in ColorsOfYear.values) {
      colorItems.add(DropdownMenuItem<ColorsOfYear>(
          alignment: AlignmentDirectional.center,
          value: color,
          child: Text(
            color.displayTitle,
            selectionColor: color.color(),
            style: TextStyle(color: color.color()),
          )));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settingTitle),
        centerTitle: true,
        ),
      drawer: const NavigationDrawerBuilder(),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: DropdownButtonFormField<ColorsOfYear>(
          value: ColorsOfYear.vivaMagenta,
          items: colorItems,
          onChanged: (ColorsOfYear? color) {
            if (color != null) {
              _setTheme(color.index);
            }
          },
          decoration: InputDecoration(
              labelText: S.of(context).theme, border: const OutlineInputBorder(), isDense: true),
        ),
      ),
    );
  }
}
