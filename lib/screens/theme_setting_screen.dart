import 'package:cfm_learning/shared/controllers/theme_controller.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../shared/const/app.dart';
import '../shared/widgets/universal/theme_mode_switch.dart';
import '../widgets/theme_popup_menu.dart';

class ThemeSettingScreen extends StatelessWidget {
  const ThemeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('主题设置'),
          centerTitle: true,
        ),
        body: const TimeSettingBody());
  }
}

class TimeSettingBody extends StatelessWidget {
  const TimeSettingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final MediaQueryData media = MediaQuery.of(context);
    final bool isNarrow = media.size.width < App.phoneWidthBreakpoint;
    final bool isCompact =
        Provider.of<ThemeController>(context, listen: false).compactMode;
    final bool isPhone =
        isCompact || isNarrow || media.size.height < App.phoneHeightBreakpoint;
    final double margins = App.responsiveInsets(media.size.width, isCompact);
    // final bool isDark = theme.brightness == Brightness.dark;
    return Consumer<ThemeController>(
      builder: (context, controller, child) {
        return Padding(
          padding: EdgeInsets.all(margins),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Theme mode'),
                subtitle: Text('Theme '
                    '${controller.themeMode.toString().dotTail}'),
                trailing: ThemeModeSwitch(
                  themeMode: controller.themeMode,
                  onChanged: (value) {
                    controller.setThemeMode(value);
                  },
                ),
              ),
              ThemePopupMenu(
                contentPadding: EdgeInsets.zero,
                schemeIndex: controller.schemeIndex,
                onChanged: controller.setSchemeIndex,
              ),
            ],
          ),
        );
      },
    );
  }
}

class BuildThemeData {
  static ThemeData light(FlexSchemeColor scheme) {
    return FlexThemeData.light(
      colors: scheme,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 7,
      subThemesData: const FlexSubThemesData(
        blendOnLevel: 10,
        blendOnColors: false,
        useM2StyleDividerInM3: true,
        drawerIndicatorOpacity: 0.0,
        navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
        navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
        navigationBarMutedUnselectedLabel: false,
        navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
        navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
        navigationBarMutedUnselectedIcon: false,
        navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationBarIndicatorOpacity: 1.00,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }

  static ThemeData dark(FlexSchemeColor scheme) {
    return FlexThemeData.dark(
      colors: scheme,
      surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
      blendLevel: 13,
      subThemesData: const FlexSubThemesData(
          blendOnLevel: 20,
          blendOnColors: false,
          useM2StyleDividerInM3: true,
          drawerIndicatorOpacity: 0.0,
          navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
          navigationBarMutedUnselectedLabel: false,
          navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
          navigationBarMutedUnselectedIcon: false,
          navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
          navigationBarIndicatorOpacity: 1.00),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      fontFamily: GoogleFonts.notoSans().fontFamily,
    );
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
  }
}
