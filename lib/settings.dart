import 'package:cfm_learning/drawerbuilder.dart';
import 'package:cfm_learning/provider/theme_settings.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
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
    final List<DropdownMenuItem<FlexScheme>> colorItems =
        <DropdownMenuItem<FlexScheme>>[];
    for (final FlexScheme scheme in FlexScheme.values) {
      colorItems.add(DropdownMenuItem<FlexScheme>(
          alignment: AlignmentDirectional.center,
          value: scheme,
          child: Text(
            scheme.name,
            // selectionColor: color.color(),
            // style: TextStyle(color: FlexSchemeData.light(scheme).primary),
          )));
    }

    
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settingTitle),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: DropdownButtonFormField<FlexScheme>(
          value: FlexScheme.material,
          items: colorItems,
          onChanged: (FlexScheme? scheme) {
            if (scheme != null) {
              _setTheme(scheme.index);
            }
          },
          decoration: InputDecoration(
              labelText: S.of(context).theme,
              border: const OutlineInputBorder(),
              isDense: true),
        ),
      ),
    );
  }
}
