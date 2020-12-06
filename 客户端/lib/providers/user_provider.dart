import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wldt/models/user_model.dart';
import 'package:wldt/res/urls.dart';


class UserProvider with ChangeNotifier {
  bool _hasLogin = false;
  bool get hasLogin => _hasLogin;
  UserModel _user = UserModel();
  UserModel get user => _user;
  // 临时密码
  String _tempUserPhone;
  String get tempUserPhone => _tempUserPhone;
  String _tempPasswd;
  String get tempPasswd => _tempPasswd;
  String _tempCheckcode;
  String get tempCheckCode => _tempCheckcode;

  Future<bool> launch() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var phone = sp.getString("phone");
    var password = sp.getString("password");
    if(phone == null || password == null){
      return false;
    }
    try{
      Dio dio = Dio(Http.options);
      Response res = await dio
          .post(UserUrl.login, data: {"phone": phone, "password": password});
      if(res.data["errno"]!=0){
        return res.data["errmsg"];
      }
      var data = res.data["data"];
      _user = UserModel.fromJson(data);
      _hasLogin = true;
      notifyListeners();
      print("登录成功");
      return true;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<String> register() async {
    String phone = _tempUserPhone;
    String password = _tempPasswd;
    if (verityCheckCode(this._tempCheckcode)) {
      // 执行注册逻辑
      try {
        Dio dio = Dio(Http.options);
        Response res = await dio.post(UserUrl.register,
            data: {"phone": phone, "password": password});
        if(res.data["errno"]!=0){
          return res.data["errmsg"];
        }
        var data = res.data["data"];
        _user = UserModel.fromJson(data);
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("phone", phone);
        sp.setString("password", password);
        _hasLogin = true;
        notifyListeners();
        return "OK";
      } catch (e) {
        print(e);
        return "未知错误";
      }
    }
    return "验证码错误";
  }

  Future<String> login()async {
     try{
       Dio dio = Dio(Http.options);
      Response res = await dio
          .post(UserUrl.login, data: {"phone": _tempUserPhone, "password": _tempPasswd});
      if(res.data["errno"]!=0){
        return res.data["errmsg"];
      }
      var data = res.data["data"];
      _user = UserModel.fromJson(data);
       SharedPreferences sp = await SharedPreferences.getInstance();
       sp.setString("phone", _tempUserPhone);
       sp.setString("password", _tempPasswd);
      notifyListeners();
      return "OK";
     }catch(e){
       print(e);
       return "未知错误";
     }
  }

  logout() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("phone");
    sp.remove("password");
    _user = UserModel();
    notifyListeners();
  }

  bool verityCheckCode(String str) {
    if (str == "1234") {
      return true;
    }
    return false;
  }

  int sendCheckcode() {
    // 发送验证码
    return 0;
  }

  void setPhone(String s) {
    this._tempUserPhone = s;
  }

  void setCheckNum(String s) {
    this._tempCheckcode = s;
  }

  void setPasswd(String s) {
    this._tempPasswd = s;
  }
}
