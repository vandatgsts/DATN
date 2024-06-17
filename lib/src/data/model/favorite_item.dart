import 'dart:typed_data';

class FavoriteItem {
  final String id;
  bool isFavorite;
  final Uint8List image;

  FavoriteItem({
    required this.id,
    required this.isFavorite,
    required this.image,
  }); // Tạo id mới nếu id không được cung cấp

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'isFavorite': isFavorite ? 1 : 0, // SQLite does not have boolean type
      'image': image,
    };
  }

  static FavoriteItem fromMap(Map<String, dynamic> map) {
    return FavoriteItem(
      id: map['id'],
      isFavorite: map['isFavorite'] == 1, // Convert int to bool
      image: map['image'],
    );
  }
}
