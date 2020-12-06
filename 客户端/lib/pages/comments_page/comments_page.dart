import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/models/comment_model.dart';
import 'package:wldt/providers/comments_provider.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/comment_card.dart';

// 评论页

class CommentsPage extends StatelessWidget {
  final List<Comment> comments;
  CommentsPage(this.comments);
  List<Tab> _tabs = [
    Tab(
      text: "全部",
    ),
    Tab(
      text: "优质评论",
    ),
    Tab(
      text: "好评",
    ),
    Tab(
      text: "差评",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, CommentsProvider>(
      builder: (_, themeState, commentsState, __) {
        return FutureBuilder(
            future: commentsState.setData(comments),
            builder: (context, snapshot) {
              return DefaultTabController(
                length: 4,
                child: Scaffold(
                    appBar: AppBar(
                        elevation: 0,
                        title: Text(
                          "全部评论",
                          style: TextStyle(
                              fontSize: ThemeConfig.nomalFontSize,
                              fontWeight: FontWeight.bold),
                        ),
                        actions: <Widget>[
                          FlatButton(onPressed: (){
                            // TODO: 我的评论
                          }, child: Text("我的评论"))
                        ],
                        bottom: TabBar(
                          tabs: _tabs,
                          indicatorColor: Colors.orange,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorWeight: 3.0,
                        )),
                    body: TabBarView(children: [
                      CommentsPageBody(0),
                      CommentsPageBody(1),
                      CommentsPageBody(2),
                      CommentsPageBody(3),

                    ])),
              );
            });
      },
    );
  }
}

class CommentsPageBody extends StatelessWidget {

  final int tag;
  CommentsPageBody(this.tag);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeProvider, CommentsProvider>(
      builder: (_, themeState, commentsState, __) {
        return SingleChildScrollView(
            child: Column(
                children: commentsState.curComments
                    .map((e) => CommentWidget(
                          e,
                          color: Colors.white,
                        ))
                    .toList()));
      },
    );
  }
}
