import 'dart:math';
import 'package:timezone/timezone.dart';

class SolarTime {
  static const double degreeInMicroseconds = 4 * 60 * 1000000;

  static const Duration dayLightSavingTimeOffset = Duration(hours: -1);

  final TZDateTime _date;

  /// The latitude of this position in degrees normalized to the interval -90.0
  /// to +90.0 (both inclusive).
  final double latitude;

  /// The longitude of the position in degrees normalized to the interval -180
  /// (exclusive) to +180 (inclusive).
  final double longitude;


  SolarTime(this._date, this.latitude, this.longitude);

  // DateTime get localSolarTime => _calculateLocalSolarTime();

  Duration get equationOfTime => _calculateEquationOfTime();

  Duration get geoTimeDifference => _geoTimeDifference();

  TZDateTime get localSolarTime {

    Duration deltaT = Duration(
        microseconds: _calculateEquationOfTime().inMicroseconds +
            _calculateLongitudeOffset().inMicroseconds);

    return TZDateTime.from(_date.add(deltaT), _date.location).toLocal();
  }

  int _getDayOfYear(DateTime date) {
    final diff = date.difference(DateTime(date.year, 1, 1));
    return diff.inDays + 1;
  }

  Duration _calculateEquationOfTime() {
    int d = _getDayOfYear(_date);
    // double b = 360 / 364 * (d - 81) * pi / 180;
    double b = 2 * pi * (d - 81) / 365;
    double e = 9.87 * sin(2 * b) - 7.53 * cos(b) - 1.5 * sin(b);
    Duration equation = Duration(microseconds: (e * 60 * 1000 * 1000).floor());
    return equation;
  }

  Duration _geoTimeDifference() {
    return  Duration(microseconds: _calculateLongitudeOffset().inMicroseconds - _date.timeZoneOffset.inMicroseconds);
  }

  //Make funcation to calculate the time offset from the longitude
  Duration _calculateLongitudeOffset() {
    return Duration(seconds: (longitude * 4 * 60).floor());
  }
}
