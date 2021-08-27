// To parse this JSON data, do
//
//     final getTokenBalanceModel = getTokenBalanceModelFromJson(jsonString);

import 'dart:convert';

GetTokenBalanceModel getTokenBalanceModelFromJson(String str) => GetTokenBalanceModel.fromJson(json.decode(str));

String getTokenBalanceModelToJson(GetTokenBalanceModel data) => json.encode(data.toJson());

class GetTokenBalanceModel {
  GetTokenBalanceModel({
    required this.balance,
    required this.format,
    required this.tokenName,
    required this.tokenDecimal,
    required this.tokenSymbol,
  });

  String balance;
  String format;
  String tokenName;
  String tokenDecimal;
  String tokenSymbol;

  factory GetTokenBalanceModel.fromJson(Map<String, dynamic> json) => GetTokenBalanceModel(
    balance: json["Balance"],
    format: json["format"],
    tokenName: json["tokenName"],
    tokenDecimal: json["tokenDecimal"],
    tokenSymbol: json["tokenSymbol"],
  );

  Map<String, dynamic> toJson() => {
    "Balance": balance,
    "format": format,
    "tokenName": tokenName,
    "tokenDecimal": tokenDecimal,
    "tokenSymbol": tokenSymbol,
  };
}
