import 'dart:math';
import 'package:flutter/material.dart';
import 'package:wldt/widgets/cached_image_widget.dart';

class SimpleNews {
  String id;
  String pubDate;
  String desc;
  String title;
  List<String> images;
  String source;

  SimpleNews.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.title = json["title"];
    this.pubDate = json["pubDate"];
    this.desc = json["desc"];
    this.source = json["source"];
    List<String> list = [];
    for (int i = 0; i < min(json["imageurls"].length, 3); i++) {
      list.add(json["imageurls"][i]["url"]);
    }
    this.images = list;
  }
}

class News {
  String id;
  String pubDate;
  List<Widget> content;
  String title;
  List<String> images;
  String source;
  String link;

  News.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.pubDate = json["pubDate"];
    this.title = json["title"];
    this.source = json["source"];
    this.link = json["link"];
    this.content = [];
    for (int i = 0; i < json["allList"].length; i++) {
      if (json["allList"][i].runtimeType == String) {
        this.content.add(Text(
          json["allList"][i],
          style: TextStyle(fontSize: 16.0, color: Colors.black, height: 1.8),
        ));
      }else{
        this.content.add(CachedImageWidget(
          url: json["allList"][i]["url"],
          height: 200,
        ));
      }
    }
  }
}
