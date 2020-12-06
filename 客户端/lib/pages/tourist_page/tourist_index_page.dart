import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:wldt/pages/search_page/search_page.dart';
import 'package:wldt/pages/tourist_page/widgets/tourist_attraction_card.dart';
import 'package:wldt/providers/food_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/providers/tourist_attraction_provider.dart';

class TouristIndexPage extends StatefulWidget {
  @override
  State<TouristIndexPage> createState() => TouristIndexPageState();
}

class TouristIndexPageState extends State<TouristIndexPage> {

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, FoodProvider>(
        builder: (_, themeState, foodState, __) {
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            title: Text("独特美景",style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    Navigator.of(context).push(
                        CupertinoPageRoute(builder: (context) => SearchPage()));
                  }),
              IconButton(icon: Icon(Icons.sort), onPressed: null),
            ],
          ),
          body:  TouristAttractionBody(),
        ),
      );
    });
  }
}


// 全部景点
class TouristAttractionBody extends StatelessWidget {
  RefreshController _controller = new RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Consumer<TouristAttractionProvider>(
      builder: (_, touristSpotState, __) {
        return Theme(
            data: ThemeData(primaryColor: Colors.orange),
            child: SmartRefresher(
                controller: _controller,
                onRefresh: () async {
                  bool res = await touristSpotState.getTouristList();
                  if(res){
                    Toast.show("加载完成", context);
                  }else {
                    Toast.show("出错了", context);
                  }
                  _controller.refreshCompleted();
                },
                child: ListView(
                    padding: EdgeInsets.only(top: 4.0,bottom: 8.0),
                    children:
                    touristSpotState.touristAttractionList.map((v) => TouristAttractionCard(v)).toList())));
      },
    );
  }
}