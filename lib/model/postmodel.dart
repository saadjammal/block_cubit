class PostModel {
  String? imageUrl;

  PostModel({required this.imageUrl});

  PostModel.fromMap(Map<String, dynamic> map) {
    imageUrl = map['imageUrl'];
  }

  Map<String, dynamic> toMap() {
    return {
      'imageUrl':imageUrl,
    };
  }
}
