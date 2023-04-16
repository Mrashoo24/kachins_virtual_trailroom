import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachins/pages/successful.dart';
import 'package:kachins/widgets/VideoPlayerFullScreen.dart';
import 'package:video_player/video_player.dart';

import '../constants/constants.dart';

class ThankyouScreen extends StatefulWidget {
  const ThankyouScreen({Key? key}) : super(key: key);

  @override
  State<ThankyouScreen> createState() => _ThankyouScreenState();
}

class _ThankyouScreenState extends State<ThankyouScreen> {
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
            margin: EdgeInsets.symmetric(horizontal: size.width * .06),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.25),
                  offset: const Offset(0, 0),
                  blurRadius: 10.0,
                  spreadRadius: 2.0,
                ), //BoxShadow
                //BoxShadow
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 10.1,
                    width: size.width,
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
                        height: size.height * .86 - 10.1,
                        width: size.width,
                        color: Colors.transparent,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset('assets/images/thankyou.svg'),
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Thank You!",
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: headingColor,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            Text(
                              "\nThank you for using\nKatchins Virtual Trialroom!\n\nYour fitting sizes have been\nrecorded successfully.",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.dmSans(
                                textStyle: TextStyle(
                                    color: descriptionColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                            SizedBox(
                              height: 48,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: size.height * .04),
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
                                    builder: (context) => SuccessScreen()));
                          },
                          child: Text(
                            "Done",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(bottom: size.height * .02),
                      //   padding: EdgeInsets.only(left: 10, right: 10),
                      //   decoration: BoxDecoration(
                      //     color: kSecondaryColor,
                      //     borderRadius: BorderRadius.circular(30),
                      //   ),
                      //   child: FlatButton(
                      //     onPressed: () {},
                      //     child: Text(
                      //       "Done",
                      //       style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           color: Colors.white),
                      //     ),
                      //   ),
                      // )
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
