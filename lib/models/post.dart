import 'dart:convert';

class Post {
  int id;
  String? title;
  String? text;
  String? by;
  String type;
  List<int>? kids;
  int time;
  int? parent;
  bool? isFavorite;
  bool? dead;
  bool? deleted;
  DateTime? createdAt;
  DateTime? addedFavAt;

  Post(
      this.id,
      this.title,
      this.text,
      this.by,
      this.type,
      this.kids,
      this.time,
      this.parent,
      this.isFavorite,
      this.dead,
      this.deleted,
      this.createdAt,
      this.addedFavAt);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "text": text,
        "by": by,
        "type": type,
        "kids": kids,
        "time": time,
        "parent": parent,
        "isFavorite": isFavorite,
        "dead": dead,
        "deleted": deleted,
      };

  Post.fromMap(Map<String, dynamic> data)
      : id = data["id"],
        title = data["title"],
        text = data["text"],
        by = data["by"],
        type = data["type"],
        kids = data["kids"] == null ? null : List<int>.from(data["kids"]),
        time = data["time"],
        parent = data["parent"],
        isFavorite = data["isFavorite"],
        dead = data["dead"],
        deleted = data["deleted"];

  Map<String, dynamic> toMapSqlite() => {
        "id": id,
        "title": title,
        "text": text,
        "by": by,
        "type": type,
        "kids": jsonEncode(kids),
        "time": time,
        "parent": parent,
        "isFavorite": isFavorite,
        "dead": dead,
        "deleted": deleted,
        "createdAt": createdAt?.millisecondsSinceEpoch,
        "addedFavAt": addedFavAt?.millisecondsSinceEpoch,
      };

  Post.fromMapSqlite(Map<String, dynamic> data)
      : id = data["id"],
        title = data["title"],
        text = data["text"],
        by = data["by"],
        type = data["type"],
        kids = jsonDecode(data["kids"]) == null
            ? null
            : List<int>.from(jsonDecode(data["kids"])),
        time = data["time"],
        parent = data["parent"],
        isFavorite = data["isFavorite"] == 1 ? true : false,
        dead = data["dead"] == 1 ? true : false,
        deleted = data["deleted"] == 1 ? true : false,
        createdAt = data['createdAt'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(data['createdAt']),
        addedFavAt = data['addedFavAt'] == null
            ? null
            : DateTime.fromMillisecondsSinceEpoch(data['addedFavAt']);
}
