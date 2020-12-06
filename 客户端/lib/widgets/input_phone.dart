import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:wldt/providers/user_provider.dart';
import 'package:wldt/res/global_config.dart';


class InputPhone extends StatefulWidget{
  @override
  State<InputPhone> createState()=> InputPhoneState();
}

class InputPhoneState extends State<InputPhone>{
  TextEditingController _inputPhoneNum = TextEditingController();

  @override
  void dispose() {
    _inputPhoneNum.dispose();
    super.dispose();
  }
  void _showToast(BuildContext context, String msg) {
    Toast.show(msg, context, gravity: Toast.CENTER,backgroundRadius: 6);
  }
  @override
  Widget build(BuildContext context){
    return Consumer<UserProvider>(
      builder: (_,userState,__){
        return Container(
          height: 50,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Container(
                height: 20,
                padding: EdgeInsets.only(left: 25),
                decoration: BoxDecoration(
                    border:
                    Border(right: BorderSide(color: Color.fromRGBO(216,96,80,1), width: 3.0))),
                width: 80,
                alignment: Alignment.centerLeft,
                child: Text(
                  "手机号",
                  style: TextStyle(
                      fontSize: ThemeConfig.nomalFontSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                width: 280,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: TextField(
                    controller: _inputPhoneNum,
                    onChanged: (v){
                      userState.setPhone(v);
                    },
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      prefixStyle: TextStyle(
                        color: Colors.black,
                      ),
                      suffix: GestureDetector(
                        onTap: (){
                          _inputPhoneNum.clear();
                        },
                        child: Icon(
                          Icons.cancel,
                          size: 19,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: "输入手机号",
                      border: InputBorder.none,
                    )),
              ),
            ],
          ),
        );
      },
    );
  }
}