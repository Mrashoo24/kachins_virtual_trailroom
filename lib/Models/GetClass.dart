import 'dart:io';

class QRModel {
  bool? error;
  bool? status;
  int? orderId;
  String? name;
  String? email;
  int? phone;
  String? date;
  List<String>? referenceId;
  List<ProcessData>? processData;
  List<ProductDetailModel>? productDetail;

  QRModel(
      {this.error,
        this.status,
        this.orderId,
        this.name,
        this.email,
        this.phone,
        this.date,
        this.referenceId,
        this.processData,this.productDetail});

  QRModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    status = json['status'];
    orderId = json['orderId'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    date = json['date'];
    referenceId = json['audio'] == null ? [''] :json['referenceId'].cast<String>();
    if (json['processData'] != null) {
      processData = <ProcessData>[];
      json['processData'].forEach((v) {
        processData!.add(new ProcessData.fromJson(v));
      });
    }

    if (json['productDetail'] != null) {
      productDetail = <ProductDetailModel>[];
      json['productDetail'].forEach((v) {
        productDetail!.add(new ProductDetailModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status'] = this.status;
    data['orderId'] = this.orderId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['date'] = this.date;
    data['referenceId'] = this.referenceId;
    if (this.processData != null) {
      data['processData'] = this.processData!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProcessData {
  List<String>? audio;
  List<Poses>? poses;

  ProcessData({this.audio, this.poses});

  ProcessData.fromJson(Map<String, dynamic> json) {
    audio =  json['audio'] == null ? [''] :json['audio'].cast<String>();
    if (json['poses'] != null) {
      poses = <Poses>[];
      json['poses'].forEach((v) {
        poses!.add(new Poses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['audio'] = this.audio;
    if (this.poses != null) {
      data['poses'] = this.poses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Poses {
  List<String>? text;
  String? image;
  File? selectePoses;
  String? code;
  int? status;
  int? processId;
  int? possId;
  String? comment;
  File? audio;

  Poses(
      {this.text,
        this.image,
        this.code,
        this.status,
        this.processId,
        this.possId});

  Poses.fromJson(Map<String, dynamic> json) {
    text = json['text'].cast<String>();
    image = json['image'];
    code = json['code'];
    status = json['status'];
    processId = json['processId'];
    possId = json['possId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['image'] = this.image;
    data['code'] = this.code;
    data['status'] = this.status;
    data['processId'] = this.processId;
    data['possId'] = this.possId;
    return data;
  }


}

class ProductDetailModel {
  String? image;
  String? title;
  String? description;

  ProductDetailModel({this.image, this.title, this.description});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['description'] = this.description;
    return data;
  }
}