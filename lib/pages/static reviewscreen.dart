import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/constants.dart';

class Review extends StatefulWidget {
  @override
  _ReviewScreen createState() => _ReviewScreen();
}

class _ReviewScreen extends State<Review> with SingleTickerProviderStateMixin {
  @override
  Widget buildCard() => SizedBox(
        width: 350,
        height: 465,
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,

          child: Container(
            child: Column(
              children: [
                FittedBox(
                  child: Container(
                    width: 250,
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(50)),
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/images/Group 22.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    "Product Details.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
          // width: 350,
          // height: 565,
          color: ckColor,
        ),
      );

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
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(
                top: size.height * .09,
                left: size.width * .06,
              ),
              height: size.height * .43,
              color: kPrimaryColor,
            ),
            Positioned(
              bottom: 630,
              child: Container(
                padding: EdgeInsets.only(top: size.height * .095, right: 160),
                alignment: Alignment.topRight,
                child: Column(
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
                    Container(
                      child: Text(
                        "\n  Tap to view your picture for\n        retaking and feedback options",
                        textAlign: TextAlign.center,
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
              ),
            ),
            Positioned(
              top: 0,
              right: 44,
              child: Container(
                padding: EdgeInsets.only(
                  top: size.height * .075,
                ),
                alignment: Alignment.bottomCenter,
                child: SvgPicture.asset('assets/images/kachins-icon.svg'),
              ),
            ),
            Positioned(
                top: 650,
                height: size.height * 0.242,
                width: size.width,
                child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.34),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 0, vertical: 10),
                          alignment: Alignment.center,
                          width: 120,
                          height: 55,
                          decoration: BoxDecoration(
                            color: kSecondaryColor,
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  primary: kSecondaryColor,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(50)),
                                  ),
                                ),
                                child: Text(
                                  "Complete",
                                  textAlign: TextAlign.center,
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
                      ],
                    ))),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: size.height * .225,
                    left: size.width * .06,
                    right: size.width * .06),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Container(
                        height: 258,
                        width: 360,
                        color: cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: size.height * 0.31,
                              width: size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return Container(
                                    width: size.width - size.width * .12,
                                    padding: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(21),
                                      child: Image.asset(
                                        'assets/images/Product Grid.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 5,
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
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: 450, left: size.width * .06, right: size.width * .06),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Container(
                        height: 258,
                        width: 360,
                        color: cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: size.height * 0.31,
                              width: size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext ctx, int index) {
                                  return Container(
                                    width: size.width - size.width * .12,
                                    padding: EdgeInsets.all(10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(21),
                                      child: Image.asset(
                                        'assets/images/trousers.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 5,
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
            // SingleChildScrollView(
            //   child: Container(

            //     padding: EdgeInsets.only(
            //         top: 1050, left: size.width * .06, right: size.width * .06),
            //     alignment: Alignment.bottomCenter,
            //     width: 180,
            //     height: 50,
            //     decoration: BoxDecoration(
            //       color: kSecondaryColor,
            //       borderRadius: BorderRadius.circular(50),
            //     ),
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         ElevatedButton(
            //           onPressed: () {},
            //           style: ElevatedButton.styleFrom(
            //             primary: kSecondaryColor,
            //             shape: const RoundedRectangleBorder(
            //               borderRadius: BorderRadius.all(Radius.circular(15)),
            //             ),
            //           ),

            //           // )
            //           child: Text(
            //             "Scan QR Code",
            //             textAlign: TextAlign.center,
            //             style: GoogleFonts.dmSans(
            //               textStyle: TextStyle(
            //                   color: Colors.white,
            //                   fontSize: 18,
            //                   fontWeight: FontWeight.w400),
            //             ),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
