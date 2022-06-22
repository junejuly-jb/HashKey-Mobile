// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
    Category({
        required this.name,
        required this.category,
        required this.icon,
        required this.content,
    });

    String name;
    String category;
    String icon;
    String content;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
        category: json["category"],
        icon: json["icon"],
        content: json["content"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "category": category,
        "icon": icon,
        "content": content,
    };
}
