class TouristAttraction {
  int id;
  String name;
  String position;
  int averageConsumption;
  String description;
  String openDate;
  String openTime;
  String ticketInfo;
  String useTime;
  String busInfo;
  String bestTime;
  String tips;
  String score;
  int commentNumber;
  int positiveCommentNumber;
  int negativeCommentNumber;
  bool isLike;


  TouristAttraction.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        position = json["position"],
        averageConsumption = json["averageConsumption"],
        description = json["description"],
        openDate = json["openDate"],
        openTime = json["openTime"],
        ticketInfo = json["ticketInfo"],
        useTime = json["useTime"],
        busInfo = json["busInfo"],
        bestTime = json["bestTime"],
        tips = json["tips"],
        score = json["score"],
        isLike = json["isLike"],
        commentNumber = json["commentNumber"],
        positiveCommentNumber = json["positiveCommentNumber"],
        negativeCommentNumber = json["negativeCommentNumber"];
}

class TouristSpot {
  int id;
  String name;
  String position;
  String description;
  String openDate;
  String openTime;
  String history;
  String feature;
  String artistCharm;
  String score;
  int commentNumber;
  int positiveCommentNumber;
  int negativeCommentNumber;

  TouristSpot.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        position = json["position"],
        description = json["description"],
        openDate = json["openDate"],
        openTime = json["openTime"],
        history = json["history"],
        feature = json["feature"],
        artistCharm = json["artistCharm"]
  ;
}

class SimpleTouristAttraction {
  int id;
  String name;
  String position;
  String tag;
  int averageConsumption;
  String score;
  int commentNumber;
  String image;
  SimpleTouristAttraction.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        position = json["position"],
        tag = json["tag"],
        averageConsumption = json["averageConsumption"],
        score = json["score"],
        commentNumber = json["commentNumber"],
        image = json["image"];
}

class SimpleTouristSpot {
  int id;
  String name;
  String image;

  SimpleTouristSpot.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        name = json["name"],
        image = json["image"];
}
