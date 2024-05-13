class ImageItem {
  final int? id;
  final int? categoryId;
  final String? tag;
  final String? name;
  final int? type;
  final String? image;
  final String? video;
  final int? like;

  ImageItem({
    this.id,
    this.categoryId,
    this.tag,
    this.name,
    this.type,
    this.image,
    this.video,
    this.like,
  });

  ImageItem.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int?,
        categoryId = json['categoryId'] as int?,
        tag = json['tag'] as String?,
        name = json['name'] as String?,
        type = json['type'] as int?,
        image = json['image'] as String?,
        video = json['video'] as String?,
        like = json['like'] as int?;
}
