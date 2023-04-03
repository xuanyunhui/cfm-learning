import 'package:flutter/material.dart';
import 'package:lunar/lunar.dart';

extension DateTimeExtension on DateTime {

  DateTime setDate(DateTime date) {
    return DateTime(date.year, date.month, date.day, hour, minute, second);
  }
  
  DateTime setTimeOfDay(TimeOfDay time) {
    return DateTime(year, month, day, time.hour, time.minute);
  }

  DateTime setTime(
      {int hours = 0,
      int minutes = 0,
      int seconds = 0,
      int milliSeconds = 0,
      int microSeconds = 0}) {
    return DateTime(
        year, month, day, hours, minutes, seconds, milliSeconds, microSeconds);
  }

  DateTime clearTime() {
    return DateTime(year, month, day, 0, 0, 0, 0, 0);
  }

  ///..... add more methods/properties for your convenience
}

extension LunarExtension on Lunar {
  Lunar setDate(DateTime date) {
    return Lunar.fromYmdHms(
        date.year, date.month, date.day, getHour(), getMinute(), getSecond());
  }

  Lunar setTimeOfDay(TimeOfDay time) {
    return Lunar.fromYmdHms(
        getYear(), getMonth(), getDay(), time.hour, time.minute, getSecond());
  }
}

extension SolarExtension on Solar {
  Solar setDate(DateTime date) {
    return Solar.fromYmdHms(
        date.year, date.month, date.day, getHour(), getMinute(), getSecond());
  }

  Solar setTimeOfDay(TimeOfDay time) {
    return Solar.fromYmdHms(
        getYear(), getMonth(), getDay(), time.hour, time.minute, getSecond());
  }
}