import 'dart:convert';

Wifi wifiFromJson(String str) => Wifi.fromJson(json.decode(str));

String wifiToJson(Wifi data) => json.encode(data.toJson());

class Wifi {
    Wifi({
        required this.wifiId,
        required this.wifiSsid,
        required this.wifiPass,
        required this.wifiSecurity,
        required this.wifiStatus,
    });

    String wifiId;
    String wifiSsid;
    String wifiPass;
    String wifiSecurity;
    bool wifiStatus;

    factory Wifi.fromJson(Map<String, dynamic> json) => Wifi(
        wifiId: json["wifi_id"],
        wifiSsid: json["wifi_ssid"],
        wifiPass: json["wifi_pass"],
        wifiSecurity: json["wifi_security"],
        wifiStatus: json["wifi_status"],
    );

    Map<String, dynamic> toJson() => {
        "wifi_id": wifiId,
        "wifi_ssid": wifiSsid,
        "wifi_pass": wifiPass,
        "wifi_security": wifiSecurity,
        "wifi_status": wifiStatus,
    };
}
