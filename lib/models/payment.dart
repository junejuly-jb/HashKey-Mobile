import 'dart:convert';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
    Payment({
        required this.cardId,
        required this.cardNumber,
        required this.cardExpiry,
        required this.cardName,
        required this.cardCcv,
        required this.cardColor,
        required this.cardSelected,
    });

    String cardId;
    String cardName;
    String cardNumber;
    String cardExpiry;
    String cardCcv;
    String cardColor;
    bool cardSelected;

    factory Payment.fromJson(Map<String, dynamic> json) => Payment(
        cardId: json["card_id"],
        cardName: json["card_name"],
        cardNumber: json["card_number"],
        cardExpiry: json["card_expiry"],
        cardCcv: json["card_ccv"],
        cardColor: json["card_color"],
        cardSelected: json["card_selected"],
    );

    Map<String, dynamic> toJson() => {
        "card_id": cardId,
        "card_name": cardName,
        "card_number": cardNumber,
        "card_expiry": cardExpiry,
        "card_ccv": cardCcv,
        "card_color": cardColor,
        "card_selected": cardSelected,
    };
}
