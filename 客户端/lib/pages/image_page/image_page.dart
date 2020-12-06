import 'package:flutter/material.dart';

class ImagePage extends StatefulWidget {
  final int index;
  final List<String> images;
  ImagePage({this.index, this.images});
  @override
  State<StatefulWidget> createState() => ImagePageState();
}

class ImagePageState extends State<ImagePage> {

  double _curDx;
  int _index;
  int _imageNums;

  @override
  initState() {
    _index = widget.index;
    _imageNums = widget.images.length;
    super.initState();
  }

  Widget _imageWidget(String url, BuildContext context) {
    int curIndex = widget.images.indexOf(url);
    return InkWell(
      onTap: () {
        setState(() {
          _index = widget.images.indexOf(url);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
              color: Colors.red,
              width: 3.0,
              style: _index == curIndex ? BorderStyle.solid : BorderStyle.none),
        ),
        margin: EdgeInsets.only(right: 5.0),
        child:  Container(
          width: 80,
          height: 80,
          child: Image(
            image: NetworkImage(url),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Listener(
      onPointerDown: (e){
        setState(() {
          _curDx = e.position.dx;
        });

      },
      onPointerUp: (e){
        if(e.position.dx - _curDx > 10){
          if(_index>0){
            setState(() {
              _index--;
            });
          }
          return;
        }
        if(e.position.dx - _curDx < -10){
          if(_index < _imageNums-1){
            setState(() {
              _index++;
            });
          }
        }
      },
      child: Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(icon: Icon(Icons.keyboard_backspace,color: Colors.white,), onPressed: (){
          Navigator.of(context).pop();
        }),
      ),
      backgroundColor: Colors.black,
      body: Builder(
        builder: (BuildContext context) => Container(
          width: screenWidth,
          height: screenHeight,
          color: Colors.transparent,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text("${_index + 1}/$_imageNums",style: TextStyle(
                    color: Colors.white
                  ),),
                ),
                Container(
                  width: screenWidth,
                  height: 350,
                  child: Image(
                    image: NetworkImage(widget.images[_index]),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                    width: 380,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: widget.images
                            .map((v) => _imageWidget(v, context))
                            .toList(),
                      ),
                    )),

              ],
            ),
          )
        ),
      ),
    );
  }
}
