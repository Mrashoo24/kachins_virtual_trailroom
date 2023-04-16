import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:kachins/Services/Services.dart';
import 'package:kachins/pages/poses.dart';
import '../constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;

class ProductInstructions extends StatefulWidget {
  const ProductInstructions({Key? key}) : super(key: key);

  @override
  State<ProductInstructions> createState() => _ProductInstructionsState();
}

class _ProductInstructionsState extends State<ProductInstructions> {


  List<dynamic> text_to_speech = [];

  getProcessDetail() async {
    setState((){
      text_to_speech =   Get.put(DataController()).selectedProd!.audio!;

    });
    // print(text_to_speech);
    Future.delayed(const Duration(seconds: 2));
    speak();
  }

  final FlutterTts flutterTts = FlutterTts();



  speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1);
    for(int i =0;i<text_to_speech.length;i++){
      await flutterTts.speak(text_to_speech[i]);
      await flutterTts.awaitSpeakCompletion(true);
    }
  }

  @override
  void initState() {
    super.initState();
    getProcessDetail();
  }

  @override
  void dispose() {
    flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Container(
            height: size.height * .86,
            width: double.infinity,
            margin: EdgeInsets.symmetric(horizontal: size.width * .08),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10,
                    width: size.width / 3,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                    ),
                  ),
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                            top: size.height * 0.4,
                            bottom: size.height * 0.14,
                            left: size.width * .03,
                            right: size.width * .07),
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 22,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            // top: size.height * 0.1,
                            bottom: size.height * 0.14,
                            left: size.width * .03,
                            right: size.width * .01),
                        height: size.height * .86 - 10,
                        color: Colors.white,
                        child: Image.asset('assets/images/speaker.png'),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                            // top: size.height * 0.1,
                            bottom: size.height * 0.75,
                            left: size.width * .03,
                            right: size.width * .03),
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
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            top: size.height * 0.22,
                            bottom: size.height * 0.0,
                            left: size.width * .01,
                            right: size.width * .01),
                        height: size.height * .86 - 14,
                        // color: Colors.white,
                        child: Image.asset(
                          'assets/images/Mask group.png',
                          height: 6000,
                          width: 3000,
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                            // top: size.height * 0.1,
                            bottom: size.height * 0.13,
                            left: size.width * .03,
                            right: size.width * .03),
                        child: Column(
                          children: [
                            Text(
                              "      Please follow the size guide to\n   help you get the best poses clicked\n    for taking effective measurements.",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: descriptionColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        padding: EdgeInsets.only(
                            // top: size.height * 0.2,
                            bottom: size.height * 0.63,
                            left: size.width * .03,
                            right: size.width * .01),
                        child: Column(
                          children: [
                            Text(
                              "   Listen to Product\nSpecific Instructions.",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: headingColor,
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: size.height * .03),
                        padding: EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                          color: ButtonColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => PosesPhoneScreen()));
                          },
                          child: Text(
                            "Continue",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
