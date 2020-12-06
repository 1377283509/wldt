import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:wldt/models/strategy_model.dart';
import 'package:wldt/pages/crirle_page/widgets/travel_note_body.dart';
import 'package:wldt/pages/strategy_page/strategy_details_page.dart';
import 'package:wldt/providers/strategy_page_provider.dart';

class StrategyBody extends StatelessWidget {
  RefreshController _controller = RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Consumer<StrategyProvider>(
      builder: (_, pageState, __) {
        return Theme(
          data: ThemeData(
              primaryColor: Color.fromRGBO(200, 48, 16, 1),
              backgroundColor: Colors.white),
          child: SmartRefresher(
              controller: _controller,
              onRefresh: () async {
                bool res = await pageState.getAllData();
                if (!res) {
                  Toast.show("加载失败", context);
                }
                _controller.refreshCompleted();
              },
              child: SafeArea(
                  child: SingleChildScrollView(
                      child: Column(
                        children: pageState.list
                            .map((e) => StrategyCard(e))
                            .toList(),
                      )))),
        );
      },
    );
  }
}

class StrategyCard extends StatelessWidget {
  final SimpleStrategy strategy;
  StrategyCard(this.strategy);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.0),
      child: Card(
        child: Column(
          children: <Widget>[
            CardHeader(
              userImage: strategy.userImage,
              userName: strategy.userName,
//              image: strategy.image,
              pubDate: strategy.pubDate,
              likeCounts: strategy.likeCounts,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 6.0,left: 16.0,right: 16.0),
              child: Text("#\t\t${strategy.title}",style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              ),),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>StrategyDetailsPage(strategy.id)));
              },
              child: CachedNetworkImage(
                imageUrl: strategy.image,
                placeholder: (context, url) => Container(
                  alignment: Alignment.center,
                  color: Colors.grey,
                  child: CupertinoActivityIndicator(),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            )
          ],
        ),
      ),
    );
  }
}

