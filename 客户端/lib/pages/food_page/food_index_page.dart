import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:wldt/pages/food_page/wdigets/food_card_widget.dart';
import 'package:wldt/pages/search_page/search_page.dart';
import 'package:wldt/providers/food_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 美食首页

class FoodIndexPage extends StatefulWidget {
  @override
  State<FoodIndexPage> createState() => FoodIndexPageState();
}

class FoodIndexPageState extends State<FoodIndexPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (_, themeState, __) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => SearchPage()));
                  }),
              IconButton(icon: Icon(Icons.sort), onPressed: null),
            ],
            title: Text(
              "大同美食",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            centerTitle: true,
          ),
          body: FoodPageBody(),
        ),
      );
    });
  }
}

class FoodPageBody extends StatelessWidget {
  RefreshController _controller = new RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Consumer<FoodProvider>(
      builder: (_, foodState, __) {
        return Theme(
            data: ThemeData(primaryColor: Color.fromRGBO(200,48,16,1),),
            child: SmartRefresher(
                controller: _controller,
                onRefresh: () async {
                  bool res = await foodState.getFoodList();
                  if (!res) {
                    Toast.show("出错了", context);
                  }
                  _controller.refreshCompleted();
                },
                child: ListView(
                    padding: EdgeInsets.only(top: 4.0, bottom: 8.0),
                    children:
                        foodState.foodList.map((v) => FoodCard(v)).toList())));
      },
    );
  }
}

