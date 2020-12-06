import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/tourist_spot_model.dart';
import 'package:wldt/pages/tourist_page/tourist_attraction_details.dart';

class ScenicList extends StatelessWidget {
  final List<SimpleTouristAttraction> list;
  const ScenicList({this.list, key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.only(left: 8.0, right: 8.0),
        decoration: BoxDecoration(
            color: Colors.transparent, borderRadius: BorderRadius.circular(12)),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: list.map((e) => ScenicImage(e)).toList(),
          ),
        ));
  }
}

class ScenicImage extends StatelessWidget {
  final SimpleTouristAttraction touristAttraction;
  const ScenicImage(this.touristAttraction, {Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(CupertinoPageRoute(
            builder: (context) =>
                TouristAttractionDetailsPage(touristAttraction.id)));
      },
      child: Container(
          width: 200,
          height: 300,
          alignment: Alignment.bottomLeft,
          margin: EdgeInsets.only(right: 8.0),
          padding: EdgeInsets.only(left: 8.0, bottom: 6.0, right: 0.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.0),
              image: DecorationImage(
                  image: NetworkImage(
                    touristAttraction.image,
                  ),
                  fit: BoxFit.cover)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black26,
                ),
                child: Text(
                  "# ${touristAttraction.name}",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 2.0),
                padding: EdgeInsets.fromLTRB(6.0, 2.0, 6.0, 4.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.black26,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                  Icon(Icons.location_on,color: Colors.white,size: 16,),
                  Container(width: 4,),
                  Text(
                  "${touristAttraction.position}",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                ],)
              )
            ],
          )),
    );
  }
}
