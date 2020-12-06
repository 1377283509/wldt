import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wldt/pages/image_page/image_page.dart';

class ImageCard extends StatelessWidget{

  final List<String> images;
  final String url;

  ImageCard(this.images,this.url);

  @override
  Widget build(BuildContext context) {
    int curIndex = images.indexOf(url);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) => new ImagePage(
              index: curIndex,
              images: images,
            )));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4.0),
        width: 80,
        height: 80,
        child: CachedNetworkImage(imageUrl: url,placeholder: (context,url)=>CupertinoActivityIndicator(),),
      ),
    );
  }
}