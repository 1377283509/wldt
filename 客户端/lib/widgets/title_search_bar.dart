import 'package:flutter/material.dart';
import 'package:wldt/res/global_config.dart';

class TitleSearchBar extends StatelessWidget{
  final TextEditingController controller;
  final String title;
  TitleSearchBar(this.controller,{this.title="搜索"});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 35,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            color: Colors.grey[200], borderRadius: BorderRadius.circular(50)),
        child: TextField(
          autofocus: false,
          controller: controller,
          decoration: InputDecoration(
            hintText: title,
            hintStyle: TextStyle(
                fontSize: ThemeConfig.nomalFontSize, color: Colors.grey),
            contentPadding: EdgeInsets.zero,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black54,
              size: ThemeConfig.smallIconSize,
            ),
            border: InputBorder.none,
            focusColor: Colors.black,
          ),
        ),
      ),
    );
  }

}