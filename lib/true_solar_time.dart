import 'package:cfm_learning/extensions/datetime_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart';

import 'package:timezone/timezone.dart';
// import 'package:timezone/data/latest.dart' as tz;

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

    dateController.text = DateFormat.yMMMMd().format(DateTime.now());
    timeController.text = DateFormat.Hm().format(DateTime.now());
    location.location.value = getLocation(currentTimeZone);

    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ColorScheme colors = Theme.of(context).colorScheme;

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
          title: const Text("真太阳时"),
          centerTitle: true,
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
              tooltip: 'Get current location',
              child: const Icon(Icons.my_location),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                location.solartime.value = SolarTime(
                    TZDateTime.from(pickedDateTime, location.location.value!),
                    double.parse(_latitudeController.text),
                    double.parse(_longitudeController.text));
              },
              tooltip: 'Get current location',
              label: const Text('计算'),
              icon: const Icon(Icons.calculate),
              heroTag: null,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                        controller:
                            dateController, //editing controller of this TextField
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "日期",
                          isDense: true,
                        ),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(), //get today's date
                              firstDate: DateTime(
                                  2000), //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2101));
                          if (pickedDate != null) {
                            dateController.text =
                                DateFormat.yMMMMd().format(pickedDate);
                            // setState(() {
                            pickedDateTime = pickedDateTime.setDate(pickedDate);
                            // });
                          }
                        }),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                        controller:
                            timeController, //editing controller of this TextField
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: "时间",
                            isDense: true),
                        readOnly: true, // when true user cannot edit text
                        onTap: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
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
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Latitude',
                          isDense: true),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _longitudeController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Longitude',
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
                decoration: const InputDecoration(
                    labelText: '时区',
                    border: OutlineInputBorder(),
                    isDense: true),
              ),
              Card(
                elevation: 0,
                margin:
                    const EdgeInsets.symmetric(horizontal: 0.0, vertical: 10.0),
                color: Theme.of(context).colorScheme.surfaceVariant,
                child: ValueListenableBuilder<SolarTime?>(
                  valueListenable: location.solartime,
                  builder: (context, SolarTime? value, Widget? child) {
                    return Column(
                      children: [
                        ListTile(
                          leading: const Text('均时差：'),
                          title: Text(value != null
                              ? formatDuration(value.equationOfTime)
                              : ""),
                        ),
                        ListTile(
                          leading: const Text('地理时差：'),
                          title:
                              Text(value != null
                              ? formatDuration(value.geoTimeDifference)
                              : ""),
                        ),
                        ListTile(
                          leading: const Text('真太阳时：'),
                          title: Text(value != null
                              ? DateFormat('y/M/d h:m:s')
                                  .format(value.localSolarTime)
                              : ""),
                          // subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
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