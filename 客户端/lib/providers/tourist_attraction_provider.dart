import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/comment_model.dart';
import 'package:wldt/models/tourist_spot_model.dart';
import 'package:wldt/res/urls.dart';



class TouristAttractionProvider with ChangeNotifier{
  List<SimpleTouristAttraction> _touristAttractionList = [];
  List<SimpleTouristAttraction> get touristAttractionList => _touristAttractionList;


  // 获取景区列表
  Future<bool> getTouristList()async{
    _touristAttractionList.clear();
    Dio dio = new Dio(Http.options);
    Response response = await dio.get(TouristUrl.getTouristList);
    var data = response.data["data"];
    if(response.statusCode == 200){
      for(int i=0;i<data.length;i++){
        _touristAttractionList.add(SimpleTouristAttraction.fromJson(data[i]));
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  // 当前景区
  TouristAttraction _curTouristA;
  TouristAttraction get curTouristA => _curTouristA;

  // 当前景区的景点列表
  List<SimpleTouristSpot> _curTouristSList = [];
  List<SimpleTouristSpot> get curTouristSList => _curTouristSList;

  // 当前景区的配图列表
  List<String> _curTouristAImages = [];
  List<String> get curTouristAImages =>_curTouristAImages;

  // 当前景区标签
  List<String> _curTouristATags = [];
  List<String> get curTouristATags => _curTouristATags;

  // 当前景区评论列表
  List<Comment> _curTouristComments = [];
  List<Comment> get curTouristComments => _curTouristComments;

  Future<void> getTouristAttraction(int id)async{
    Dio dio = new Dio(Http.options);
    _curTouristSList.clear();
    _curTouristAImages.clear();
    _curTouristATags.clear();
    _curTouristComments.clear();
    Response response = await dio.get(TouristUrl.getTouristAttraction,queryParameters: {"id":id});
    var data = response.data["data"];
    // 序列化景区
    _curTouristA = TouristAttraction.fromJson(data["tourist_attraction"]);

    // 序列化景区配图
    for(int i=0;i<data["images"].length;i++){
      _curTouristAImages.add(data["images"][i]);
    }

    // 序列化景区评论
    for(int i=0;i<data["comments"].length;i++){
     var comment = Comment.fromJson(data["comments"][i]);
     comment.images = [];
     for(int j=0;j<data["comments"][i]["imgs"].length;j++){
       comment.images.add(data["comments"][i]["imgs"][j]);
     }
      _curTouristComments.add(comment);
    }
    // 序列化景区标签
    for(int i=0;i<data["tourist_tag"].length;i++){
      _curTouristATags.add(data["tourist_tag"][i]);
    }
    // 序列化景区景点
    for(int i=0;i<data["tourist_spot"].length;i++){
      _curTouristSList.add(SimpleTouristSpot.fromJson(data["tourist_spot"][i]));
    }
  }


}