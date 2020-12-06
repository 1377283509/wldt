import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier{

    bool _isDark = false;
    bool get isDark =>_isDark;

    ThemeData _darkTheme = ThemeData.dark();
    ThemeData _lightTheme = ThemeData(
      primaryColor: Colors.white,
      primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[100]
    );

    ThemeData get darkTheme=>_darkTheme;
    ThemeData get lightTheme=>_lightTheme;
    
    changeTheme(){
      this._isDark = !this._isDark;
      notifyListeners();
    }
}