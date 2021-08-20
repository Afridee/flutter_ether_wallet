// To parse this JSON data, do
//
//     final encryptedEthAccountModel = encryptedEthAccountModelFromJson(jsonString);

import 'dart:convert';

EncryptedEthAccountModel encryptedEthAccountModelFromJson(String str) => EncryptedEthAccountModel.fromJson(json.decode(str));

String encryptedEthAccountModelToJson(EncryptedEthAccountModel data) => json.encode(data.toJson());

class EncryptedEthAccountModel {
  EncryptedEthAccountModel({
    required this.version,
    required this.id,
    required this.address,
    required this.crypto,
  });

  int version;
  String id;
  String address;
  Crypto crypto;

  factory EncryptedEthAccountModel.fromJson(Map<String, dynamic> json) => EncryptedEthAccountModel(
    version: json["version"],
    id: json["id"],
    address: json["address"],
    crypto: Crypto.fromJson(json["crypto"]),
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "id": id,
    "address": address,
    "crypto": crypto.toJson(),
  };
}

class Crypto {
  Crypto({
    required this.ciphertext,
    required this.cipherparams,
    required this.cipher,
    required this.kdf,
    required this.kdfparams,
    required this.mac,
  });

  String ciphertext;
  Cipherparams cipherparams;
  String cipher;
  String kdf;
  Kdfparams kdfparams;
  String mac;

  factory Crypto.fromJson(Map<String, dynamic> json) => Crypto(
    ciphertext: json["ciphertext"],
    cipherparams: Cipherparams.fromJson(json["cipherparams"]),
    cipher: json["cipher"],
    kdf: json["kdf"],
    kdfparams: Kdfparams.fromJson(json["kdfparams"]),
    mac: json["mac"],
  );

  Map<String, dynamic> toJson() => {
    "ciphertext": ciphertext,
    "cipherparams": cipherparams.toJson(),
    "cipher": cipher,
    "kdf": kdf,
    "kdfparams": kdfparams.toJson(),
    "mac": mac,
  };
}

class Cipherparams {
  Cipherparams({
    required this.iv,
  });

  String iv;

  factory Cipherparams.fromJson(Map<String, dynamic> json) => Cipherparams(
    iv: json["iv"],
  );

  Map<String, dynamic> toJson() => {
    "iv": iv,
  };
}

class Kdfparams {
  Kdfparams({
    required this.dklen,
    required this.salt,
    required this.n,
    required this.r,
    required this.p,
  });

  int dklen;
  String salt;
  int n;
  int r;
  int p;

  factory Kdfparams.fromJson(Map<String, dynamic> json) => Kdfparams(
    dklen: json["dklen"],
    salt: json["salt"],
    n: json["n"],
    r: json["r"],
    p: json["p"],
  );

  Map<String, dynamic> toJson() => {
    "dklen": dklen,
    "salt": salt,
    "n": n,
    "r": r,
    "p": p,
  };
}
