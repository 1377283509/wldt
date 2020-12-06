import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:wldt/pages/datong_page/widgets/food_list.dart';
import 'package:wldt/pages/datong_page/widgets/restaurant_list.dart';
import 'package:wldt/pages/datong_page/widgets/scenic_list.dart';
import 'package:wldt/providers/datong_provider.dart';
import 'package:wldt/widgets/page_menu.dart';
import 'package:wldt/widgets/title.dart';

class DaTongIndexPage extends StatefulWidget {
  @override
  _DaTongIndexPageState createState() => _DaTongIndexPageState();
}

class _DaTongIndexPageState extends State<DaTongIndexPage>
    with AutomaticKeepAliveClientMixin {
  final List<Menu> _menus = [
    Menu(
        icon: Icons.restaurant,
        text: "美食",
        color: Colors.green,
        routName: "meishi"),
    Menu(
        icon: Icons.terrain,
        text: "景点",
        color: Colors.purple,
        routName: "jingdian"),
    Menu(
        icon: Icons.flag,
        text: "文化",
        color: Colors.lightBlue,
        routName: "wenhua"),
    Menu(
        icon: Icons.whatshot, text: "资讯", color: Colors.red, routName: "zixun"),
  ];
  RefreshController _controller = new RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text("大同",
            style: TextStyle(
                fontSize: 26.0, fontWeight: FontWeight.bold, letterSpacing: 2)),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
          ),
          IconButton(
            icon: Icon(Icons.wb_sunny),
            onPressed: () {},
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Consumer<DaTongProvider>(
        builder: (_, pageState, __) {
          return Theme(
            data: ThemeData(
                primaryColor: Color.fromRGBO(200, 48, 16, 1),
                backgroundColor: Colors.white),
            child: SmartRefresher(
                controller: _controller,
                onRefresh: () async {
                  bool res = await pageState.refresh();
                  if (!res) {
                    Toast.show("加载失败", context);
                  }
                  _controller.refreshCompleted();
                },
                child: SafeArea(
                    child: SingleChildScrollView(
                        child: Column(
                  children: <Widget>[
                    PageMenu(menus: _menus),
                    TitleWidget(
                      title: "特色美食",
                      routeName: "meishi",
                    ),
                    FoodList(foodList: pageState.foodList),
                    TitleWidget(
                      title: "独特美景",
                      routeName: "jingdian",
                    ),
                    ScenicList(list: pageState.touristAttractionList),
                    TitleWidget(
                      title: "特色餐馆",
                      routeName: "canting",
                    ),
                    RestaurantList(restaurantList: pageState.simpleRestaurants),
                    SizedBox(
                      height: 12,
                    )
                  ],
                )))),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class BodyCard extends StatelessWidget {
  final List<Widget> widgets;
  BodyCard(this.widgets);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, bottom: 12, left: 6, right: 6),
      child: Column(children: widgets),
    );
  }
}

