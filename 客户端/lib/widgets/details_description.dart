import 'package:flutter/material.dart';
import 'package:wldt/res/global_config.dart';

class DetailsDescription extends StatefulWidget {
  final String title;
  final String content;
  final bool isExpanded;
  DetailsDescription({this.title, this.content, this.isExpanded = false});

  @override
  State<StatefulWidget> createState() => DetailsDescriptionState();
}

class DetailsDescriptionState extends State<DetailsDescription> {
  bool _isExpanded;
  @override
  void initState() {
    _isExpanded = widget.isExpanded;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.only(left: 8.0, right: 8.0, top: 4.0, bottom: 4.0),
      padding: EdgeInsets.only(left: 12.0, right: 12.0, top: 8.0, bottom: 4.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12), color: Colors.white),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // 标题
          widget.title == null
              ? SizedBox(
                  height: 0,
                )
              : Container(
                  padding: EdgeInsets.only(left: 8.0),
                  decoration: BoxDecoration(
                      border: Border(
                          left: BorderSide(
                              color: Colors.orange,
                              width: 4.0,
                              style: BorderStyle.solid))),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    widget.title,
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
            height: 18.0,
          ),
          // 内容
          _isExpanded
              ? Container(
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.content,
                      softWrap: true,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    InkWell(
                      onTap: () {
                        setState(() {
                          _isExpanded = !_isExpanded;
                        });
                      },
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                "收起",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: ThemeConfig.smallFontSize),
                              ),
                              Icon(Icons.expand_less),
                            ],
                          )),
                    )
                  ],
                ))
              : Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.content,
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            _isExpanded = !_isExpanded;
                          });
                        },
                        child: Container(
                            alignment: Alignment.centerRight,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Text(
                                  "展开",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontSize: ThemeConfig.smallFontSize),
                                ),
                                Icon(Icons.expand_more),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
