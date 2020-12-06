import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/food_model.dart';
import 'package:wldt/models/restaurant_model.dart';
import 'package:wldt/models/tourist_spot_model.dart';
import 'package:wldt/res/urls.dart';

class DaTongProvider with ChangeNotifier {
  bool _status = false;
  bool get status=> _status;

  List<SimpleFood> _foodList = [];
  List<SimpleFood> get foodList => _foodList;

  List<SimpleTouristAttraction> _touristAttractionList = [];
  List<SimpleTouristAttraction> get touristAttractionList =>
      _touristAttractionList;

  List<SimpleRestaurant> _simpleRestaurants = [];
  List<SimpleRestaurant> get simpleRestaurants => _simpleRestaurants;



  Future<bool> refresh() async {
    try {
      bool res1 = await this.getFoodList();
      bool res2 = await this.getTouristList();
      bool res3 = await this.getAllRestaurants();
      _status = res1 & res2 & res3;
      return _status;
    } catch (e) {
      return false;
    }
  }

  Future<bool> getAllRestaurants() async {
    Dio dio = new Dio(Http.options);
    _simpleRestaurants.clear();
    Response response = await dio.get(RestaurantUrl.getRestaurantList);
    if (response.statusCode == 200) {
      var data = response.data["data"];
      for (int i = 0; i < min(data.length, 8); i++) {
        _simpleRestaurants.add(SimpleRestaurant.fromJson(data[i]));
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  // 获取景区列表
  Future<bool> getTouristList() async {
    _touristAttractionList.clear();
    Dio dio = new Dio(Http.options);
    Response response = await dio.get(TouristUrl.getTouristList);
    var data = response.data["data"];
    if (response.statusCode == 200) {
      for (int i = 0; i < min(data.length, 8); i++) {
        _touristAttractionList.add(SimpleTouristAttraction.fromJson(data[i]));
      }
      notifyListeners();
      return true;
    }
    return false;
  }

  // 获取美食列表
  Future<bool> getFoodList() async {
    _foodList.clear();
    Dio dio = new Dio(Http.options);
    Response response = await dio.get(FoodUrl.getFoodList);
    if (response.statusCode == 200) {
      var data = response.data;
      for (int i = 0; i < min(data["data"].length, 8); i++) {
        _foodList.add(SimpleFood.fromJson(data["data"][i]));
      }
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }
}
