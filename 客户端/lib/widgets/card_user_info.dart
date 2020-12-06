// 底部用户信息
import 'package:flutter/material.dart';
import 'package:wldt/res/global_config.dart';

class BottomInfo extends StatelessWidget {
  final String userName;
  final String userImgUrl;
  final int likeNums;
  BottomInfo(this.userImgUrl, this.userName, this.likeNums, {Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(left: 4, right: 8),
        color: Colors.white,
        child: Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: <Widget>[
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(userImgUrl), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(30)),
            ),
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.only(left: 8),
                child: Text(
                  userName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: Colors.grey,
                      fontSize: ThemeConfig.nomalFontSize,),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.favorite_border,
                    size: ThemeConfig.smallIconSize,
                    color: Colors.red,
                  ),
                  Text(
                    likeNums.toString(),
                    style: TextStyle(
                        fontSize: ThemeConfig.smallFontSize,
                        color: Colors.grey
                        ),
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
