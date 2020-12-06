import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/tourist_spot_model.dart';
import 'package:wldt/res/urls.dart';

class TouristSpotProvider with ChangeNotifier{

  // 当前景点
  TouristSpot _curTouristS;
  TouristSpot get curTouristS => _curTouristS;
  // 当前景点配图列表
  List<String> _curTouristSImages = [];
  List<String> get curTouristSImages =>_curTouristSImages;
  // 当前景点标签
  List<String> _curTouristSTags = [];
  List<String> get curTouristSTags =>_curTouristSTags;

  Future<void> getTouristSpot(int id)async{
    _curTouristSImages.clear();
    _curTouristSTags.clear();
    Dio dio = new Dio(Http.options);
    Response response = await dio.get(TouristUrl.getTouristSpot,queryParameters: {"id":id});
    var data = response.data["data"];
    // 序列化景点
    _curTouristS = TouristSpot.fromJson(data["tourist_spot"]);
    print(_curTouristS.name);
    // 景点配图
    var images = data["images"];
    print(images);
    for(int i=0;i<images.length;i++){
      _curTouristSImages.add(images[i]);
    }

    // 景点标签
    var tags = data["tourist_tag"];
    print(tags);
    for(int i=0;i<tags.length;i++){
      _curTouristSTags.add(tags[i]);
    }
  }

}