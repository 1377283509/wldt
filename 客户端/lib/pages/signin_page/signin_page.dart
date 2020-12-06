import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/pages/signup_page/signup_page.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/utils/data_check.dart';
import 'package:wldt/widgets/input_checkcode.dart';
import 'package:wldt/widgets/input_passwd.dart';
import 'package:wldt/widgets/input_phone.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import 'package:toast/toast.dart';

class SigninPage extends StatefulWidget {
  @override
  State<SigninPage> createState() => SigninPageState();
}

class SigninPageState extends State<SigninPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeState, __) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              centerTitle: false,
              title: Text(
                "文旅账号登录",
                style: TextStyle(
                    fontSize: ThemeConfig.larggerFontSize,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(
                        builder: (context) => new SignupPage()));
                  },
                  child: Text("注册"),
                ),
              ],
            ),
            body: _Body());
      },
    );
  }
}

class _Body extends StatefulWidget {
  _Body({Key key}) : super(key: key);

  @override
  __BodyState createState() => __BodyState();
}

class __BodyState extends State<_Body> {
  bool _isPwd = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _showToast(BuildContext context, String msg) {
    Toast.show(msg, context, gravity: Toast.CENTER, backgroundRadius: 6);
  }

  Widget _signInWidget() {
    return Consumer<UserProvider>(
      builder: (_, userState, __) {
        return GestureDetector(
          onTap: () async {
            if (!phoneNumCheck(userState.tempUserPhone)) {
              _showToast(context, "手机号码不正确");
              return;
            }
            if (_isPwd) {
              if (userState.tempPasswd.length > 16 ||
                  userState.tempPasswd.length < 8) {
                _showToast(context, "密码长度为8-16位");
                return;
              }
            } else {
              if (!userState.verityCheckCode(userState.tempCheckCode)) {
                _showToast(context, "验证码错误");
                return;
              }
            }
           String res =await userState.login();
           if(res == "OK"){
             print("登录成功");
              Navigator.of(context).pop();
           }else{
             Toast.show(res, context,gravity: Toast.TOP);
           }
          },
          child: Container(
            width: 300,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color.fromRGBO(216,96,80,1), borderRadius: BorderRadius.circular(6)),
            child: Text(
              "登\t\t\t录",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ThemeConfig.larggerFontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.only(bottom: 15),
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // 手机号输入框
            InputPhone(),
            // 验证码输入框
            _isPwd ? InputPasswd() : InputCheckcode(),
            // 登录
            GestureDetector(
              onTap: () {
                setState(() {
                  _isPwd = !_isPwd;
                });
              },
              child: Container(
                padding: EdgeInsets.only(right: 40, top: 0),
                alignment: Alignment.centerRight,
                child: Text(
                  _isPwd ? "验证码登录" : "密码登录",
                  style: TextStyle(
                      fontSize: ThemeConfig.smallFontSize,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _signInWidget(),
          ],
        ),
      ),
    );
  }
}
