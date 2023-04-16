import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kachins/Services/Services.dart';
import 'package:kachins/pages/verification_screen.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:async';
import '../constants/constants.dart';
import 'package:http/http.dart' as http;

class QRScanner extends StatefulWidget {
  const QRScanner({Key? key}) : super(key: key);

  @override
  State<QRScanner> createState() => _QRScannerState();
}

class _QRScannerState extends State<QRScanner> {
  MobileScannerController cameraController = MobileScannerController();
  bool isScanned = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<DataController>(
      init: Get.put(DataController()),
      builder: (dataController) {

        return Scaffold(
            body: Container(
          width: size.width,
          height: size.height,
          child: dataController.loading ? Center(child: CircularProgressIndicator(),) : Stack(
            alignment: Alignment.center,
            children: [
             Container(
                child: MobileScanner(
                    allowDuplicates: false,
                    controller: cameraController,
                    onDetect: (barcode, args) async {
                      if (barcode.rawValue == null) {
                        setState(() {
                          isScanned = false;
                        });
                        debugPrint('Failed to scan Barcode');
                        Get.snackbar('Error', 'Qr not valid');
                      } else {
                        setState(() {
                          isScanned = true;
                        });

                        final String code = barcode.rawValue!;
                        debugPrint('Barcode found! $code');

                       await  dataController.getData(code);


                      }
                    }),
              ),
              Container(
                child: SvgPicture.asset(
                  isScanned == false
                      ? 'assets/images/scan-frame.svg'
                      : 'assets/images/scan-frame-color.svg',
                ),
              ),
              Positioned(
                top: size.height * .07,
                width: size.width,
                child: Container(
                  padding: EdgeInsets.only(
                    left: size.width * .06,
                    right: size.width * .06,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        child: SvgPicture.asset(
                          'assets/images/Logo.svg',
                          height: 40,
                        ),
                      ),
                      InkWell(
                        splashColor: Colors.transparent,
                        onTap: () => cameraController.toggleTorch(),
                        child: ValueListenableBuilder(
                          valueListenable: cameraController.torchState,
                          builder: (context, state, child) {
                            switch (state as TorchState) {
                              case TorchState.off:
                                return Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: kSecondaryColor,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/flash.svg',
                                    color: Colors.white,
                                  ),
                                );
                              case TorchState.on:
                                return Container(
                                  alignment: Alignment.center,
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: SvgPicture.asset(
                                    'assets/images/flash.svg',
                                    color: kSecondaryColor,
                                  ),
                                );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
      }
    );
  }
}
