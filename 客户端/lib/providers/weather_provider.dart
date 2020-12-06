import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class WeatherProvider with ChangeNotifier{

  BaseOptions options = new BaseOptions(
    baseUrl: "",
    connectTimeout: 5000,
    receiveTimeout: 3000,
  );

  Dio dio = Dio();

  


}