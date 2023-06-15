// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Learn traditional Chinese culture`
  String get appTitle {
    return Intl.message(
      'Learn traditional Chinese culture',
      name: 'appTitle',
      desc: '',
      args: [],
    );
  }

  /// `HOME`
  String get homeTitle {
    return Intl.message(
      'HOME',
      name: 'homeTitle',
      desc: '',
      args: [],
    );
  }

  /// `QIMEN`
  String get qimenTitle {
    return Intl.message(
      'QIMEN',
      name: 'qimenTitle',
      desc: '',
      args: [],
    );
  }

  /// `LIFE PALACE`
  String get lifePalaceTitle {
    return Intl.message(
      'LIFE PALACE',
      name: 'lifePalaceTitle',
      desc: '',
      args: [],
    );
  }

  /// `CYCLE HEX DECADES`
  String get cycleTitle {
    return Intl.message(
      'CYCLE HEX DECADES',
      name: 'cycleTitle',
      desc: '',
      args: [],
    );
  }

  /// `TRUE SOLAR TIME`
  String get solarTimeTitle {
    return Intl.message(
      'TRUE SOLAR TIME',
      name: 'solarTimeTitle',
      desc: '',
      args: [],
    );
  }

  /// `STEM AND ROOT`
  String get timesetTitle {
    return Intl.message(
      'STEM AND ROOT',
      name: 'timesetTitle',
      desc: '',
      args: [],
    );
  }

  /// `SETTINGS`
  String get settingTitle {
    return Intl.message(
      'SETTINGS',
      name: 'settingTitle',
      desc: '',
      args: [],
    );
  }

  /// `ABOUT`
  String get aboutTitle {
    return Intl.message(
      'ABOUT',
      name: 'aboutTitle',
      desc: '',
      args: [],
    );
  }

  /// `Stem`
  String get stem {
    return Intl.message(
      'Stem',
      name: 'stem',
      desc: '',
      args: [],
    );
  }

  /// `Root`
  String get root {
    return Intl.message(
      'Root',
      name: 'root',
      desc: '',
      args: [],
    );
  }

  /// `Life Palace`
  String get lifePalace {
    return Intl.message(
      'Life Palace',
      name: 'lifePalace',
      desc: '',
      args: [],
    );
  }

  /// `The author is lazy and keeps the default page of this project, maybe we can add something here in the future.`
  String get homeDescribe {
    return Intl.message(
      'The author is lazy and keeps the default page of this project, maybe we can add something here in the future.',
      name: 'homeDescribe',
      desc: '',
      args: [],
    );
  }

  /// `Refresh Question`
  String get refreshQuestion {
    return Intl.message(
      'Refresh Question',
      name: 'refreshQuestion',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Get current location`
  String get tooltipGetLocation {
    return Intl.message(
      'Get current location',
      name: 'tooltipGetLocation',
      desc: '',
      args: [],
    );
  }

  /// `Missing location...`
  String get getLocationHint {
    return Intl.message(
      'Missing location...',
      name: 'getLocationHint',
      desc: '',
      args: [],
    );
  }

  /// `Calculate`
  String get calculateButton {
    return Intl.message(
      'Calculate',
      name: 'calculateButton',
      desc: '',
      args: [],
    );
  }

  /// `Latitude`
  String get latitudeLabel {
    return Intl.message(
      'Latitude',
      name: 'latitudeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Longitude`
  String get longitudeLabel {
    return Intl.message(
      'Longitude',
      name: 'longitudeLabel',
      desc: '',
      args: [],
    );
  }

  /// `Time Zone`
  String get timeZoneLabel {
    return Intl.message(
      'Time Zone',
      name: 'timeZoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `EOT`
  String get equationOfTimeText {
    return Intl.message(
      'EOT',
      name: 'equationOfTimeText',
      desc: '',
      args: [],
    );
  }

  /// `TST`
  String get solarTimeText {
    return Intl.message(
      'TST',
      name: 'solarTimeText',
      desc: '',
      args: [],
    );
  }

  /// `GTD`
  String get geographicalTimeDifferenceText {
    return Intl.message(
      'GTD',
      name: 'geographicalTimeDifferenceText',
      desc: '',
      args: [],
    );
  }

  /// `Lunar`
  String get lunarText {
    return Intl.message(
      'Lunar',
      name: 'lunarText',
      desc: '',
      args: [],
    );
  }

  /// `Timeset`
  String get timesetText {
    return Intl.message(
      'Timeset',
      name: 'timesetText',
      desc: '',
      args: [],
    );
  }

  /// `Year Stem`
  String get yearStemText {
    return Intl.message(
      'Year Stem',
      name: 'yearStemText',
      desc: '',
      args: [],
    );
  }

  /// `Year Root`
  String get yearRootText {
    return Intl.message(
      'Year Root',
      name: 'yearRootText',
      desc: '',
      args: [],
    );
  }

  /// `Month Stem`
  String get monthStemText {
    return Intl.message(
      'Month Stem',
      name: 'monthStemText',
      desc: '',
      args: [],
    );
  }

  /// `Month Root`
  String get monthRootText {
    return Intl.message(
      'Month Root',
      name: 'monthRootText',
      desc: '',
      args: [],
    );
  }

  /// `Day Stem`
  String get dayStemText {
    return Intl.message(
      'Day Stem',
      name: 'dayStemText',
      desc: '',
      args: [],
    );
  }

  /// `Day Root`
  String get dayRootText {
    return Intl.message(
      'Day Root',
      name: 'dayRootText',
      desc: '',
      args: [],
    );
  }

  /// `Time Stem`
  String get hourStemText {
    return Intl.message(
      'Time Stem',
      name: 'hourStemText',
      desc: '',
      args: [],
    );
  }

  /// `Time Root`
  String get hourRootText {
    return Intl.message(
      'Time Root',
      name: 'hourRootText',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get gongliText {
    return Intl.message(
      'Date',
      name: 'gongliText',
      desc: '',
      args: [],
    );
  }

  /// `Summary`
  String get summaryText {
    return Intl.message(
      'Summary',
      name: 'summaryText',
      desc: '',
      args: [],
    );
  }

  /// `Detail`
  String get detilText {
    return Intl.message(
      'Detail',
      name: 'detilText',
      desc: '',
      args: [],
    );
  }

  /// `【Timesets Tips】`
  String get timesetTipsText {
    return Intl.message(
      '【Timesets Tips】',
      name: 'timesetTipsText',
      desc: '',
      args: [],
    );
  }

  /// `Xun Shou`
  String get SOATDP {
    return Intl.message(
      'Xun Shou',
      name: 'SOATDP',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
