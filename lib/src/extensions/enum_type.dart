import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ColorsOfYear {
  vivaMagenta,
  veryPeri,
  illuminating,
  classicBlue,
  livingCoral,
  ultraViolet,
  timesets;
}

extension ColorExtension on ColorsOfYear {
  String get name => describeEnum(this);

  String get displayTitle {
    switch (this) {
      case ColorsOfYear.vivaMagenta:
        return 'Viva Magenta';
      case ColorsOfYear.veryPeri:
        return 'Very Peri';
      case ColorsOfYear.illuminating:
        return 'Illuminating';
      case ColorsOfYear.classicBlue:
        return 'Classic Blue';
      case ColorsOfYear.livingCoral:
        return 'Living Coral';
      case ColorsOfYear.ultraViolet:
        return 'Ultra Violet';
      case ColorsOfYear.timesets:
        return '时间码';
      default:
        return 'Viva Magenta';
    }
  }

  String get displayDescription {
    switch (this) {
      case ColorsOfYear.vivaMagenta:
        return 'Viva Magenta - Pantone\'s Color of the Year 2023';
      case ColorsOfYear.veryPeri:
        return 'Very Peri - Pantone\'s Color of the Year 2022';
      case ColorsOfYear.illuminating:
        return 'Illuminating - Pantone\'s Color of the Year 2021';
      case ColorsOfYear.classicBlue:
        return 'Classic Blue - Pantone\'s Color of the Year 2020';
      case ColorsOfYear.livingCoral:
        return 'Living Coral - Pantone\'s Color of the Year 2019';
      case ColorsOfYear.ultraViolet:
        return 'ULTRA VIOLET - Pantone\'s Color of the Year 2018';
      case ColorsOfYear.timesets:
        return '时间码的配色方案生成的Material主题';
      default:
        return 'Viva Magenta - Pantone\'s Color of the Year 2023';
    }
  }

  Color color() {
    switch (this) {
      case ColorsOfYear.vivaMagenta:
        return const Color(0xffbe3455);
      case ColorsOfYear.veryPeri:
        return const Color(0xff6667AB);
      case ColorsOfYear.illuminating:
        return const Color(0xffF5DF4D);
      case ColorsOfYear.classicBlue:
        return const Color(0xff0F4C81);
      case ColorsOfYear.livingCoral:
        return const Color(0xffff6f61);
      case ColorsOfYear.ultraViolet:
        return const Color(0xff6b5b95);
      case ColorsOfYear.timesets:
        return const Color(0xff6b5b95);
      default:
        return const Color(0xffbe3455);
    }
  }
}

Color getRandomColor() {
  Random random = Random();
  return ColorsOfYear.values[random.nextInt(ColorsOfYear.values.length)].color();
}
