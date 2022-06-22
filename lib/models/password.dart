import 'dart:convert';

Password passwordFromJson(String str) => Password.fromJson(json.decode(str));

String passwordToJson(Password data) => json.encode(data.toJson());

class Password {
    Password({
      required this.logId,
      required this.logName,
      required this.logWebsite,
      required this.logUrl,
      required this.logEmail,
      required this.logPassword,
    });

    String logId;
    String logName;
    String logWebsite;
    String logUrl;
    String logEmail;
    String logPassword;

    factory Password.fromJson(Map<String, dynamic> json) => Password(
        logId: json["log_id"],
        logName: json["log_name"],
        logWebsite: json["log_website"],
        logUrl: json["log_url"],
        logEmail: json["log_email"],
        logPassword: json["log_password"],
    );

    Map<String, dynamic> toJson() => {
        "log_id": logId,
        "log_name": logName,
        "log_website": logWebsite,
        "log_url": logUrl,
        "log_email": logEmail,
        "log_password": logPassword,
    };
}
