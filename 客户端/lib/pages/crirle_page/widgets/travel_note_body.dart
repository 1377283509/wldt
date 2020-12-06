import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:toast/toast.dart';
import 'package:wldt/models/travel_note_model.dart';
import 'package:wldt/pages/travel_note_page/travel_note_details_page.dart';
import 'package:wldt/providers/travel_note_provider.dart';
import 'package:wldt/widgets/cached_image_widget.dart';

class TravelNoteBody extends StatelessWidget {
  RefreshController _controller = RefreshController(initialRefresh: true);
  @override
  Widget build(BuildContext context) {
    return Consumer<TravelNoteProvider>(
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
                children: pageState.travelNoteList
                    .map((e) => TravelNoteCard(e))
                    .toList(),
              )))),
        );
      },
    );
  }
}

class TravelNoteCard extends StatelessWidget {
  final SimpleTravleNote note;
  TravelNoteCard(this.note);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 4.0),
      child: Card(
        child: Column(
          children: <Widget>[
            CardHeader(
              userImage: note.userImage,
              userName: note.userName,
//              image: note.image,
              pubDate: note.pubDate,
              likeCounts: note.likeCounts,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(bottom: 6.0,left: 16.0,right: 16.0),
              child: Text("#\t\t${note.title}",style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
              ),),
            ),
            InkWell(
              onTap: (){
                Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>TravelNoteDetailsPage(note.id)));
              },
              child: CachedNetworkImage(
                imageUrl: note.image,
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


class CardHeader extends StatelessWidget {
  final String userImage;
  final String userName;
  final String pubDate;
  final int likeCounts;
  CardHeader({this.userImage,this.userName,this.likeCounts, this.pubDate = ""});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        leading: Container(
          width: 38,
          height: 38,
          child: CachedImageWidget(
            width: 38,
            height: 38,
            borderRadius: BorderRadius.circular(50),
            url: userImage,
          ),
        ),
        title: Text(userName,style: TextStyle(fontSize: 14.0),),
        subtitle: Text(
          pubDate,
          style: TextStyle(color: Colors.black45, fontSize: 12.0),
        ),
        trailing: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                Icons.favorite,
                color: Colors.red,
                size: 18.0,
              ),
              SizedBox(width: 4.0,),
              Text("${likeCounts}",style: TextStyle(
                  fontSize: 12.0,color: Colors.black45
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
