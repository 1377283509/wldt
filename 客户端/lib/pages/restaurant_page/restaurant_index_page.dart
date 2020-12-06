import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import 'package:wldt/pages/food_page/wdigets/restaurant_card.dart';
import 'package:wldt/pages/search_page/search_page.dart';
import 'package:wldt/providers/restaurant_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// 餐馆首页

class RestaurantIndexPage extends StatefulWidget {
  @override
  State<RestaurantIndexPage> createState() => RestaurantIndexPageState();
}

class RestaurantIndexPageState extends State<RestaurantIndexPage> {
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
            automaticallyImplyLeading: true,
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
              "特色餐馆",
              style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            ),
            centerTitle: true,
          ),
          body: RestaurantPageBody(),
        ),
      );
    });
  }
}

class RestaurantPageBody extends StatelessWidget {
  RefreshController _controller = new RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (_, restaurantState, __) {
        return Theme(
            data: ThemeData(primaryColor: Color.fromRGBO(200,48,16,1),),
            child: SmartRefresher(
                controller: _controller,
                onRefresh: () async {
                  bool res = await restaurantState.getAllRestaurants();
                  if (!res) {
                    Toast.show("出错了", context);
                  }
                  _controller.refreshCompleted();
                },
                child: ListView(
                    padding: EdgeInsets.only(top: 4.0, bottom: 8.0),
                    children: restaurantState.simpleRestaurants
                        .map((v) => RestaurantCard(
                              v,
                            ))
                        .toList())));
      },
    );
  }
}
