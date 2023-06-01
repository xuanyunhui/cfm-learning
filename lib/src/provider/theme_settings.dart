import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../themes/timesets-app/custom_color.g.dart';

class ThemeSettings extends ChangeNotifier {
  int _index = 0;

  int get index => _index;

  ThemeSettings() {
    persistent();
  }

  set index(int index) {
    _index = index;
    notifyListeners();
  }

  void setTheme(int index) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _index =
        await sharedPreferences.setInt('theme', index).then((bool success) {
      return index;
    });
    notifyListeners();
  }

  ThemeData getlightColorScheme() {
    return FlexThemeData.light(
      scheme: FlexScheme.values[_index],
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      useMaterial3ErrorColors: true,
      lightIsWhite: false,
      appBarElevation: 0.5,
      appBarOpacity: 0.94,
      transparentStatusBar: true,
      tabBarStyle: FlexTabBarStyle.forAppBar,
      surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
      blendLevel: 20,
      tooltipsMatchBackground: true,
      fontFamily: GoogleFonts.notoSans().fontFamily,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 53),
        displayMedium: TextStyle(fontSize: 41),
        displaySmall: TextStyle(fontSize: 36),
        labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.5),
      ),
      primaryTextTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 53),
        displayMedium: TextStyle(fontSize: 41),
        displaySmall: TextStyle(fontSize: 36),
        labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.5),
      ),
      keyColors: const FlexKeyColors(
        useKeyColors: false, // <-- set to true enable M3 seeded ColorScheme.
        useSecondary: true,
        useTertiary: true,
        keepPrimary:
            false, // <-- Keep defined value, do not use the seeded result.
        keepPrimaryContainer: false,
        keepSecondary: false,
        keepSecondaryContainer: false,
        keepTertiary: false,
        keepTertiaryContainer: false,
      ),
      tones: FlexTones.material(Brightness.light),
      subThemesData: _subThemesData,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      platform: defaultTargetPlatform,
      typography: Typography.material2021(
          platform: defaultTargetPlatform,
        ),
      extensions: <ThemeExtension<dynamic>>{
          lightBrandTheme,
        },
    );
    // switch (_index) {
    //   case 0:
    //     return generateColorScheme(ColorsOfYear.vivaMagenta.color(), false);
    //   case 1:
    //     return generateColorScheme(ColorsOfYear.veryPeri.color(), false);
    //   case 2:
    //     return generateColorScheme(ColorsOfYear.illuminating.color(), false);
    //   case 3:
    //     return generateColorScheme(ColorsOfYear.classicBlue.color(), false);
    //   case 4:
    //     return generateColorScheme(ColorsOfYear.livingCoral.color(), false);
    //   case 5:
    //     return generateColorScheme(ColorsOfYear.ultraViolet.color(), false);
    //   case 6:
    //     return timesetsLightColorScheme;
    //   default:
    //     return timesetsLightColorScheme;
    // }
  }

  ThemeData getdarkColorScheme() {
    return FlexThemeData.dark(
      scheme: FlexScheme.values[_index],
      useMaterial3: true,
      swapLegacyOnMaterial3: true,
      useMaterial3ErrorColors: true,
      darkIsTrueBlack: false,
      appBarElevation: 0.5,
      appBarOpacity: 0.94,
      transparentStatusBar: true,
      tabBarStyle: FlexTabBarStyle.forAppBar,
      surfaceMode: FlexSurfaceMode.highBackgroundLowScaffold,
      blendLevel: 20,
      tooltipsMatchBackground: true,
      fontFamily: GoogleFonts.notoSans().fontFamily,
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 53),
        displayMedium: TextStyle(fontSize: 41),
        displaySmall: TextStyle(fontSize: 36),
        labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.5),
      ),
      primaryTextTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 53),
        displayMedium: TextStyle(fontSize: 41),
        displaySmall: TextStyle(fontSize: 36),
        labelSmall: TextStyle(fontSize: 11, letterSpacing: 0.5),
      ),
      keyColors: const FlexKeyColors(
        useKeyColors: false, // <-- set to true enable M3 seeded ColorScheme.
        useSecondary: true,
        useTertiary: true,
        keepPrimary:
            false, // <-- Keep defined value, do not use the seeded result.
        keepPrimaryContainer: false,
        keepSecondary: false,
        keepSecondaryContainer: false,
        keepTertiary: false,
        keepTertiaryContainer: false,
      ),
      tones: FlexTones.material(Brightness.dark),
      subThemesData: _subThemesData,
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      platform: defaultTargetPlatform,
      typography: Typography.material2021(
          platform: defaultTargetPlatform,
        ),
      extensions: <ThemeExtension<dynamic>>{
          darkBrandTheme,
        },
    );
    // switch (_index) {
    //   case 0:
    //     return generateColorScheme(ColorsOfYear.vivaMagenta.color(), true);
    //   case 1:
    //     return generateColorScheme(ColorsOfYear.veryPeri.color(), true);
    //   case 2:
    //     return generateColorScheme(ColorsOfYear.illuminating.color(), true);
    //   case 3:
    //     return generateColorScheme(ColorsOfYear.classicBlue.color(), true);
    //   case 4:
    //     return generateColorScheme(ColorsOfYear.livingCoral.color(), true);
    //   case 5:
    //     return generateColorScheme(ColorsOfYear.ultraViolet.color(), true);
    //   case 6:
    //     return timesetsDarkColorScheme;
    //   default:
    //     return timesetsDarkColorScheme;
    // }
  }

  getLightCustomColors() {
    switch (_index) {
      case 0:
        return timesetsLightCustomColors;
      default:
        return timesetsLightCustomColors;
    }
  }

  getDarkCustomColors() {
    switch (_index) {
      case 0:
        return timesetsDarkCustomColors;
      default:
        return timesetsDarkCustomColors;
    }
  }

  generateColorScheme(Color color, bool isDark) {
    return isDark
        ? ColorScheme.fromSeed(seedColor: color, brightness: Brightness.dark)
        : ColorScheme.fromSeed(seedColor: color, brightness: Brightness.light);
  }

  persistent() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    _index = sharedPreferences.getInt('theme') ?? 0;
    notifyListeners();
  }
}


const FlexSubThemesData _subThemesData = FlexSubThemesData(
  // Opt in for themed hover, focus, highlight and splash effects.
  // New buttons use primary themed effects by default, this setting makes
  // the general ThemeData hover, focus, highlight and splash match that.
  // True by default when opting in on sub themes, but you can turn it off.
  interactionEffects: true,

  // When it is null = undefined, the sub themes will use their default style
  // behavior that aims to follow new Material 3 (M3) standard for all widget
  // corner radius. Current Flutter SDK corner radius is 4, as defined by
  // the Material 2 design guide. M3 uses much higher corner radius, and it
  // varies by widget type.
  //
  // When you set [defaultRadius] to a value, it will override these defaults
  // with this global default. You can still set and lock each individual
  // border radius back for these widget sub themes to some specific value, or
  // to its Material3 standard, which is mentioned in each theme as the used
  // default when its value is null.
  //
  // Set global corner radius. Default is null, resulting in M3 styles, but make
  // it whatever you like, even 0 for a hip to be square style.
  defaultRadius: null,
  // You can also override individual corner radius for each sub-theme to make
  // it different from the global `cornerRadius`. Here eg. the bottom sheet
  // radius is defined to always be 24:
  bottomSheetRadius: 24,

  // Use the Material 3 like text theme. Defaults to true.
  useTextTheme: true,

  // Select input decorator type, only SDK options outline and underline
  // supported no, but custom ones may be added later.
  inputDecoratorBorderType: FlexInputBorderType.outline,
  // For a primary color tinted background on the input decorator set to true.
  inputDecoratorIsFilled: true,
  // If you do not want any underline/outline on the input decorator when it is
  // not in focus, then set this to false.
  inputDecoratorUnfocusedHasBorder: false,
  // Select the ColorScheme color used for input decoration border.
  // Primary is default so no need to set that, used here as placeholder to
  // enable easy selection of other options.
  inputDecoratorSchemeColor: SchemeColor.primary,
  // Set some alpha channel opacity value input decorator.
  inputDecoratorBackgroundAlpha: 20,

  // Some FAB (Floating Action Button) settings.
  //
  // // If fabUseShape is false, no shape will be added to FAB theme, it will get
  // // whatever default shape the widget default behavior applies.
  // //
  // fabUseShape: false,
  // //
  // // Select the ColorScheme color used by FABs as their base/background color
  // // Secondary is default so no need to set that, used here as placeholder to
  // // enable easy selection of other options.
  // //
  // fabSchemeColor: SchemeColor.secondaryContainer,

  // Select the ColorScheme color used by Chips as their base color
  // Primary is default so no need to set that, used here as placeholder to
  // enable easy selection of other options.
  chipSchemeColor: SchemeColor.primary,

  // Elevations have easy override values as well.
  elevatedButtonElevation: 1,
  // Widgets that use outline borders can be easily adjusted via these
  // properties, they affect the outline input decorator, outlined button and
  // toggle buttons.
  thickBorderWidth: 1.5, // Default is 2.0.
  thinBorderWidth: 1, // Default is 1.0.

  // Select the ColorScheme color used for selected TabBar indicator.
  // Defaults to same color as selected tab if not defined.
  // tabBarIndicatorSchemeColor: SchemeColor.secondary,

  // Select the ColorScheme color used for selected bottom navigation bar item.
  // Primary is default so no need to set that, used here as placeholder to
  // enable easy selection of other options.
  bottomNavigationBarSelectedLabelSchemeColor: SchemeColor.primary,

  // Select the ColorScheme color used for bottom navigation bar background.
  // Background is default so no need to set that, provided here as placeholder
  // to enable easy selection of other options.
  bottomNavigationBarBackgroundSchemeColor: SchemeColor.background,

  // Below are some example quick override properties that you can use on the
  // M3 based NavigationBar. The section is double commented out, so it its
  // easy to uncomment to try them all.
  //
  // // SchemeColor based color for [NavigationBar]'s selected item icon.
  // // navigationBarSelectedIconSchemeColor: SchemeColor.tertiary,
  // // SchemeColor based color for [NavigationBar]'s selected item label.
  // navigationBarSelectedLabelSchemeColor: SchemeColor.tertiary,
  // // SchemeColor based color for [NavigationBar]'s unselected item icons.
  // navigationBarUnselectedIconSchemeColor: SchemeColor.onSurface,
  // // SchemeColor based color for [NavigationBar]'s unselected item icons.
  // navigationBarUnselectedLabelSchemeColor: SchemeColor.onSurface,
  // // SchemeColor based color for [NavigationBar]'s selected item highlight.
  // navigationBarIndicatorSchemeColor: SchemeColor.tertiaryContainer,
  // // If you use suitable M3 designed container color for the indicator, it
  // // does not need any opacity.
  // navigationBarIndicatorOpacity: 1,
  // // Select the ColorScheme color used for [NavigationBar]'s background.
  // navigationBarBackgroundSchemeColor: SchemeColor.background,
  // // When set to true [NavigationBar] unselected icons use a more muted
  // // version of color defined by [navigationBarUnselectedIconSchemeColor].
  // navigationBarMutedUnselectedIcon: true,
  // // When set to true [NavigationBar] unselected labels use a more muted
  // // version of color defined by [navigationBarUnselectedLabelSchemeColor].
  // navigationBarMutedUnselectedLabel: true,
  // // Set size of labels.
  // navigationBarSelectedLabelSize: 12,
  // navigationBarUnselectedLabelSize: 10,
  // // Set the size of icons icons.
  // navigationBarSelectedIconSize: 26,
  // navigationBarUnselectedIconSize: 22,
);

class BrandTheme extends ThemeExtension<BrandTheme> {
  const BrandTheme({
    this.brandColor,
  });
  final Color? brandColor;

  // You must override the copyWith method.
  @override
  BrandTheme copyWith({
    Color? brandColor,
  }) =>
      BrandTheme(
        brandColor: brandColor ?? this.brandColor,
      );

  // You must override the lerp method.
  @override
  BrandTheme lerp(ThemeExtension<BrandTheme>? other, double t) {
    if (other is! BrandTheme) {
      return this;
    }
    return BrandTheme(
      brandColor: Color.lerp(brandColor, other.brandColor, t),
    );
  }
}

const BrandTheme lightBrandTheme = BrandTheme(
  brandColor: Color.fromARGB(255, 8, 79, 71),
);

// Custom const theme with our brand color in dark mode.
const BrandTheme darkBrandTheme = BrandTheme(
  brandColor: Color.fromARGB(255, 167, 227, 218),
);