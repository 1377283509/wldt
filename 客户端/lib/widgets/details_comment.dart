import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/comment_model.dart';
import 'package:wldt/pages/comments_page/comments_page.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/comment_card.dart';


// 相关评论

class DetailsComment extends StatelessWidget {
  final List<Comment> comments;
  final int commentsNumber;

  DetailsComment(this.comments,this.commentsNumber);
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(10, 8.0, 10.0, 8.0),
        margin: EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 8.0),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(color: Colors.orange, width: 4.0))),
              child: Text(
                "用户评论($commentsNumber)",
                style: TextStyle(
                    fontSize: ThemeConfig.nomalFontSize,
                    fontWeight: FontWeight.bold,
                    decorationStyle: TextDecorationStyle.double,
                    decorationThickness: 2.0,
                    decorationColor: Colors.redAccent,
                    letterSpacing: 3.0),
              ),
            ),

            // 评论
            commentsNumber == 0?Container(alignment: Alignment.center,child: FlatButton(child:Text("暂无评论，点击添加一个吧！",textAlign: TextAlign.center,),onPressed: (){
              // TODO:跳转我的评论页
            },),):Container(
              margin: EdgeInsets.only(top: 8.0),
              child: Column(
                children: comments.map((e) => CommentWidget(e)).toList(),
              ),
            ),

            // 更多
            commentsNumber == 0?Container():Container(
              alignment: Alignment.center,
              child: FlatButton(
                  splashColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (context) => CommentsPage(comments)));
                  },
                  child: Text(
                    "全部评论 >>",
                    style: TextStyle(
                      color: Colors.orange,
                    ),
                  )),
            ),
          ],
        ));
  }
}

