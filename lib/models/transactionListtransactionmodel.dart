// To parse this JSON data, do
//
//     final transaclitionListModel = transaclitionListModelFromJson(jsonString);

import 'dart:convert';

TransaclitionListModel transaclitionListModelFromJson(String str) => TransaclitionListModel.fromJson(json.decode(str));

String transaclitionListModelToJson(TransaclitionListModel data) => json.encode(data.toJson());

class TransaclitionListModel {
  TransaclitionListModel({
    required this.blockNumber,
    required this.timeStamp,
    required this.hash,
    required this.nonce,
    required this.blockHash,
    required this.transactionIndex,
    required this.from,
    required this.to,
    required this.value,
    required this.gas,
    required this.gasPrice,
    required this.isError,
    required this.txreceiptStatus,
    required this.input,
    required this.contractAddress,
    required this.cumulativeGasUsed,
    required this.gasUsed,
    required this.confirmations,
  });

  String blockNumber;
  String timeStamp;
  String hash;
  String nonce;
  String blockHash;
  String transactionIndex;
  String from;
  String to;
  String value;
  String gas;
  String gasPrice;
  String isError;
  String txreceiptStatus;
  String input;
  String contractAddress;
  String cumulativeGasUsed;
  String gasUsed;
  String confirmations;

  factory TransaclitionListModel.fromJson(Map<String, dynamic> json) => TransaclitionListModel(
    blockNumber: json["blockNumber"],
    timeStamp: json["timeStamp"],
    hash: json["hash"],
    nonce: json["nonce"],
    blockHash: json["blockHash"],
    transactionIndex: json["transactionIndex"],
    from: json["from"],
    to: json["to"],
    value: json["value"],
    gas: json["gas"],
    gasPrice: json["gasPrice"],
    isError: json["isError"],
    txreceiptStatus: json["txreceipt_status"],
    input: json["input"],
    contractAddress: json["contractAddress"],
    cumulativeGasUsed: json["cumulativeGasUsed"],
    gasUsed: json["gasUsed"],
    confirmations: json["confirmations"],
  );

  Map<String, dynamic> toJson() => {
    "blockNumber": blockNumber,
    "timeStamp": timeStamp,
    "hash": hash,
    "nonce": nonce,
    "blockHash": blockHash,
    "transactionIndex": transactionIndex,
    "from": from,
    "to": to,
    "value": value,
    "gas": gas,
    "gasPrice": gasPrice,
    "isError": isError,
    "txreceipt_status": txreceiptStatus,
    "input": input,
    "contractAddress": contractAddress,
    "cumulativeGasUsed": cumulativeGasUsed,
    "gasUsed": gasUsed,
    "confirmations": confirmations,
  };
}
