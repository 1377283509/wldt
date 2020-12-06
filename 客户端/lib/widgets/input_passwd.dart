import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:wldt/providers/user_provider.dart';
import 'package:wldt/res/global_config.dart';
class InputPasswd extends StatefulWidget{

  @override
  State<InputPasswd> createState() => InputPasswdState();
}

class InputPasswdState extends State<InputPasswd>{
  TextEditingController _inputPassword = TextEditingController();
  bool _isVisible = false;
  @override
  void dispose() {
    _inputPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contex){
    return Consumer<UserProvider>(
      builder: (_,userState,__){
        return Container(
            child: Row(
              children: <Widget>[
                Container(
                  width: 80,
                  height: 20,
                  padding: EdgeInsets.only(left: 25),
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                      border: Border(right: BorderSide(color: Color.fromRGBO(216,96,80,1), width: 3))),
                  child: Text(
                    "密  码",
                    style: TextStyle(
                        fontSize: ThemeConfig.nomalFontSize,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: 280,
                  height: 50,
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: TextField(
                    controller: _inputPassword,
                    obscureText: !_isVisible,
                    onChanged: (v){
                      userState.setPasswd(_inputPassword.text);
                    },
                    decoration:
                    InputDecoration(
                        suffix: GestureDetector(
                          onTap: (){
                            setState(() {
                              _isVisible = !_isVisible;
                            });
                          },
                          child: Icon(_isVisible?Icons.visibility_off:Icons.visibility,size: 19,color: Colors.grey,),
                        ),
                        hintText: "8~16位密码",
                        border: InputBorder.none
                    ),
                  ),
                )
              ],
            ));
      },
    );
  }
}