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

  Post(this.id, this.title, this.text, this.by, this.type, this.kids, this.time,
      this.parent, this.isFavorite, this.dead, this.deleted);

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
}
