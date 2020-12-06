import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:wldt/models/travel_note_model.dart';
import 'package:wldt/res/urls.dart';

class TravelNoteProvider with ChangeNotifier{

  List<SimpleTravleNote> _travelNoteList = [];
  List<SimpleTravleNote> get travelNoteList => _travelNoteList;

  TravelNote _note;
  TravelNote get note => _note;

  List<String> _images = [];
  List<String> get images => _images;

  List<String> _tags = [];
  List<String> get tags => _tags;

  Future<bool> getTravelNoteById(int id)async{
    Dio dio = new Dio(Http.options);
    _images.clear();
    _tags.clear();
    try{
      Response response = await dio.get(TravelNoteUrl.getTravelNoteById,queryParameters: {"id":id});
      if (response.statusCode == 200) {
        var data = response.data["data"];
        _note = TravelNote.fromJson(data["travel_note"]);
        for(int i=0;i<data["images"].length;i++){
          _images.add(data["images"][i]);
        }
        for(int i=0;i<data["tags"].length;i++){
          _tags.add(data["tags"][i]);
        }
        return true;
      }
      return false;
    }catch(e){
      return false;
    }

  }

  Future<bool> getAllData()async{
    Dio dio = new Dio(Http.options);
    _travelNoteList.clear();
    try{
      Response response = await dio.get(TravelNoteUrl.getAllTravelNote);
      if (response.statusCode == 200) {
        var data = response.data["data"];
        for (int i = 0; i < data.length; i++) {
          _travelNoteList.add(SimpleTravleNote.fromJson(data[i]));
        }
        notifyListeners();
        return true;
      }
      return false;
    }catch(e){
      return false;
    }
  }
}