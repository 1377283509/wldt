class SimpleTravleNote {
  int id; // id
  String title; // 标题
  String image; // 配图
  String userName; // 用户名
  String userImage; // 用户头像
  int likeCounts; // 喜欢数量
  String pubDate;

  SimpleTravleNote.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.title = json["title"];
    this.image = json["image"];
    this.userName = json["userName"];
    this.userImage = json["userImage"];
    this.likeCounts = json["likeCounts"];
    this.pubDate = json["pubDate"];
  }
}

class TravelNote{
  int id; // id
  String title; // 标题
  String image; // 配图
  String userName; // 用户名
  String userImage; // 用户头像
  int likeCounts; // 喜欢数量
  String content; // 内容
  String address;
  String pubDate;

  TravelNote.fromJson(Map<String, dynamic> json) {
    this.id = json["id"];
    this.title = json["title"];
    this.image = json["image"];
    this.userName = json["userName"];
    this.userImage = json["userImage"];
    this.likeCounts = json["likeCounts"];
    this.content = json["content"];
    this.address = json["address"];
    this.pubDate = json["pubDate"];
  }
}
