import 'package:flutter/material.dart';
import 'package:wldt/models/comment_model.dart';

class CommentsProvider with ChangeNotifier{

  List<Comment> _curComments;
  List<Comment> get curComments =>_curComments;

  Future<void> setData(List<Comment> comments){
    _curComments = comments;
  }

  void getData(int index,List<Comment> comments){
    if(index==2){
      for(int i=0;i<comments.length;i++){
        if(comments[i].isGood == true){
          _curComments.add(comments[i]);
        }
      }
    }
    if(index ==3){
      for(int i=0;i<comments.length;i++){
        if(comments[i].isGood == false){
          _curComments.add(comments[i]);
        }
      }
    }
    notifyListeners();
  }



}