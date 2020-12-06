import 'dart:math';

import 'package:wldt/models/comment_model.dart';

class Trend {
  String content; // 文字内容
  String tag;
  String userName; // 发布者用户名
  String userImg; // 发布者头像
  int likeCounts; // 点赞
  List<String> images;
  String publicTime; // 发布时间
  List<TrendComment> comments; // 评论

  Trend.fromJson(Map<String, dynamic> json) {
    this.content = json["content"];
    this.likeCounts = json["likeCounts"];
    this.userName = json["userName"];
    this.publicTime = json["pubDate"];
    this.tag = json["tag"];
    this.userImg = json["userImage"];
    List comments = json["comments"];
    this.comments = [];
    for(int i=0;i<comments.length;i++){
      this.comments.add(TrendComment.fromJson(comments[i]));
    }
    List images = json["images"];
    this.images = [];
    for(int i=0;i<images.length;i++){
      this.images.add(images[i]);
    }
  }
}

class SimpleTrend {
  int id; // id
  String content; // 文字内容
  String userName; // 发布者用户名
  String userImage; // 发布者头像
  int likeCounts; // 点赞
  List<String> images;
  String publicTime; // 发布时间
  int commentCounts; // 评论数
  String tag;

  SimpleTrend.fromJson(Map<String, dynamic> json){
    this.id = json["id"];
    this.tag = json["tag"];
    this.content = json["content"];
    this.likeCounts = json["likeCounts"];
    this.userName = json["userName"];
    this.userImage = json["userImage"];
    this.publicTime = json["pubDate"];
    this.commentCounts = json["commentsCount"];
    List images = json["images"];
    this.images = [];
    for(int i=0;i<min(images.length,3);i++){
      this.images.add(images[i]);
    }
  }


}
