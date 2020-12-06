import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/comment_model.dart';
import 'package:wldt/models/restaurant_model.dart';
import 'package:wldt/res/urls.dart';

class RestaurantProvider with ChangeNotifier {
  List<SimpleRestaurant> _simpleRestaurants = [];
  List<SimpleRestaurant> get simpleRestaurants => _simpleRestaurants;
  Future<bool> getAllRestaurants()async{
    Dio dio = new Dio(Http.options);
    _simpleRestaurants.clear();
    Response response = await dio.get(RestaurantUrl.getRestaurantList);
    if(response.statusCode == 200){
      var data = response.data["data"];
      for(int i=0;i<data.length;i++){
        _simpleRestaurants.add(SimpleRestaurant.fromJson(data[i]));
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  // 当前餐厅
  Restaurant _curRestaurant;
  Restaurant get curRestaurant => _curRestaurant;
  // 菜单
  List<String> _curFoods = [];
  List<String> get curFood => _curFoods;
  // 评论
  List<Comment> _curComments = [];
  List<Comment> get curComments => _curComments;
  // 标签
  List<String> _curTags = [];
  List<String> get curTags => _curTags;
  // 配图
  List<String> _curImages = [];
  List<String> get curImages=>_curImages;

  Future<void> getRestaurantById(int id)async{
    _curComments.clear();
    _curTags.clear();
    _curImages.clear();
    _curFoods.clear();
    Dio dio = new Dio(Http.options);
    Response response = await dio.get(RestaurantUrl.getRestaurantDetails,queryParameters: {"id":id});
    var data = response.data["data"];
    _curRestaurant = Restaurant.fromJson(data["restaurant"]);

    for(int i=0;i<data["foods"].length;i++){
      _curFoods.add(data["foods"][i]);
    }

    for(int i=0;i<data["tags"].length;i++){
      _curTags.add(data["tags"][i]);
    }

    for(int i=0;i<data["images"].length;i++){
      _curImages.add(data["images"][i]);
    }
    for(int i=0;i<data["comments"].length;i++){
      _curComments.add(Comment.fromJson(data["comments"][i]));
    }
  }


}
