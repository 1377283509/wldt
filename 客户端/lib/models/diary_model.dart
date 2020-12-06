class Diary{
  String content;
  String image;
  String pubDate;
  String userName;
  String userImage;
  int likeCount;

  Diary.fromJson(Map<String, dynamic> json)
    : content = json["content"],
      image = json["image"],
      userName = json["userName"],
      userImage = json["userImage"],
      likeCount = json["likeCount"],
      pubDate = json["pubDate"];
}