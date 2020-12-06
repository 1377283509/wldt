import 'package:flutter/material.dart';
import 'package:wldt/pages/crirle_page/circle_index_page.dart';
import 'package:wldt/pages/datong_page/datong_index_page.dart';
import 'package:wldt/pages/diary_page/diary_index_page.dart';
import 'package:wldt/pages/my_page/my_page.dart';
import 'package:wldt/res/global_config.dart';


// 首页
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with AutomaticKeepAliveClientMixin {
  int _curIndex = 0;
  final List<Widget> _pages = [
    DiaryIndexPage(),
    DaTongIndexPage(),
    CircleIndexPage(),
    MyPage()
  ];

  final List _items = [
    Icons.date_range,
    Icons.layers,
    Icons.camera,
    Icons.person
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:IndexedStack(
        index: _curIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 24.0,
        type: BottomNavigationBarType.fixed,
        selectedIconTheme:
            IconThemeData(color: Color.fromRGBO(216,96,80,1),size: ThemeConfig.largeIconSize),
        unselectedIconTheme:
            IconThemeData(color: Colors.grey,size: ThemeConfig.nomalIconSize),
        items: _items
            .map((e) => BottomNavigationBarItem(title: Text(""), icon: Icon(e)))
            .toList(),
        currentIndex: _curIndex,
        onTap: (index) {
          setState(() {
            _curIndex = index;
          });
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
