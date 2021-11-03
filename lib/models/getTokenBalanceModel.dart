// To parse this JSON data, do
//
//     final getTokenBalanceModel = getTokenBalanceModelFromJson(jsonString);

import 'dart:convert';

GetTokenBalanceModel getTokenBalanceModelFromJson(String str) => GetTokenBalanceModel.fromJson(json.decode(str));

String getTokenBalanceModelToJson(GetTokenBalanceModel data) => json.encode(data.toJson());

class GetTokenBalanceModel {
  GetTokenBalanceModel({
    required this.tokenAddress,
    required this.balance,
    required this.tokenName,
    required this.tokenDecimal,
    required this.tokenSymbol,
  });

  String tokenAddress;
  String balance;
  String tokenName;
  String tokenDecimal;
  String tokenSymbol;

  factory GetTokenBalanceModel.fromJson(Map<String, dynamic> json) => GetTokenBalanceModel(
    tokenAddress: json["tokenAddress"],
    balance: json["Balance"],
    tokenName: json["tokenName"],
    tokenDecimal: json["tokenDecimal"],
    tokenSymbol: json["tokenSymbol"],
  );

  Map<String, dynamic> toJson() => {
    "tokenAddress": tokenAddress,
    "Balance": balance,
    "tokenName": tokenName,
    "tokenDecimal": tokenDecimal,
    "tokenSymbol": tokenSymbol,
  };
}
