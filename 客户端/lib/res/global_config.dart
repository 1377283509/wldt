import 'package:flutter/material.dart';

class ThemeConfig {
  // 搜索框样式
  static const double searchBarIconSize = 18.0;
  static const Color searchBarIconColor = Colors.grey;
  static const double searchBarFontSize = 14.0;
  static const Color searchBarFontColor = Colors.grey;

  // 字体样式
  static const double smallFontSize = 12.0;
  static const double nomalFontSize = 14.0;
  static const double larggerFontSize = 16.0;
  static const double maximalFontSize = 18.0;

  // 图标样式
  static const double smallIconSize = 18.0;
  static const double nomalIconSize = 24.0;
  static const double largeIconSize = 28.0;

  // 光标颜色
  static const Color cursorColor = Colors.black;

  // TabBar lable样式
  static const TextStyle lableStyle = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline,
      decorationStyle: TextDecorationStyle.solid,
      decorationThickness: 3.0,
      decorationColor: Color.fromRGBO(216,96,80,1));
  static const TextStyle unselectedLableStyle = TextStyle(
    color: Colors.grey,
  );
}
