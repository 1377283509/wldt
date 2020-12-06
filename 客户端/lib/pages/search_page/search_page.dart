import 'package:flutter/material.dart';
import 'package:wldt/res/global_config.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController _inputController = new TextEditingController();
  @override
  void initState() { 
    super.initState();
    _inputController.addListener((){

    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        title: Hero(
          tag: "search_bar",
          child: Material(
            color: Colors.transparent,
          child: Container(
            width: .9*screenWidth,
            height: 35,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(50)
            ),
            child: TextField(
              autofocus: true,
              controller: _inputController,
              decoration: InputDecoration(
                hintText: "输入内容开始搜索",
                hintStyle: TextStyle(fontSize: ThemeConfig.nomalFontSize,color: Colors.grey),
                contentPadding: EdgeInsets.zero,
                prefixIcon: Icon(Icons.search,color: Colors.black54,size: ThemeConfig.smallIconSize,),
                border: InputBorder.none,
                focusColor: Colors.black,
              ),
            ),
          ),
        ),
        ),
        actions: <Widget>[
       FlatButton(
          color: Colors.transparent,
          padding: EdgeInsets.all(0),
          child: Text("搜索"),
          onPressed: (){},
        )
        ],
      ),
      body: Center(child: Text("search"),),
    );
  }
}