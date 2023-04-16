import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachins/pages/home_Intro_video.dart';
import 'package:kachins/pages/qr_scanner.dart';

import '../constants/constants.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;
  Animation? _animation;

  FocusNode _focusNodeEmail = FocusNode();
  FocusNode _focusNodeNumber = FocusNode();

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _animation = Tween(begin: 300.0, end: 50.0).animate(_controller!)
      ..addListener(() {
        setState(() {});
      });

    _focusNodeEmail.addListener(() {
      if (_focusNodeEmail.hasFocus) {
        _controller!.forward();
      } else {
        _controller!.reverse();
      }
    });

    _focusNodeNumber.addListener(() {
      if (_focusNodeNumber.hasFocus) {
        _controller!.forward();
      } else {
        _controller!.reverse();
      }
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    _focusNodeEmail.dispose();
    _focusNodeNumber.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Container(
        height:size.height * 0.15 ,
        // color: Colors.red,
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height:size.height * 0.121 ,
                color: kPrimaryColor,
              ),
            ),
            Positioned(
              top: 0,

              child: Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: size.width * 0.06),
                  width: Get.width,
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(13),
                          decoration: BoxDecoration(
                            color: kTertiaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Image.asset('assets/images/videoplayer.png'),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const HomeIntroVideoScreen()),
                          );
                        },
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12, vertical: 10),
                        alignment: Alignment.center,
                        width: 180,
                        height: 50,
                        decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => QRScanner(),
                                ));
                              },
                              style: ElevatedButton.styleFrom(
                                primary: kSecondaryColor,
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(15)),
                                ),
                              ),

                              // )
                              child: Text(
                                "Scan QR Code",
                                textAlign: TextAlign.center,
                                textScaleFactor: 1,
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(

                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 50,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: SvgPicture.asset(
                              'assets/images/question_mark.svg'),
                        ),
                        onTap: () => {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) => actionSheet)
                        },
                      )
                    ],
                  )),
            ),

          ],
        ),
      ),
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: size.height * .4,
              color: kPrimaryColor,
            ),
            Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: size.height * .095,
                ),
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset(
                  'assets/images/Logo.svg',
                ),
              ),
            ),

            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: size.height * .151,
                    left: size.width * .09,
                    right: size.width * .09),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.05,
                    ),
                    Container(
                        height: size.height * .41,
                        width: size.width - 50,
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(21),
                        ),
                        child: SvgPicture.asset('assets/images/wearmask.svg')),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.05),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Welcome to\nKachins Virtual Trial Room",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: headingColor,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.025),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          "Start with unpacking your product\nand keep the QR Tag ready.",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: descriptionColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                    // Container(
                    //   margin: EdgeInsets.only(top: 0, bottom: 40),
                    //   child: Align(
                    //     alignment: Alignment.center,
                    //     child: Text(
                    //       "and keep your QR Tag ready.",
                    //       textAlign: TextAlign.center,
                    //       style: GoogleFonts.dmSans(
                    //         textStyle: TextStyle(
                    //             color: ckColor,
                    //             fontSize: 14,
                    //             fontWeight: FontWeight.w400),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

  final actionSheet = CupertinoActionSheet(
      title: Text(
        "What do you need help with?",
        textAlign: TextAlign.center,
        style: GoogleFonts.dmSans(
          textStyle: TextStyle(
              color: descriptionColor,
              fontSize: 14,
              fontWeight: FontWeight.w400),
        ),
      ),
      actions: <Widget>[
        CupertinoActionSheetAction(
          child: Text(
            "Contact Us.",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  color: headingColor,
                  fontSize: 21,
                  fontWeight: FontWeight.w400),
            ),
          ),
          isDefaultAction: true,
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Privacy Policy.",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  color: headingColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
          ),
          isDefaultAction: true,
          onPressed: () {},
        ),
        CupertinoActionSheetAction(
          child: Text(
            "Terms of Service.",
            textAlign: TextAlign.center,
            style: GoogleFonts.dmSans(
              textStyle: TextStyle(
                  color: headingColor,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
          ),
          isDefaultAction: true,
          onPressed: () {},
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        onPressed: () {},
        child: Text(
          "Cancel",
          textAlign: TextAlign.center,
          style: GoogleFonts.dmSans(
            textStyle: TextStyle(
                color: headingColor, fontSize: 22, fontWeight: FontWeight.w400),
          ),
        ),
      ));
}
