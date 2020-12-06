import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/culture_model.dart';
import 'package:wldt/res/urls.dart';

class CultureProvider with ChangeNotifier{

  List<Culture> _cultureList = [];
  List<Culture> get cultureList => _cultureList;

  Future<bool> getAllCulture()async{
    Dio dio = new Dio(Http.options);
    _cultureList.clear();
    Response response = await dio.get(CultureUrl.getAllCulture);
    if (response.statusCode == 200) {
      var data = response.data["data"];
      for (int i = 0; i < data.length; i++) {
        _cultureList.add(Culture.fromJson(data[i]));
      }
      notifyListeners();
      return true;
    }
    return false;
  }


}