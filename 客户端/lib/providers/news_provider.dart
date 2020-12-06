import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:wldt/models/news_model.dart';
import 'package:wldt/res/urls.dart';
import 'package:wldt/utils/md5_encrypt.dart' as MD5;

const String showapi_sign = "";
const String title = "大同";



class NewsProvider with ChangeNotifier {
  int _pages = 1;
  List<SimpleNews> _newsList = [];
  List<SimpleNews> get newsList => _newsList;

  News _news;
  News get news => _news;


  Future getAllData() async {
    Dio dio = new Dio(Http.options);
    String sign =
        "maxResult20needAllList0needContent0needHtml0page${_pages}showapi_appid【appid】title大同" +
            showapi_sign;
    sign = MD5.generateMd5(sign);
    try {
      String url = "https://route.showapi.com/109-35";
      Response response = await dio.post(url, queryParameters: {
        "maxResult": 20,
        "needAllList": 0,
        "needContent": 0,
        "needHtml": 0,
        "page": _pages,
        "showapi_appid": "238158",
        "title": "大同",
        "showapi_sign":sign,
      });
      if(response.statusCode != 200){
        return false;
      }
      List datalist = response.data["showapi_res_body"]["pagebean"]["contentlist"];
      for(int i=0;i<datalist.length;i++){
        _newsList.add(SimpleNews.fromJson(datalist[i]));
      }
      _pages++;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> getNewsDetail(String id) async {
    Dio dio = new Dio(Http.options);
    String sign =
        "id${id}showapi_appid238158" +
            showapi_sign;
    sign = MD5.generateMd5(sign);
    try {
      String url = "https://route.showapi.com/109-35";
      Response response = await dio.post(url, queryParameters: {
        "id": id,
        "showapi_appid": "",
        "showapi_sign":sign,
      });
      if(response.statusCode != 200){
        return false;
      }
      _news = News.fromJson(response.data["showapi_res_body"]["pagebean"]["contentlist"][0]);
      print(_news);
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }


}
