// 页面菜单
import 'package:flutter/material.dart';
import 'package:wldt/res/global_config.dart';

class PageMenu extends StatelessWidget {
  final List<Menu> menus;
  const PageMenu({this.menus, key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12, left:24, right:24, bottom: 12),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: menus.map((e) => MenuItemWidget(menu: e)).toList(),
      ),
    );
  }
}

class MenuItemWidget extends StatelessWidget {
  final Menu menu;
  const MenuItemWidget({this.menu, key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
        splashColor: Colors.grey,
        onTap: () {
          Navigator.of(context).pushNamed(menu.routName);
        },
        child: Column(
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50), color: menu.color),
              child: Icon(
                menu.icon,
                color: Colors.white,
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                menu.text,
                style: TextStyle(
                    fontSize: ThemeConfig.smallFontSize, color: Colors.black54,letterSpacing: 2),
              ),
            )
          ],
        ));
  }
}

class Menu {
  // 图标
  IconData icon;
  // 图标背景颜色
  Color color;
  // 名字
  String text;
  // 跳转页面
  String routName;

  Menu({this.icon, this.color, this.text, this.routName});
}

