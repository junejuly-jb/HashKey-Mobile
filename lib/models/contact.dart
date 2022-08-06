import 'dart:convert';

Contact contactFromJson(String str) => Contact.fromJson(json.decode(str));

String contactToJson(Contact data) => json.encode(data.toJson());

class Contact {
    Contact({
        required this.contactId,
        required this.contactFname,
        required this.contactLname,
        required this.contactNumber,
        required this.contactEmail,
        required this.contactAvatarColor,
    });

    String contactId;
    String contactFname;
    String contactLname;
    String contactNumber;
    String contactEmail;
    String contactAvatarColor;

    factory Contact.fromJson(Map<String, dynamic> json) => Contact(
        contactId: json["contact_id"],
        contactFname: json["contact_fname"],
        contactLname: json["contact_lname"],
        contactNumber: json["contact_number"],
        contactEmail: json["contact_email"],
        contactAvatarColor: json["contact_avatar_color"],
    );

    Map<String, dynamic> toJson() => {
        "contact_id": contactId,
        "contact_fname": contactFname,
        "contact_lname": contactLname,
        "contact_number": contactNumber,
        "contact_email": contactEmail,
        "contact_avatar_color": contactAvatarColor,
    };
}
