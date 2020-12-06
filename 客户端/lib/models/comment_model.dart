class Comment {
  int id; // 评论id
  int userId; //评论用户id
  String content; // 评论内容
  String usrImgUrl; // 用户头像
  String userName; // 用户名
  String publicTime; // 评论时间
  String stars; // 星数
  bool isGood; // 好评还是差评
  bool isQuality; // 是否是优质评论
  List<String> images;

  Comment.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        userId = json["user_id"],
        content = json["content"],
        userName = json["user_name"],
        usrImgUrl = json["user_img"],
        publicTime = json["publicTime"],
        stars = json["stars"],
        isQuality = json["isQuality"],
        isGood = json["isGood"];

  Comment(
      {this.id,
      this.userId,
      this.content,
      this.userName,
      this.usrImgUrl,
      this.publicTime,
      this.stars,
      this.isGood,
      this.isQuality});
}


class TrendComment {
  List<String> images;
  String content; // 评论内容
  String userImage; // 用户头像
  String userName; // 用户名
  String publicTime; // 评论时间
  int likeCounts; // 点赞数

  TrendComment.fromJson(Map<String, dynamic> json){
    this.content = json["content"];
    this.userImage = json["userImage"];
    this.publicTime = json["pubDate"];
    this.likeCounts = json["likeCounts"];
    this.userName = json["userName"];
    List images = json["images"];
    this.images = [];
    for(int i=0;i<images.length;i++){
      this.images.add(images[i]);
    }
  }
}
