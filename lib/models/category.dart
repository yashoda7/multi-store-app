import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Category {
  final String id;
  final String name;
  final String image;
  final String banner;
  const Category({
    required this.id,
    required this.name,
    required this.image,
    required this.banner,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'banner': banner,
    };
  }

  factory Category.fromJson(Map<String, dynamic> map) {
    return Category(
      id: (map["_id"] ?? '') as String,
      name: (map["name"] ?? '') as String,
      image: (map["image"] ?? '') as String,
      banner: (map["banner"] ?? '') as String,
    );
  }

  String toJson() => json.encode(toMap());

  // factory Category.fromJson(String source) => Category.fromMap(json.decode(source) as Map<String, dynamic>);
}
