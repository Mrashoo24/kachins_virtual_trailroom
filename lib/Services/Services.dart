import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:kachins/Models/GetClass.dart';
import 'package:kachins/pages/verification_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/qr_scanner.dart';

class DataController extends GetxController{
  String url = "https://kachins.herokuapp.com/api/";
bool phoneVerified = false;
bool emailVerified = false;
  Poses? currentpose ;
  ProcessData? selectedProd ;



  String code = '';
  bool loading = false;
  QRModel?  qrModel ;
  @override
  onInit(){
    super.onInit();


  }


  getData(code1) async {
    loading = true;
    update();

    try{

      final response = await http.get(Uri.parse(url + 'process/$code1/'));
      code = code1;
      // print('gotData1 = ${jsonDecode(response.body)} ' + response.statusCode.toString());

      // var Item;

      print('gotData = ${response.body}');

      qrModel = QRModel.fromJson(jsonDecode(response.body));
      update();


      // var item;
      // var process = item.process;

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('qrdata', response.body);
      loading = false;

      if(!qrModel!.error!){
        print('gotDatastat = ${qrModel!.status!}');
        if(!qrModel!.status!){
          Get.to(VerificationScreen());
        }
        else{
         Fluttertoast.showToast(msg: 'ERROR' + ' Data already submitted',backgroundColor: Colors.red);

        }

      }else{
        Fluttertoast.showToast(msg: 'ERROR' + ' Something went wrong',backgroundColor: Colors.red);
      }

      update();
    }catch (e){
      loading = false;
      print('got error ${e.toString()}');
      Fluttertoast.showToast(msg: 'ERROR' + ' Something went wrong',backgroundColor: Colors.red);
      update();
      Get.off(QRScanner(),preventDuplicates: false
      );
    }



  }


  Future<bool> sendData(File image,File? audio,Map<String, String> data) async {
    loading = true;
    update();

    try{
      final uri = Uri.parse(url + 'user-data-upload/');
      print("================= Request URL Post Multi ==============");
      print("================= $uri ==============");

      var request = http.MultipartRequest("POST", uri);

      ///
      if(audio != null) {
        request.files.add(await http.MultipartFile.fromPath('audio', audio!.path));
      }
      // else{
      //   request.files.add(await http.MultipartFile.fromPath('audio', null));/
      //
      // };


      request.files.add(await http.MultipartFile.fromPath('image',image!.path));

      print('checkimagepath = ${image.path}');

      request.fields.addAll(

          data
      );


      var res = await request.send();
      final respStr = await res.stream.bytesToString();

      print("================= Status code ==============");
      print("================= ${res.statusCode} ==============");
      print("================= Response Body Start ==============");
      log(respStr);
      var check = false;
      if (res.statusCode != 200) {
        print(res.statusCode);
        loading = false;
        update();
        Fluttertoast.showToast(msg: 'Error');
        return false;
      }else{
        print('${respStr}');

        if(jsonDecode(respStr)['error']){
          loading = false;
          update();
          Fluttertoast.showToast(msg: 'Something went wrong');
          check =  false;
        }else{
          loading = false;
          update();
          Fluttertoast.showToast(msg: 'Success');
          check =  true;
        }

        return check ;
        // Fluttertoast.showToast(msg: 'Success');
      }
    }catch (e){
      loading = false;
      Fluttertoast.showToast(msg: 'Something went wrong on server');

      update();
    return false;

    }

 }

  Future<List> getProductDetails() async {
    // //todo DONE
    // final response = await http.get(Uri.parse(url));
    // var Item;
    // Item = Item.fromJson(jsonDecode(response.body));
    // List Details = [];
    // var item;
    // var product_details = item.productDetail;
    // product_details.asMap().forEach((i, value) {
    //   Details.add([
    //     value.textName,
    //     value.textDescription,
    //     value.status,
    //     value.code,
    //     value.image,
    //     value.possId
    //   ]);
    // });
    return qrModel!.processData!;
  }

  Future<List> getProcessDetails() async {
    List Process1 = [];
    //TODO DONE
    final response = await http.get(Uri.parse(url));
    var Item;
    Item = Item.fromJson(jsonDecode(response.body));
    var item;
    var process = item.process;

    var process_data = process.data;
    for (int k = 0; k < process_data.length; k++) {
      process_data[k].asMap().forEach((i, value) {
        Process1.add([
          value.status,
          value.code,
          value.image,
          value.processId,
          value.possId,
          value.text
        ]);
      });
    }

    return Process1;
  }

  Future<List> getTextToSpeech() async {
    List text_to_speech = [];
    //TODO DONE
    final response = await http.get(Uri.parse(url));
    var Item;
    Item = Item.fromJson(jsonDecode(response.body));
    var item;
    var process = item.process;
    var process_data = process.data;
    for (int j = 0; j < process_data.length; j++) {
      process_data[j].asMap().forEach((key, value) {
        text_to_speech.add(value.processInstruction);
      });
    }

    return text_to_speech;
  }


  String convertToAstericks(String text,bool phone) {
    // String test = "0123456789";
    // int numSpace = 6;
    String result = text.replaceRange(0,  phone ?text.length - 4 :text.length - 14, '*' * (phone ? text.length - 4: text.length - 14));
    print("original: ${text}  replaced: ${result}");
    return result;
  }
}
