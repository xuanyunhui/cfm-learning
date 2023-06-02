import 'dart:typed_data';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lunar/lunar.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart' show Share;
import 'package:timezone/data/latest.dart';

import 'package:timezone/timezone.dart';
// import 'package:timezone/data/latest.dart' as tz;

import 'data/icon_data.dart';
import 'extensions/datetime_extensions.dart';
import '../generated/l10n.dart';
import 'timeset_widget.dart';
import 'drawerbuilder.dart';
import 'solar_time.dart';
// import 'package:timezone/browser.dart' as tz;

// Future<void> setup() async {
//   await tz.initializeTimeZone();
//   // var detroit = tz.getLocation('America/Detroit');
//   // var now = tz.TZDateTime.now(detroit);
//   tz.timeZoneDatabase.locations.forEach((key, value) {
//     print(key);
//   });
// }

class SolarTimeScreen extends StatefulWidget {
  const SolarTimeScreen({super.key});

  @override
  State<SolarTimeScreen> createState() => _SolarTimeState();
}

class _SolarTimeState extends State<SolarTimeScreen> {
  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;

  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();

  String currentTimeZone = 'Asia/Macau';

  LocationNotifier location = LocationNotifier();

  final ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    initializeTimeZones();
    _initData();
    super.initState();
  }

  Future<void> _initData() async {
    try {
      currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
    } catch (e) {
      debugPrint('Could not get the local timezone');
    }

    _determinePosition().then((Position position) {
      location.position.value = position;
      _latitudeController.text = position.latitude.toString();
      _longitudeController.text = position.longitude.toString();
    }).catchError((Object error) {
      debugPrint(error.toString());
    });

    dateController.text = DateFormat.yMMMMd('zh').format(DateTime.now());
    timeController.text = DateFormat.Hm('zh').format(DateTime.now());
    location.location.value = getLocation(currentTimeZone);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;
    final Locale locale = Localizations.localeOf(context);
    final String languageCode = Localizations.localeOf(context).languageCode;

    final List<DropdownMenuItem<Location>> locations =
        <DropdownMenuItem<Location>>[];
    if (timeZoneDatabase.isInitialized) {
      timeZoneDatabase.locations.forEach((String key, Location value) {
        locations
            .add(DropdownMenuItem<Location>(value: value, child: Text(key)));
      });
    }

    DateTime pickedDateTime = DateTime.now();

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).solarTimeTitle),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.share),
              onPressed: () async {
                final Uint8List? imageInUnit8List = await screenshotController.capture();
                final XFile file = XFile.fromData(imageInUnit8List!);
                await Share.shareXFiles([file], text: "真太阳时");
              },
            ),
            ]
        ),
        drawer: const NavigationDrawerBuilder(),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            FloatingActionButton.small(
              onPressed: () {
                _determinePosition().then((Position position) {
                  _latitudeController.text = position.latitude.toString();
                  _longitudeController.text = position.longitude.toString();
                }).catchError((Object error) {
                  debugPrint(error.toString());
                });
              },
              tooltip: S.of(context).tooltipGetLocation,
              child: const Icon(Icons.my_location),
            ),
            const SizedBox(
              height: 10,
            ),
            FloatingActionButton.extended(
              onPressed: () {
                if (_latitudeController.text.isEmpty ||
                    _longitudeController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(S.of(context).getLocationHint),
                    ),
                  );
                  return;
                }
                location.solartime.value = SolarTime(
                    TZDateTime(
                        location.location.value!,
                        pickedDateTime.year,
                        pickedDateTime.month,
                        pickedDateTime.day,
                        pickedDateTime.hour,
                        pickedDateTime.minute),
                    double.parse(_latitudeController.text),
                    double.parse(_longitudeController.text));
              },
              tooltip: '计算真太阳时',
              label: Text(S.of(context).calculateButton),
              icon: const Icon(Icons.calculate),
              heroTag: null,
            ),
          ],
        ),
        body: Screenshot(
          controller: screenshotController,
          child: Container(
            color: Theme.of(context).colorScheme.background,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                          controller:
                              dateController, //editing controller of this TextField
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: S.of(context).date,
                            isDense: true,
                          ),
                          readOnly: true, // when true user cannot edit text
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                                locale: locale,
                                context: context,
                                initialDate: pickedDateTime, //get today's date
                                firstDate: DateTime(
                                    1800), //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2101));
                            if (pickedDate != null) {
                              dateController.text =
                                  DateFormat.yMMMMd(languageCode)
                                      .format(pickedDate);
                              // setState(() {
                              pickedDateTime =
                                  pickedDateTime.setDate(pickedDate);
                              // });
                            }
                          }),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                          controller:
                              timeController, //editing controller of this TextField
                          decoration: InputDecoration(
                              border: const OutlineInputBorder(),
                              labelText: S.of(context).time,
                              isDense: true),
                          readOnly: true, // when true user cannot edit text
                          onTap: () async {
                            TimeOfDay? pickedTime = await showTimePicker(
                              context: context,
                              initialTime:
                                  TimeOfDay.fromDateTime(pickedDateTime),
                            );
                            if (pickedTime != null) {
                              timeController.text =
                                  "${pickedTime.hour}:${pickedTime.minute}";
                              // setState(() {
                              pickedDateTime =
                                  pickedDateTime.setTimeOfDay(pickedTime);
                              // });
                            }
                          }),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _latitudeController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: S.of(context).latitudeLabel,
                            isDense: true),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: TextField(
                        controller: _longitudeController,
                        decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: S.of(context).longitudeLabel,
                            isDense: true),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                DropdownButtonFormField<Location>(
                  // controller: pala,
                  // enableFilter: true,
                  // leadingIcon: const Icon(Icons.search),
                  value: location.location.value,
                  items: locations,
                  // inputDecorationTheme:
                  //     const InputDecorationTheme(filled: true),
                  onChanged: (Location? tLocation) {
                    location.location.value = tLocation!;
                  },
                  decoration: InputDecoration(
                      labelText: S.of(context).timeZoneLabel,
                      border: const OutlineInputBorder(),
                      isDense: true),
                ),
                const Divider(),
                Card(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: ValueListenableBuilder<SolarTime?>(
                    valueListenable: location.solartime,
                    builder: (context, SolarTime? value, Widget? child) {
                      return Column(
                        children: [
                          ListTile(
                            leading:
                                Text("${S.of(context).equationOfTimeText}:"),
                            title: Text(value != null
                                ? formatDuration(value.equationOfTime)
                                : ""),
                          ),
                          ListTile(
                            leading: Text(
                                "${S.of(context).geographicalTimeDifferenceText}:"),
                            title: Text(value != null
                                ? formatDuration(value.geoTimeDifference)
                                : ""),
                          ),
                          ListTile(
                              leading: Text("${S.of(context).solarTimeText}:"),
                              title: Text(value != null
                                  ? DateFormat('y/MM/dd HH:mm:ss')
                                      .format(value.localSolarTime)
                                  : ""),
                              trailing: value != null
                                  ? IconButton(
                                      alignment: Alignment.topCenter,
                                      padding: EdgeInsets.zero,
                                      icon: Icon(
                                        randomEighthNoteIcon(),
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        context.push(
                                          "/qimen/${value.localSolarTime.toIso8601String()}",
                                        );
                                      },
                                      style: IconButton.styleFrom(
                                        foregroundColor:
                                            colors.onSecondaryContainer,
                                        backgroundColor:
                                            colors.secondaryContainer,
                                        disabledBackgroundColor:
                                            colors.onSurface.withOpacity(0.12),
                                        hoverColor: colors.onSecondaryContainer
                                            .withOpacity(0.08),
                                        focusColor: colors.onSecondaryContainer
                                            .withOpacity(0.12),
                                        highlightColor: colors
                                            .onSecondaryContainer
                                            .withOpacity(0.12),
                                      ),
                                    )
                                  : const Text("")
                              // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                              ),
                        ],
                      );
                    },
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: ValueListenableBuilder<SolarTime?>(
                    valueListenable: location.solartime,
                    builder: (context, SolarTime? value, Widget? child) {
                      Lunar? lunar;
                      if (value != null) {
                        lunar = Solar.fromDate(value.localSolarTime).getLunar();
                      }
                      return Column(
                        children: [
                          ListTile(
                            leading: Text("${S.of(context).lunarText}:"),
                            title: lunar != null
                                ? Text(lunar.toString())
                                : const Text(""),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Card(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: ValueListenableBuilder<SolarTime?>(
                    valueListenable: location.solartime,
                    builder: (context, SolarTime? value, Widget? child) {
                      EightChar? timeset;
                      if (value != null) {
                        timeset = Solar.fromDate(value.localSolarTime)
                            .getLunar()
                            .getEightChar();
                        timeset.setSect(1);
                      }
                      return Column(
                        children: [
                          ListTile(
                            title: Text("${S.of(context).timesetText}:"),
                            subtitle: timeset != null
                                ? TimesetWidget(timeset: timeset)
                                : const Text(""),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
        ));
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await _geolocatorPlatform.getCurrentPosition();
  }

  String formatDuration(Duration duration) {
    String twoDigitSeconds = duration.toString().split(".")[0];
    return twoDigitSeconds;
  }
}

class LocationNotifier with ChangeNotifier {
  ValueNotifier<Location?> location = ValueNotifier<Location?>(null);
  ValueNotifier<Position?> position = ValueNotifier<Position?>(null);
  ValueNotifier<SolarTime?> solartime = ValueNotifier<SolarTime?>(null);
}
