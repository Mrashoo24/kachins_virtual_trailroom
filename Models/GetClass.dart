//To parse this JSON data, do

//final item = itemFromJson(jsonString);

import 'dart:convert';

Item itemFromJson(String str) => Item.fromJson(json.decode(str));

String itemToJson(Item data) => json.encode(data.toJson());

class Item {
  var error;

  Item({
    required this.error,
    required this.process,
    required this.productDetail,
  });

  // bool error;
  Process process;
  List<ProductDetail> productDetail;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        // error: json["error"],
        process: Process.fromJson(json["process"]),
        productDetail: List<ProductDetail>.from(
            json["product_detail"].map((x) => ProductDetail.fromJson(x))),
        error: null,
      );

  Map<String, dynamic> toJson() => {
        // "error": error,
        "process": process.toJson(),
        "product_detail":
            List<dynamic>.from(productDetail.map((x) => x.toJson())),
      };
}

class Process {
  Process({
    required this.name,
    required this.status,
    required this.email,
    required this.mobile,
    required this.date,
    required this.message,
    required this.referenceId,
    required this.processStatus,
    required this.data,
  });

  String name;
  bool status;
  String email;
  String mobile;
  String date;
  String message;
  List<String> referenceId;
  Map<String, bool> processStatus;
  List<List<Datum>> data;

  factory Process.fromJson(Map<String, dynamic> json) => Process(
        name: json["name"],
        status: json["status"],
        email: json["email"],
        mobile: json["mobile"],
        date: json["date"],
        message: json["message"],
        referenceId: List<String>.from(json["reference_id"].map((x) => x)),
        processStatus: Map.from(json["process_status"])
            .map((k, v) => MapEntry<String, bool>(k, v)),
        data: List<List<Datum>>.from(json["data"]
            .map((x) => List<Datum>.from(x.map((x) => Datum.fromJson(x))))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "status": status,
        "email": email,
        "mobile": mobile,
        "date": date,
        "message": message,
        "reference_id": List<dynamic>.from(referenceId.map((x) => x)),
        "process_status": Map.from(processStatus)
            .map((k, v) => MapEntry<String, dynamic>(k, v)),
        "data": List<dynamic>.from(
            data.map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
      };
}

class Datum {
  Datum({
    required this.text,
    required this.image,
    required this.code,
    required this.status,
    required this.processId,
    required this.processInstruction,
  });

  List<String> text;
  String image;
  String code;
  int status;
  int processId;
  String processInstruction;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        text: List<String>.from(json["text"].map((x) => x)),
        image: json["image"],
        code: json["code"],
        status: json["status"],
        processId: json["process_id"],
        processInstruction: json["process_instruction"],
      );

  get possId => null;

  Map<String, dynamic> toJson() => {
        "text": List<dynamic>.from(text.map((x) => x)),
        "image": image,
        "code": code,
        "status": status,
        "process_id": processId,
        "process_instruction": processInstruction,
      };
}

class ProductDetail {
  ProductDetail({
    required this.textName,
    required this.textDescription,
    required this.image,
    required this.code,
    required this.status,
  });

  String textName;
  String textDescription;
  String image;
  String code;
  int status;

  factory ProductDetail.fromJson(Map<String, dynamic> json) => ProductDetail(
        textName: json["text_name"],
        textDescription: json["text_description"],
        image: json["image"],
        code: json["code"],
        status: json["status"],
      );

  get possId => null;

  Map<String, dynamic> toJson() => {
        "text_name": textName,
        "text_description": textDescription,
        "image": image,
        "code": code,
        "status": status,
      };
}
