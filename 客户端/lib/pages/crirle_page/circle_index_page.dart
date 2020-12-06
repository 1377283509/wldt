import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:wldt/pages/crirle_page/widgets/seek_help_body.dart';
import 'package:wldt/pages/crirle_page/widgets/strategy_body.dart';
import 'package:wldt/pages/crirle_page/widgets/travel_note_body.dart';
import 'package:wldt/pages/crirle_page/widgets/trends_body.dart';
import 'package:wldt/pages/search_page/search_page.dart';
import 'package:wldt/pages/travel_note_page/public_travel_note.dart';
import 'package:wldt/providers/food_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/res/global_config.dart';


class CircleIndexPage extends StatefulWidget {
  @override
  State<CircleIndexPage> createState() => CircleIndexPageState();
}

class CircleIndexPageState extends State<CircleIndexPage> with AutomaticKeepAliveClientMixin {
  List<Map> _menus = [
    {
      "name":"发游记",
      "color":Colors.blue,
      "page":PublicTravelNotePage(),
      "icon":Icons.description,
    },
    {
      "name":"写攻略",
      "color":Colors.red,
      "page":PublicTravelNotePage(),
      "icon":Icons.class_,
    },
    {
      "name":"发求助",
      "color":Colors.green,
      "page":PublicTravelNotePage(),
      "icon":Icons.pan_tool,
    },
    {
      "name":"写分享",
      "color":Colors.orange,
      "page":PublicTravelNotePage(),
      "icon":Icons.extension,
    },
  ];

  List<Tab> _tabs = [
    Tab(
      text: "游记",
    ),
    Tab(
      text: "攻略",
    ),
    Tab(
      text: "求助",
    ),
    Tab(
      text: "分享",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, FoodProvider>(
        builder: (_, themeState, foodState, __) {
      return DefaultTabController(
          length: 4,
          child: GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: () {
              // 触摸收起键盘
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Scaffold(
              floatingActionButton: SpeedDial(
                curve: Curves.easeInCirc,
                closeManually: false,
                overlayColor: Colors.black,
                overlayOpacity: 0.8,
                foregroundColor: Colors.white,
                backgroundColor: Colors.red,
                animatedIcon: AnimatedIcons.add_event,
                animationSpeed: 150,
                elevation: 8.0,
                children:_menus.map((e) => SpeedDialChild(
                    foregroundColor: Colors.white,
                    backgroundColor: e["color"],
                    label: e["name"],
                    child: Icon(e["icon"]),
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>e["page"]));
                    }
                ),).toList()
              ),
              appBar: AppBar(
                elevation: 0,
                title: Text(
                  "圈子",
                  style: TextStyle(
                      fontSize: 26.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2),
                ),
                centerTitle: false,
                bottom: TabBar(
                  tabs: _tabs,
                  isScrollable: false,
                  indicatorColor: Colors.transparent,
                  labelStyle: ThemeConfig.lableStyle,
                  unselectedLabelStyle: ThemeConfig.unselectedLableStyle,
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => SearchPage()));
                      })
                ],
              ),
              body: TabBarView(children: [
                TravelNoteBody(),
                StrategyBody(),
                HelpBody(),
                TrendBody(),
              ]),
            ),
          ));
    });
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}




