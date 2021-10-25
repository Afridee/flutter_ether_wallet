// To parse this JSON data, do
//
//     final webhooksModel = webhooksModelFromJson(jsonString);

import 'dart:convert';

WebhooksModel webhooksModelFromJson(String str) => WebhooksModel.fromJson(json.decode(str));

String webhooksModelToJson(WebhooksModel data) => json.encode(data.toJson());

class WebhooksModel {
  WebhooksModel({
    required this.data,
  });

  List<Datum> data;

  factory WebhooksModel.fromJson(Map<String, dynamic> json) => WebhooksModel(
    data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Datum {
  Datum({
    required this.id,
    required this.appId,
    required this.network,
    required this.webhookType,
    required this.webhookUrl,
    required this.isActive,
    required this.timeCreated,
  });

  int id;
  String appId;
  int network;
  int webhookType;
  String webhookUrl;
  bool isActive;
  int timeCreated;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    appId: json["app_id"],
    network: json["network"],
    webhookType: json["webhook_type"],
    webhookUrl: json["webhook_url"],
    isActive: json["is_active"],
    timeCreated: json["time_created"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "app_id": appId,
    "network": network,
    "webhook_type": webhookType,
    "webhook_url": webhookUrl,
    "is_active": isActive,
    "time_created": timeCreated,
  };
}
