import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/trend_model.dart';
import 'package:wldt/res/urls.dart';

class TrendsProvider with ChangeNotifier{
  List<SimpleTrend> _trendList = [];
  List<SimpleTrend> get trendList => _trendList;

  Trend _trend;
  Trend get trend=>_trend;

  Future<bool> getTrendById(int id)async{
    Dio dio = new Dio(Http.options);
    try{
      Response response = await dio.get(TrendsUrl.getTrendById,queryParameters: {"id":id});
      if (response.statusCode == 200) {
        var data = response.data["data"];
        _trend = Trend.fromJson(data);
        return true;
      }
      return false;
    }catch(e){
      return false;
    }

  }

  Future<bool> getAllData()async{
    Dio dio = new Dio(Http.options);
    _trendList.clear();
    try{
      Response response = await dio.get(TrendsUrl.getAllTrends);
      if (response.statusCode == 200) {
        var data = response.data["data"];
        for (int i = 0; i < data.length; i++) {
          _trendList.add(SimpleTrend.fromJson(data[i]));
        }
        notifyListeners();
        return true;
      }
      return false;
    }catch(e){
      print(e);
      return false;
    }
  }




}