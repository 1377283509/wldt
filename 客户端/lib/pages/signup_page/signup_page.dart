import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/pages/index_page/index.dart';
import 'package:wldt/pages/my_page/my_page.dart';
import 'package:wldt/pages/signin_page/signin_page.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/input_checkcode.dart';
import 'package:wldt/widgets/input_passwd.dart';
import 'package:wldt/widgets/input_phone.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import 'package:toast/toast.dart';

// 注册页面
class SignupPage extends StatefulWidget {
  @override
  State<SignupPage> createState() => SignupPageState();
}

class SignupPageState extends State<SignupPage> {
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
                "文旅账号注册",
                style: TextStyle(
                    fontSize: ThemeConfig.larggerFontSize,
                    fontWeight: FontWeight.bold),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: (){
                    Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context)=>new SigninPage()));
                  },
                  child: Text("登录"),
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

  bool _isCheck = false;

  @override
  void dispose() {
    super.dispose();
  }

  void _showToast(BuildContext context, String msg) {
    Toast.show(msg, context, gravity: Toast.CENTER,backgroundRadius: 6);
  }

  Widget _protocol() {
    return Container(
      padding: EdgeInsets.only(left: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Checkbox(
            value: _isCheck,
            onChanged: (v) {
              setState(() {
                _isCheck = v;
              });
            },
          ),
          GestureDetector(
            onTap: () {
              print("协议");
            },
            child: Text(
              "我已同意《服务协议》和《隐私协议》",
              style: TextStyle(fontSize: ThemeConfig.smallFontSize),
            ),
          )
        ],
      ),
    );
  }

  Widget _signUpWidget() {
    return Consumer<UserProvider>(
      builder: (_, userState, __) {
        return GestureDetector(
          onTap: () async {
            if (!_isCheck) {
              _showToast(context, "请同意《服务协议》和《隐私协议》");
            } else {
              String res = await userState.register();
              if(res != "OK"){
                Toast.show(res, context,gravity: Toast.TOP);
              }else{
                Navigator.of(context).pop();
              }
            }
          },
          child: Container(
            width: 300,
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Color.fromRGBO(216,96,80,1), borderRadius: BorderRadius.circular(6)),
            child: Text(
              "注册并登录",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ThemeConfig.nomalFontSize,
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
            InputCheckcode(),
            // 密码输入框
            InputPasswd(),
            // 服务协议，隐私政策
            _protocol(),
            // 注册登录
            SizedBox(
              height: 30,
            ),
            _signUpWidget(),
          ],
        ),
      ),
    );
  }
}
