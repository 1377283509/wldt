import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:wldt/providers/user_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/utils/data_check.dart';

class InputCheckcode extends StatefulWidget{
  @override
  State<InputCheckcode> createState()=> InputCheckcodeState();
}

class InputCheckcodeState extends State<InputCheckcode>{
  TextEditingController _input= TextEditingController();
  bool _isEnable = true;
  bool _isEnableInput = false;
  Timer _countdownTimer;
  String _codeCountdownStr = '获取验证码';
  int _countdownNum = 59;

  @override
  void dispose() {
    _input.dispose();
    _countdownTimer?.cancel();
    _countdownTimer = null;
    super.dispose();
  }
  void _showToast(BuildContext context, String msg) {
    Toast.show(msg, context, gravity: Toast.CENTER,backgroundRadius: 6);
  }

  void _getCountdown() {
    setState(() {
      _isEnable = false;
      _isEnableInput = true;
      // TODO: 发送验证码
      if (_countdownTimer != null) {
        return;
      }
      // Timer的第一秒倒计时是有一点延迟的，为了立刻显示效果可以添加下一行。
      _codeCountdownStr = '${_countdownNum--}重新获取';
      _countdownTimer =
      new Timer.periodic(new Duration(seconds: 1), (timer) {
        setState(() {
          if (_countdownNum > 0) {
            _codeCountdownStr = '${_countdownNum--}重新获取';
          } else {
            _isEnable = true;
            _codeCountdownStr = '获取验证码';
            _countdownNum = 59;
            _countdownTimer.cancel();
            _countdownTimer = null;
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context){
    return Consumer<UserProvider>(
      builder: (_, userState, __) {
        return Container(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                width: 80,
                height: 20,
                padding: EdgeInsets.only(left: 25),
                decoration: BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Color.fromRGBO(216,96,80,1), width: 3))),
                alignment: Alignment.centerLeft,
                child: Text(
                  "验证码",
                  style: TextStyle(
                      fontSize: ThemeConfig.nomalFontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 180,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                  controller: _input,
                  onEditingComplete: () {
                    bool res =
                    userState.verityCheckCode(_input.text);
                    if (!res) {
                      _showToast(context, "验证码错误");
                    }
                  },
                  onChanged: (v){
                    setState(() {
                      userState.setCheckNum(v);
                    });
                  },
                  enabled: _isEnableInput,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      hintText: "输入验证码", border: InputBorder.none),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 4, left: 8, right: 8, bottom: 4),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6)),
                child: FlatButton(
                    onPressed: _isEnable?() {
                      if(userState.tempUserPhone == ""){
                        _showToast(context, "请输入手机号");
                        return;
                      }
                      if(!phoneNumCheck(userState.tempUserPhone)){
                        _showToast(context, "手机号格式不正确");
                        return;
                      }
                      int res = userState.sendCheckcode();
                      if(res == 0){
                        _showToast(context, "验证码发送成功");
                        _getCountdown();
                        return;
                      }
                    }:null,
                    disabledTextColor: Colors.grey,
                    textColor:Color.fromRGBO(216,96,80,1),
                    child: Text(
                      _codeCountdownStr,
                      style: TextStyle(
                          fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ),
        );
      },
    );
  }

}