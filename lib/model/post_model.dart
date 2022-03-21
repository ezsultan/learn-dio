class Post {
  int id;
  String title;
  String body;
  int userId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userId: json["userId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "userId": userId,
      };

  static List<Post> listFromJson(List<dynamic> list) =>
      List<Post>.from(list.map((item) => Post.fromJson(item)));
}
