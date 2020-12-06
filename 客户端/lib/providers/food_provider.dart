import 'package:flutter/material.dart';
import 'package:wldt/models/food_model.dart';
import 'package:dio/dio.dart';
import 'package:wldt/models/restaurant_model.dart';
import 'package:wldt/res/urls.dart';


class FoodProvider with ChangeNotifier {

  List<SimpleFood> _foodList = [];
  List<SimpleFood> get foodList=>_foodList;

  // 获取美食列表
  Future<bool> getFoodList()async{
    _foodList.clear();
    Dio dio = new Dio(Http.options);
    Response response = await dio.get(FoodUrl.getFoodList);
    if(response.statusCode == 200){
      var data = response.data;
      for(int i=0;i<data["data"].length;i++){
        _foodList.add(SimpleFood.fromJson(data["data"][i]));
      }
      notifyListeners();
      return true;
    }else{
      return false;
    }
  }

  // 通过id获取美食详细信息
  Food _curFood;
  Food get curFood => _curFood;
  List<SimpleRestaurant> _restaurants = [];
  List<SimpleRestaurant> get restaurants =>_restaurants;
  List<String> _images = [];
  List<String> get images=>_images;


  Future<void> getFoodById(int id)async{
    Dio dio= new Dio(Http.options);
    _images.clear();
    _restaurants.clear();
    Response response= await dio.get(FoodUrl.getFoodDetails,queryParameters: {"id":id});
    var data = response.data["data"];
    _curFood = Food.fromJson(data);
    for(int i=0;i<data["imgs"].length;i++){
      _images.add(data["imgs"][i]);
    }
    for(int i=0;i<data["restaurants"].length;i++){
      _restaurants.add(SimpleRestaurant.fromJson(data["restaurants"][i]));
    }
    print(_restaurants);
  }
}
