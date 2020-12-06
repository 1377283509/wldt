import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:wldt/providers/diary_providers.dart';
import 'package:wldt/res/global_config.dart';

class PublicDiaryPage extends StatefulWidget {
  @override
  _PublicDiaryPageState createState() => _PublicDiaryPageState();
}

class _PublicDiaryPageState extends State<PublicDiaryPage> {
  TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryProvider>(
      builder: (_, pageState, __) {
        return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 触摸收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
                backgroundColor: Colors.white,
                floatingActionButton: FloatingActionButton(
                  backgroundColor: Color.fromRGBO(216,96,80,1),
                  child: Icon(Icons.send),
                  onPressed: () async {
                    if(pageState.image == null){
                      Toast.show("请选择图片",context);
                      return;
                    }
                    if(_controller.text == ""){
                      Toast.show("请输入内容",context);
                      return;
                    }
                      String res = await pageState.publicDiary(_controller.text);
                    if(res == "OK"){
                      Navigator.of(context).pop();
                      Toast.show("发布成功", context);
                    }else{
                      Toast.show("发布失败", context);
                    }
                  },
                ),
                appBar: AppBar(
                  title: Text(
                    "发布小记",
                    style: TextStyle(fontSize: ThemeConfig.larggerFontSize),
                  ),
                  centerTitle: true,
                  automaticallyImplyLeading: true,
                  elevation: 0,
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        pageState.clearImage();
                      },
                      child: Text("清除照片"),
                    )
                  ],
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      ImagePcikerWidget(),
                      InputWidget(_controller)
                    ],
                  ),
                )));
      },
    );
  }
}

class ImagePcikerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Consumer<DiaryProvider>(
      builder: (_,pageState,__){
        return pageState.image == null
            ? Container(
          margin: EdgeInsets.only(top: 24.0),
          alignment: Alignment.center,
          child: IconButton(
            icon: Icon(Icons.add_photo_alternate),
            onPressed: () {
              pageState.getImage();
            },
          ),
        )
            : Container(
          width: screenWidth,
          height: 1.1 * screenWidth,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: FileImage(pageState.image),
                fit: BoxFit.cover),
          ),
        );
      },

    );
  }
}


class InputWidget extends StatelessWidget {
  final TextEditingController _controller;
  InputWidget(this._controller);
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(top: 10.0),
      child: TextField(
        maxLines: null,
        controller: _controller,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.edit,color: Colors.black45,),
          hintText: "今日小记",
          border: InputBorder.none
        ),
      ),
    );
  }
}

