import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CachedImageWidget extends StatelessWidget {
  @required
  final double width;
  @required
  final double height;
  @required
  final String url;
  final BorderRadius borderRadius;

  CachedImageWidget(
      {this.width,
      this.height,
      this.url,
      this.borderRadius = BorderRadius.zero});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: url,
      imageBuilder: (context, imageProvider) => Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              image: DecorationImage(image: imageProvider, fit: BoxFit.cover))),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        alignment: Alignment.center,
        child: CupertinoActivityIndicator(),
      ),
      errorWidget: (context, url, error) => Icon(Icons.error),
    );
  }
}
