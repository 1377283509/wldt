import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/help_model.dart';
import 'package:wldt/res/urls.dart';

class SeekHelpProvider with ChangeNotifier {
  List<SimpleHelp> _helpList = [];
  List<SimpleHelp> get helpList => _helpList;

  Help _help;
  Help get help => _help;

  Future<bool> getTrendById(int id) async {
    Dio dio = new Dio(Http.options);
    try {
      Response response = await dio
          .get(SeekHelpUrl.getTravelHelpById, queryParameters: {"id": id});
      if (response.statusCode == 200) {
        var data = response.data["data"];
        _help = Help.fromJson(data);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllData() async {
    Dio dio = new Dio(Http.options);
    _helpList.clear();
    try {
      Response response = await dio.get(SeekHelpUrl.getAllHelp);
      if (response.statusCode == 200) {
        var data = response.data["data"];
        for (int i = 0; i < data.length; i++) {
          _helpList.add(SimpleHelp.fromJson(data[i]));
        }
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
