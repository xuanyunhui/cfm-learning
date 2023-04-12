import 'dart:math';

import 'package:flutter/material.dart';

IconData randomEighthNoteIcon() {
    final random = Random();
    final note = random.nextInt(8);
    switch (note) {
      case 0:
        return const IconData(0x2630, fontFamily: 'MaterialIcons');
      case 1:
        return const IconData(0x2631, fontFamily: 'MaterialIcons');
      case 2:
        return const IconData(0x2632, fontFamily: 'MaterialIcons');
      case 3:
        return const IconData(0x2633, fontFamily: 'MaterialIcons');
      case 4:
        return const IconData(0x2634, fontFamily: 'MaterialIcons');
      case 5:
        return const IconData(0x2635, fontFamily: 'MaterialIcons');
      case 6:
        return const IconData(0x2636, fontFamily: 'MaterialIcons');
      case 7:
        return const IconData(0x2637, fontFamily: 'MaterialIcons');
      default:
        return const IconData(0x2630, fontFamily: 'MaterialIcons');
    }
  }