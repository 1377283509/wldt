import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/comment_model.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/image_card.dart';
import 'package:wldt/widgets/star_widet.dart';


class CommentWidget extends StatelessWidget {
  final Comment comment;
  final Color color;
  CommentWidget(this.comment, {this.color});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(
        8.0,
      ),
      margin: EdgeInsets.only(top: 4.0, bottom: 4.0),
      decoration: BoxDecoration(
        color:color?? Colors.grey[100],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 用户头
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding:EdgeInsets.only(top: 2.0,left: 2.0,right: 8.0,bottom: 2.0),
                  decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 30,
                        height: 30,
                        margin: EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            image: DecorationImage(
                                image: NetworkImage(comment.usrImgUrl))),
                      ),
                      Text(comment.userName,style: TextStyle(fontSize: ThemeConfig.smallFontSize),),
                    ],
                  ),
                ),
               Container(
                 padding: EdgeInsets.only(right: 10.0),
                 child:  Text(
                   comment.publicTime,
                   style: TextStyle(
                       color: Colors.grey, fontSize: ThemeConfig.smallFontSize),
                 ),
               ),
              ],
            ),
          ),

          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 8.0),
            child: Text(comment.content),
          ),
          SizedBox(
            height: 8.0,
          ),
          comment.images.length == 0
              ? Container()
              : Container(
            child: Wrap(
              children: comment.images
                  .map((e) => ImageCard(comment.images, e))
                  .toList(),
            ),
          ),
          StarWidget(double.parse(comment.stars)),
        ],
      ),
    );
  }
}
