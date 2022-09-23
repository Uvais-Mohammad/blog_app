import 'dart:convert';

class Blog {
  
  final String title;
  final String content;
  final String? image;
  final String category;

  Blog({
    required this.title,
    required this.content,
    this.image,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'content': content,
      'image': image,
      'category': category,
    };
  }

  factory Blog.fromMap(Map<String, dynamic> map) {
    return Blog(
      title: map['title'] as String,
      content: map['content'] as String,
      image: map['image'] != null ? map['image'] as String : null,
      category: map['category'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Blog.fromJson(String source) =>
      Blog.fromMap(json.decode(source) as Map<String, dynamic>);
}
