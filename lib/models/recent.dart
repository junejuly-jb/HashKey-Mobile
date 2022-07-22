import 'dart:convert';

Recent recentFromJson(String str) => Recent.fromJson(json.decode(str));

String recentToJson(Recent data) => json.encode(data.toJson());

class Recent {
    Recent({
        required this.id,
        required this.credentialType,
        required this.parentId,
        required this.owner,
        required this.name,
        required this.icon,
        required this.createdAt,
        required this.updatedAt,
    });

    String id;
    String credentialType;
    String parentId;
    String owner;
    String name;
    String icon;
    DateTime createdAt;
    DateTime updatedAt;

    factory Recent.fromJson(Map<String, dynamic> json) => Recent(
        id: json["_id"],
        credentialType: json["credential_type"],
        parentId: json["parentID"],
        owner: json["owner"],
        name: json["name"],
        icon: json["icon"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "credential_type": credentialType,
        "parentID": parentId,
        "owner": owner,
        "name": name,
        "icon": icon,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
    };
}
