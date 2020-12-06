import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/strategy_model.dart';
import 'package:wldt/res/urls.dart';

class StrategyProvider with ChangeNotifier{

  List<SimpleStrategy> _list = [];
  List<SimpleStrategy> get list => _list;

  Strategy _strategy;
  Strategy get strategy => _strategy;

  List<String> _images = [];
  List<String> get images => _images;

  List<String> _tags = [];
  List<String> get tags => _tags;

  Future<bool> getStrategyById(int id)async{
    Dio dio = new Dio(Http.options);
    _images.clear();
    _tags.clear();
    try{
      Response response = await dio.get(StrategyUrl.getStrategyById,queryParameters: {"id":id});
      if (response.statusCode == 200) {
        var data = response.data["data"];
        _strategy = Strategy.fromJson(data["strategy"]);
        for(int i=0;i<data["images"].length;i++){
          _images.add(data["images"][i]);
        }
        for(int i=0;i<data["tags"].length;i++){
          _tags.add(data["tags"][i]);
        }
        return true;
      }
      return false;
    }catch(e){
      return false;
    }

  }

  Future<bool> getAllData()async{
    Dio dio = new Dio(Http.options);
    _list.clear();
    try{
      Response response = await dio.get(StrategyUrl.getAllStrategy);
      if (response.statusCode == 200) {
        var data = response.data["data"];
        for (int i = 0; i < data.length; i++) {
          _list.add(SimpleStrategy.fromJson(data[i]));
        }
        notifyListeners();
        return true;
      }
      return false;
    }catch(e){
      return false;
    }
  }
}