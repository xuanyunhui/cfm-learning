// switch element {
//         case "金","庚","辛","酉","申" : content
//                 .foregroundColor(Color("MetalColor"))
//         case "木","甲","乙","寅","卯": content
//                 .foregroundColor(Color("WoodColor"))
//         case "水","壬","癸","子","亥": content
//                 .foregroundColor(Color("WaterColor"))
//         case "火","丙","丁","午","巳": content
//                 .foregroundColor(Color("FireColor"))
//         case "土","戊","己","辰","戌","丑","未": content
//                 .foregroundColor(Color("EarthColor"))
//         default:


import 'package:flutter/material.dart';

Color colorOfElement(BuildContext context, String element) {
  switch (element) {
    case "金":
    case "庚":
    case "辛":
    case "酉":
    case "申":
      return const Color(0xFFD4AF37);
    case "木":
    case "甲":
    case "乙":
    case "寅":
    case "卯":
      return const Color(0xFF228B22);
    case "水":
    case "壬":
    case "癸":
    case "子":
    case "亥":
      return const Color(0xFF4682B4);
    case "火":
    case "丙":
    case "丁":
    case "午":
    case "巳":
      return const Color(0xFFB22222);
    case "土":
    case "戊":
    case "己":
    case "辰":
    case "戌":
    case "丑":
    case "未":
      return const Color(0xFF8B4513);
    default:
      return Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
  }
}