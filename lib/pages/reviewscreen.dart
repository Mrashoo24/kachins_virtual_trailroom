import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachins/Services/Services.dart';
import 'package:kachins/pages/ReviewPicture.dart';
import 'package:kachins/pages/poses.dart';
import '../constants/constants.dart';
import '../widgets/ReviewBox.dart';

class ReviewScreen extends StatefulWidget {

  const ReviewScreen({Key? key})
      : super(key: key);
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen>
    with SingleTickerProviderStateMixin {

  List imgList = [
    'assets/images/Group 25.png',
    'assets/images/Group 26.png',
    'assets/images/Group 25.png',
  ];

  int count = 0;

  List data = [];
  int length = 0;

  void getLength() async{
    data = await  Get.put(DataController()).getProcessDetails();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLength();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              height: size.height * .38,
              color: kPrimaryColor,
            ),
            Positioned(
              top: 0,
              child: Container(
                padding: EdgeInsets.only(
                    top: size.height * .095,
                    left: size.width * 0.12,
                    right: size.width * 0.12),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Review Pictures",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        Container(
                          child: Text(
                            "Tap to view your picture for \n retaking and feedback options.",
                            textAlign: TextAlign.left,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SvgPicture.asset('assets/images/kachins-icon.svg'),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(
                  top: size.height * .225,
                  left: size.width * .06,
                  right: size.width * .06),
              child: SingleChildScrollView(
                // physics: BouncingScrollPhysics(
                //     parent: AlwaysScrollableScrollPhysics()),
                child: Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(21),
                        child: Container(
                          height: size.height * .64,
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          color: cardColor,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Blazer",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Text(
                                    "1/3",
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.dmSans(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 16,
                              ),
                              Container(
                                height: size.height * 0.56,
                                width: size.width,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (BuildContext ctx, int index) {
                                    return Column(
                                      children: [
                                        Container(
                                          height: size.height * 0.52,
                                          width: size.width * .53,
                                          margin: EdgeInsets.only(
                                              right: 20),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(21),
                                            child: Material(
                                              child: InkWell(
                                                child: Image.asset(
                                                  'assets/images/Group 25.png',
                                                  fit: BoxFit.cover,
                                                  alignment:
                                                      Alignment.topCenter,
                                                ),
                                                onTap: () {
                                                  // showDialog(
                                                  //     barrierColor:
                                                  //         Color(0xff121212)
                                                  //             .withOpacity(0.8),
                                                  //     context: context,
                                                  //     builder: (BuildContext
                                                  //         context) {
                                                  //       return AlertDialog(
                                                  //         elevation: 0.0,
                                                  //         insetPadding: EdgeInsets
                                                  //             .symmetric(
                                                  //                 horizontal:
                                                  //                     size.width *
                                                  //                         .08),
                                                  //         contentPadding:
                                                  //             EdgeInsets.zero,
                                                  //         backgroundColor:
                                                  //             Colors
                                                  //                 .transparent,
                                                  //         content: ReviewBox(
                                                  //           imagephoto: widget
                                                  //               .images[index],
                                                  //         ),
                                                  //       );
                                                  //     });
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 12,
                                        ),
                                        Text(
                                          "Front",
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.dmSans(
                                            textStyle: TextStyle(
                                                color: headingColor,
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                  itemCount: 3,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                margin: EdgeInsets.only(bottom: size.height * .04),
                padding: EdgeInsets.only(left: 25, right: 25),
                decoration: BoxDecoration(
                  color: ButtonColor,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextButton(
                  onPressed: () {
                    //POP Context for two pages
                    //todo
                    setState(() {
                      count ++;
                      length = data.length;
                    });
                    if (count >= length) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ReviewPicture()));
                          count = 0;
                    }else if (count < length-1){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "Confirm",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
