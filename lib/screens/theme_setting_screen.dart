import 'package:cfm_learning/shared/controllers/theme_controller.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../shared/const/app.dart';
import '../shared/const/app_color.dart';
import '../shared/services/theme_service.dart';
import '../shared/services/theme_service_mem.dart';
import '../shared/widgets/panels/theme_color_settings/input_colors_selector.dart';
import '../shared/widgets/universal/theme_mode_switch.dart';

class ThemeSettingScreen extends StatelessWidget {
  const ThemeSettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
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
    final ThemeData theme = Theme.of(context);
    final MediaQueryData media = MediaQuery.of(context);
    final bool isNarrow = media.size.width < App.phoneWidthBreakpoint;
    final bool isCompact = Provider.of<ThemeController>(context, listen: false).compactMode;
    final bool isPhone =
        isCompact || isNarrow || media.size.height < App.phoneHeightBreakpoint;
    final double margins = App.responsiveInsets(media.size.width, isCompact);
    // final bool isDark = theme.brightness == Brightness.dark;
    return Consumer<ThemeController>(
      builder: (context, controller, child) {
        return Column(
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
            Padding(
              padding: EdgeInsets.fromLTRB(0, margins, 0, 0),
              child: InputColorsSelector(
                controller: controller,
                isPhone: isPhone,
              ),
            ),
          ],
        );
      },
    );
  }
}

class BuildThemeData {
  static ThemeData light(FlexScheme scheme) {
    return FlexThemeData.light(
      scheme: scheme,
      subThemesData: const FlexSubThemesData(
        interactionEffects: false,
        tintedDisabledControls: false,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        inputDecoratorUnfocusedBorderIsColored: false,
        tooltipRadius: 4.0,
        tooltipSchemeColor: SchemeColor.inverseSurface,
        tooltipOpacity: 0.9,
        snackBarElevation: 6.0,
        snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
        drawerWidth: 360.0,
        drawerIndicatorOpacity: 0.0,
        navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
        navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
        navigationBarMutedUnselectedLabel: false,
        navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
        navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
        navigationBarMutedUnselectedIcon: false,
        navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationBarIndicatorOpacity: 1.00,
        navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
        navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
        navigationRailMutedUnselectedLabel: false,
        navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
        navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
        navigationRailMutedUnselectedIcon: false,
        navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationRailIndicatorOpacity: 1.00,
        navigationRailBackgroundSchemeColor: SchemeColor.surface,
        navigationRailLabelType: NavigationRailLabelType.none,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
  }

  static ThemeData dark(FlexScheme scheme) {
    return FlexThemeData.dark(
      scheme: scheme,
      subThemesData: const FlexSubThemesData(
        interactionEffects: false,
        tintedDisabledControls: false,
        inputDecoratorBorderType: FlexInputBorderType.underline,
        inputDecoratorUnfocusedBorderIsColored: false,
        tooltipRadius: 4.0,
        tooltipSchemeColor: SchemeColor.inverseSurface,
        tooltipOpacity: 0.9,
        snackBarElevation: 6.0,
        snackBarBackgroundSchemeColor: SchemeColor.inverseSurface,
        drawerWidth: 360.0,
        drawerIndicatorOpacity: 0.0,
        navigationBarSelectedLabelSchemeColor: SchemeColor.onSurface,
        navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
        navigationBarMutedUnselectedLabel: false,
        navigationBarSelectedIconSchemeColor: SchemeColor.onSurface,
        navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
        navigationBarMutedUnselectedIcon: false,
        navigationBarIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationBarIndicatorOpacity: 1.00,
        navigationRailSelectedLabelSchemeColor: SchemeColor.onSurface,
        navigationRailUnselectedLabelSchemeColor: SchemeColor.onSurface,
        navigationRailMutedUnselectedLabel: false,
        navigationRailSelectedIconSchemeColor: SchemeColor.onSurface,
        navigationRailUnselectedIconSchemeColor: SchemeColor.onSurface,
        navigationRailMutedUnselectedIcon: false,
        navigationRailIndicatorSchemeColor: SchemeColor.secondaryContainer,
        navigationRailIndicatorOpacity: 1.00,
        navigationRailBackgroundSchemeColor: SchemeColor.surface,
        navigationRailLabelType: NavigationRailLabelType.none,
      ),
      keyColors: const FlexKeyColors(),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      // To use the Playground font, add GoogleFonts package and uncomment
      // fontFamily: GoogleFonts.notoSans().fontFamily,
    );
// If you do not have a themeMode switch, uncomment this line
// to let the device system mode control the theme mode:
// themeMode: ThemeMode.system,
  }
}
