import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wldt/models/diary_model.dart';
import 'package:wldt/res/urls.dart';

class DiaryProvider with ChangeNotifier{
  List<Diary> _diaryList = [];
  List<Diary> get diaryList => _diaryList;

  List<Diary> _myDiaryList = [];
  List<Diary> get myDiaryList => _myDiaryList;

//  获取所有的小记
  Future<bool> getAllDiary()async{
    Dio dio = new Dio(Http.options);
    _diaryList.clear();
   try{
     Response response = await dio.get(DiaryUrl.getAllDiary);
     if (response.statusCode == 200) {
       var data = response.data["data"];
       for (int i = 0; i < data.length; i++) {
         _diaryList.add(Diary.fromJson(data[i]));
       }
       notifyListeners();
       return true;
     }
     return false;
   }catch(e){
     return false;
   }
  }

//  获取用户的所有小记
  Future<bool> getUsersDiary()async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String phone = sp.getString("phone");
    Dio dio = new Dio(Http.options);
    _myDiaryList.clear();
    try{
      Response response = await dio.get(DiaryUrl.getAllDiary,queryParameters: {"phone":phone});
      if (response.statusCode == 200) {
        var data = response.data["data"];
        for (int i = 0; i < min(data.length, 8); i++) {
          _myDiaryList.add(Diary.fromJson(data[i]));
        }
        notifyListeners();
        return true;
      }
      return false;
    }catch(e){
      return false;

    }
  }

  File _image;
  File get image=>_image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    _image = image;
    notifyListeners();
  }

  clearImage(){
    _image = null;
    notifyListeners();
  }

  Future<String> publicDiary(String content)async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    String phone = sp.getString("phone");
    String path = _image.path;
    var name = path.substring(path.lastIndexOf("/") + 1, path.length);
    FormData formData = FormData.fromMap({
      "phone": phone,
      "content":content,
      "image": await MultipartFile.fromFile(path,filename: name)
    });
    try{
      Dio dio = new Dio(Http.options);
      Response response = await dio.post(DiaryUrl.publicDiary,data: formData);
      _diaryList.insert(0, Diary.fromJson(response.data["data"]));
      _image = null;
      notifyListeners();
      return "OK";
    }catch(e) {
      return "发布失败";
    }
  }




}