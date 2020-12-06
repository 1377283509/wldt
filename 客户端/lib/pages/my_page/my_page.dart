import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:wldt/pages/signin_page/signin_page.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/providers/user_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/cached_image_widget.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  RefreshController _controller = RefreshController(initialRefresh: true);

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ThemeProvider>(
      builder: (_, userState, themeState, __) {
        return SmartRefresher(
            controller: _controller,
            onRefresh: () async {
              bool res = await userState.launch();
              _controller.refreshCompleted();
            },
            child:Scaffold(
                    appBar: AppBar(
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      title: Text("我的",
                          style: TextStyle(
                              fontSize: 26.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2)),
                    ),
                    body:userState.hasLogin?ListView(
                          children: <Widget>[
                            UserInfoCard(),
                            MenuList(),
                            Container(
                              padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 4.0,bottom: 4.0),
                              margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16)
                              ),
                              child: ListTile(
                                leading: Icon(Icons.settings,color: Colors.black38,),
                                title: Text("设置"),
                                trailing: Icon(Icons.chevron_right),
                              ),
                            ),
                          ],
                    ):LoginButton()
            ));
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class LoginButton extends StatelessWidget {
  const LoginButton({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FlatButton(
          color: Color.fromRGBO(200, 48, 16, 1),
          splashColor: Colors.blue,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: () {
            Navigator.of(context)
                .push(CupertinoPageRoute(builder: (context) => SigninPage()));
          },
          child: Text(
            "登录/注册",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          )),
    );
  }
}

class MenuList extends StatelessWidget {

  List<Map> _menus = [
    {
      "name":"我的收藏",
      "icon":Icons.favorite,
      "color":Colors.red,
      "route":""
    },
    {
      "name":"我的攻略",
      "icon":Icons.class_,
      "color":Colors.blue,
      "route":""
    },
    {
      "name":"我的游记",
      "icon":Icons.description,
      "color":Colors.green,
      "route":""
    },
    {
      "name":"我的分享",
      "icon":Icons.extension,
      "color":Colors.orange,
      "route":""
    },
    {
      "name":"我的求助",
      "icon":Icons.pan_tool,
      "color":Colors.red,
      "route":""
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 4.0,bottom: 4.0),
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        children: _menus.map((e) => ListTile(
          leading: Icon(e["icon"],color: e["color"],),
          title: Text(e["name"]),
          trailing: Icon(Icons.chevron_right,color: Colors.black38,),
        )).toList(),
      ),
    );
  }
}


class UserInfoCard extends StatelessWidget {
  const UserInfoCard({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 4.0,bottom: 4.0),
      margin: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        children: <Widget>[
          CardTop()
        ],
      ),
    );
  }
}



class CardTop extends StatelessWidget {
  const CardTop({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (_, userState, __) {
        return Container(
          child: ListTile(
              leading: CachedImageWidget(
                width: 50,
                height: 50,
                borderRadius: BorderRadius.circular(50),
                url: userState.user.imgUrl,
              ),
              title: Text(userState.user.name),
            subtitle: Text(userState.user.birth,style: TextStyle(
                fontSize: ThemeConfig.smallFontSize
            ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.keyboard_arrow_right),
              onPressed: (){},
            ),
          ),
        );
      },
    );
  }
}
