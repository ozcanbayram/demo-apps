import 'package:flutter/material.dart';

//! imageler burada tanımlanır ve buradaki metod aracılığıyla kullanılir.
@immutable
enum ImageEnums { splash, chef }

extension ImageEnumExtension on ImageEnums {
  String get _toPath => 'assets/images/ic_$name.png';
  Image get toImage => Image.asset(_toPath);
}
