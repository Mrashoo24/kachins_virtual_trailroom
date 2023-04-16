import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachins/Services/Services.dart';
import 'package:kachins/pages/ReviewPicture.dart';
import 'package:kachins/pages/camera_screen.dart';
import '../constants/constants.dart';

//TODO Convert the Image.asset (unable to load) to Image.url after getting the backdrop path

class PosesPhoneScreen extends StatefulWidget {
  const PosesPhoneScreen({Key? key}) : super(key: key);

  @override
  State<PosesPhoneScreen> createState() => _PosesPhoneScreenState();
}

class _PosesPhoneScreenState extends State<PosesPhoneScreen> {
  int PositionIndex = 0;
  int LengthList = 0;

  void _incrementCounter() {
    setState(() {
      PositionIndex++;
    });
  }

  bool flag = false;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(
      init: Get.put(DataController()),
      builder: (dataControlller) {
        var size = MediaQuery.of(context).size;
        return SafeArea(
          bottom: false,
          child: Scaffold(
            backgroundColor: PoseBgColor,
            body: Stack(
              children: <Widget>[
                Container(
                  alignment: Alignment.topLeft,
                  width: size.width / 2,
                  height: 12,
                  color: kPrimaryColor,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  padding: EdgeInsets.only(
                    top: size.height * .065,
                    left: size.width * .06,
                  ),
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  width: size.width,
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: size.height * .07,
                    ),
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Text(
                          "Positioning Guide",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: headingColor,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Container(
                          child: Text(
                            "${dataControlller.currentpose!.text!.first} ",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: headingColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.015,
                        ),
                        Container(
                          child: Text(
                            "${dataControlller.currentpose!.code}",

                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: descriptionColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Container(
                    padding: EdgeInsets.only(
                        top: size.height * .225,
                        left: size.width * .06,
                        right: size.width * .06),
                    // color: Colors.green,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(
                              top: size.height * 0.01, left: 15, right: 15),
                          height: size.height * 0.77,
                          width: size.width,
                          decoration: const BoxDecoration(
                            // color: Colors.red,
                              image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/phone-frame.png",
                                ),
                              )),
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.only(
                                  top: size.height * 0.035,
                                  left: size.height * 0.02,
                                  right: size.height * 0.02),
                              child: Image.network(
                                imgurl +    dataControlller.currentpose!.image!,
                                width: size.width,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context, Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                bottom: Platform.isIOS
                                    ? size.height * .1
                                    : size.height * .08),
                            alignment: Alignment.center,
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: kSecondaryColor,
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 22,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                // setState(() {
                                //   _incrementCounter();
                                // });

                                if (PositionIndex > LengthList ) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReviewPicture()));
                                  // //  KEEP IT OUT OF THE ONTAP
                                }
                                else{
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              CameraScreen()));
                                }

                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
        //   FutureBuilder(
        //   future: dataControlller.getProcessDetails(),
        //   builder: (ctx, snapshot) {
        //     var size = MediaQuery.of(context).size;
        //     print(snapshot.data);
        //     if (snapshot.data != null) {
        //       List<dynamic> map = snapshot.data as List<dynamic>;
        //       LengthList = map.length;
        //       return ;
        //     } else {
        //       return Center(
        //         child: Container(
        //           child: CircularProgressIndicator(
        //             color: kPrimaryColor,
        //           ),
        //           height: 40.0,
        //           width: 40.0,
        //         ),
        //       );
        //     }
        //   },
        // );
      }
    );
  }
}
