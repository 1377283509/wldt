import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:wldt/providers/diary_providers.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/diary_card.dart';

class DiaryListPage extends StatefulWidget {
  @override
  _DiaryListPageState createState() => _DiaryListPageState();
}

class _DiaryListPageState extends State<DiaryListPage> {

  RefreshController _controller = RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("小记广场",style: TextStyle(fontSize: ThemeConfig.larggerFontSize),),
        automaticallyImplyLeading: true,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: (){},
          )
        ],
      ),
      body: Consumer2<ThemeProvider,DiaryProvider>(
        builder: (_, themeState,pageState,__) {
          return Theme(
            data: ThemeData(
                primaryColor: Color.fromRGBO(200, 48, 16, 1),
                backgroundColor: Colors.white),
            child: SmartRefresher(
                controller: _controller,
                onRefresh: () async {
                  bool res = await pageState.getAllDiary();
                  if (!res) {
                    Toast.show("加载失败", context);
                  }
                  _controller.refreshCompleted();
                },
                child: AllDiaryList()),
          );
        },
      ),
    );
  }
}


// 所有小记页面
class AllDiaryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DiaryProvider>(
      builder: (_, pageState, __) {
        return Container(
          padding: EdgeInsets.only(bottom: 12.0,left: 12.0,right: 12.0),
          child: Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.start,
            children: pageState.diaryList.map((f) => DiaryCard(f)).toList(),
          ),
        );
      },
    );
  }
}

