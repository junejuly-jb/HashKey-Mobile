import 'dart:convert';

License licenseFromJson(String str) => License.fromJson(json.decode(str));

String licenseToJson(License data) => json.encode(data.toJson());

class License {
    License({
        required this.licenseId,
        required this.licenseName,
        required this.licenseNumber,
        required this.licenseFlag,
        required this.licenseExpDate,
        required this.licenseCountry,
    });

    String licenseId;
    String licenseName;
    String licenseNumber;
    String licenseFlag;
    DateTime licenseExpDate;
    String licenseCountry;

    factory License.fromJson(Map<String, dynamic> json) => License(
        licenseId: json["license_id"],
        licenseName: json["license_name"],
        licenseNumber: json["license_number"],
        licenseFlag: json["license_flag"],
        licenseExpDate: DateTime.parse(json["license_exp_date"]),
        licenseCountry: json["license_country"],
    );

    Map<String, dynamic> toJson() => {
        "license_id": licenseId,
        "license_name": licenseName,
        "license_number": licenseNumber,
        "license_flag": licenseFlag,
        "license_exp_date": "${licenseExpDate.year.toString().padLeft(4, '0')}-${licenseExpDate.month.toString().padLeft(2, '0')}-${licenseExpDate.day.toString().padLeft(2, '0')}",
        "license_country": licenseCountry,
    };
}
