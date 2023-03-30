import 'package:flutter/material.dart';

class ExamModel extends ChangeNotifier {
  final int stemIndex;
  final int rootIndex;

  ExamModel({required this.stemIndex, required this.rootIndex});

  int get stem => stemIndex;

  int get root => rootIndex;

  String getPalace(StemLabel stem, RootLabel root) {
    int? offset = stem.offset;
    int index = offset + (stem.index % 2 == 0 ? root.index : -root.index);
    if (index >= 12) {
      index -= 12;
    }
    if (index < 0) {
      index += 12;
    }
    return PalaceLabel.values[index].label;
  }
  
}

enum StemLabel {
  jia('甲', 1, 1),
  yi('乙', 2, 6),
  bing('丙', 3, 10),
  ding('丁', 4, 9),
  wu('戊', 5, 10),
  ji('己', 6, 9),
  geng('庚', 7, 7),
  xin('辛', 8, 0),
  ren('壬', 9, 4),
  gui('癸', 10, 3);

  const StemLabel(this.label, this.stemIndex, this.offset);
  final String label;
  final int stemIndex;
  final int offset;
}

enum RootLabel {
  zi('子', 1),
  chou('丑', 2),
  yin('寅', 3),
  mao('卯', 4),
  chen('辰', 5),
  si('巳', 6),
  wu('午', 7),
  wei('未', 8),
  shen('申', 9),
  you('酉', 10),
  xu('戌', 11),
  hai('亥', 12);

  const RootLabel(this.label, this.rootIndex);
  final String label;
  final int rootIndex;
}

enum PalaceLabel {
  newborn('长生'),
  baptize('沐浴'),
  dressup('冠带'),
  takeoffice('临官'),
  tiptop('帝旺'),
  recess('衰'),
  sick('病'),
  dead('死'),
  tomb('墓'),
  extingnished('绝'),
  conceive('胎'),
  incubate('养');

  const PalaceLabel(this.label);
  final String label;
}