import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wldt/models/tourist_spot_model.dart';
import 'package:wldt/providers/theme_provider.dart';
import 'package:wldt/res/global_config.dart';
import 'package:wldt/widgets/tag_widget.dart';
import '../tourist_attraction_details.dart';

class TouristAttractionCard extends StatelessWidget {
  final SimpleTouristAttraction touristAttraction;
  TouristAttractionCard(this.touristAttraction);
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (_, themeState, __) {
        return InkWell(
          onTap: () {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (context) =>
                    TouristAttractionDetailsPage(touristAttraction.id)));
          },
          child: AspectRatio(
            aspectRatio: 3.0,
            child: Container(
                 padding: EdgeInsets.only(left: 8.0, right: 8.0,top: 4.0,bottom: 4.0),
              margin: EdgeInsets.only(top: 4.0, left: 8.0, right: 8.0,bottom: 4.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  // 图片
                  Container(
                      height: .28 * MediaQuery.of(context).size.width,
                      width: .28 * MediaQuery.of(context).size.width,
                      child: Image(
                        image: NetworkImage(
                          touristAttraction.image,
                        ),
                        fit: BoxFit.cover,
                      )),

                  SizedBox(
                    width: 12.0,
                  ),
                  // 右侧信息
                  Container(
                    width: .56 * MediaQuery.of(context).size.width,
                    height: .3 * MediaQuery.of(context).size.width,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child: Text(
                            touristAttraction.name,
                            style: TextStyle(
                                fontSize: ThemeConfig.larggerFontSize,
                                fontWeight: FontWeight.bold),
                          ),
                        ),

                        touristAttraction.tag == null
                            ? SizedBox(
                                height: 0,
                              )
                            : TagWidget(touristAttraction.tag),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text(
                                "${touristAttraction.score}分",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: ThemeConfig.smallFontSize,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 6.0,
                              ),
                              Text(
                                "${touristAttraction.commentNumber}条评论",
                                style: TextStyle(
                                    fontSize: ThemeConfig.smallFontSize,
                                    color: Colors.grey),
                              )
                            ],
                          ),
                        ),

                        // 标签
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                child: Container(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Container(
                                          child: Icon(
                                        Icons.location_on,
                                        color: Colors.grey,
                                        size: ThemeConfig.smallIconSize,
                                      )),
                                      Container(
                                          width: 130,
                                          child: Text(
                                            "${touristAttraction.position}",
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize:
                                                  ThemeConfig.smallFontSize,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                  child: Text(
                                "${touristAttraction.averageConsumption}￥起",
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
