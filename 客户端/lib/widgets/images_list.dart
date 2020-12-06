import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wldt/pages/image_page/image_page.dart';
import 'package:wldt/res/global_config.dart';

class ImageListWidget extends StatelessWidget {
  final List<String> images;
  ImageListWidget(this.images);

  Widget _imageWidget(String url, BuildContext context) {
    return InkWell(
      onTap: () {
        int index = images.indexOf(url);
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ImagePage(index: index,images: images,)));
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        margin: EdgeInsets.only(right: 5.0),
        child: CachedNetworkImage(
          imageUrl: url,
          imageBuilder: (context,image)=>Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              image: DecorationImage(image:image,fit: BoxFit.cover)
            ),
          ),
          placeholder: (context,url)=>CupertinoActivityIndicator(),
        )
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 8.0),
        padding: EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0, bottom: 8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              decoration: BoxDecoration(
                  border: Border(
                      left: BorderSide(
                          color: Colors.orange,
                          width: 4.0,
                          style: BorderStyle.solid))),
              child: Text(
                "图集(${images.length})",
                style: TextStyle(
                    fontSize: ThemeConfig.nomalFontSize,
                    fontWeight: FontWeight.bold,
                    decorationStyle: TextDecorationStyle.double,
                    decorationThickness: 2.0,
                    decorationColor: Colors.redAccent,
                    letterSpacing: 3.0),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            Container(
              child: Row(
                  children: <Widget>[
                    Container(
                      width:360,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                images.map((v) => _imageWidget(v,context)).toList(),
                          ),
                        )),
                  ]),
            ),
          ],
        ));
  }
}
