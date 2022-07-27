import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
    Category({
        required this.name,
        required this.category,
        required this.icon,
        required this.content,
        required this.count,
    });

    String name;
    String category;
    String icon;
    String content;
    int count;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        category: json["category"],
        icon: json["icon"],
        content: json["content"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "category": category,
        "icon": icon,
        "content": content,
        "count": count,
    };
}
