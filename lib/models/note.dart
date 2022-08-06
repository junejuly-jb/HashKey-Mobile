import 'dart:convert';

Note noteFromJson(String str) => Note.fromJson(json.decode(str));

String noteToJson(Note data) => json.encode(data.toJson());

class Note {
    Note({
        required this.noteId,
        required this.noteTitle,
        required this.noteContent,
        required this.noteColor,
    });

    String noteId;
    String noteTitle;
    String noteContent;
    String noteColor;

    factory Note.fromJson(Map<String, dynamic> json) => Note(
        noteId: json["note_id"],
        noteTitle: json["note_title"],
        noteContent: json["note_content"],
        noteColor: json["note_color"],
    );

    Map<String, dynamic> toJson() => {
        "note_id": noteId,
        "note_title": noteTitle,
        "note_content": noteContent,
        "note_color": noteColor,
    };
}
