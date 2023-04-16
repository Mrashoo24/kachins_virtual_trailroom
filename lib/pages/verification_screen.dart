import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachins/Services/Services.dart';
import 'package:kachins/pages/Intro_video.dart';
import 'package:kachins/pages/qr_scanner.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../widgets/verificationDailogBox.dart';

class VerificationScreen extends StatefulWidget {
  VerificationScreen();

  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController mobile = new TextEditingController();
  TextEditingController email = new TextEditingController();

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
                  child: Container(
                    alignment: Alignment.center,
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 22),
                      onPressed: () {

                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    padding: EdgeInsets.only(
                      top: size.height * .075,
                    ),
                    alignment: Alignment.bottomCenter,
                    child: SvgPicture.asset('assets/images/kachins-icon.svg'),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  height: size.height * .2,
                  width: size.width,
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    color: kPrimaryColor,
                  ),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        top: size.height * .16,
                        left: size.width * .06,
                        right: size.width * .06),
                    child: Column(
                      children: [
                        Text(
                          "Verify Your Identity",
                          style: GoogleFonts.dmSans(
                            textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          child: Text(
                            "Confirm yourselves by finishing \none of either options",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.dmSans(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 36, bottom: 15),
                          height: size.height * .27,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(21),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Enter your e-mail Address",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: headingColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                dataController.convertToAstericks(dataController.qrModel!.email!,false),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dmSans(
                                  textStyle: const TextStyle(
                                      color: headingColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 5.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    showDialog(
                                        barrierColor:
                                            Color(0xff121212).withOpacity(0.8),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            elevation: 0.0,
                                            insetPadding: EdgeInsets.symmetric(
                                                horizontal: size.width * .08),
                                            contentPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            content: VerificationDialogBox(
                                              Controller: email,
                                              KeyboardType:
                                                  TextInputType.emailAddress,
                                              title: "Enter your e-mail Address",
                                              userInfo:dataController.convertToAstericks(dataController.qrModel!.email!,false),

                                              VerifyButton: () async {

                                                  // print(prefs.getString('reference_id'));
                                                  if(dataController.qrModel!.email == email.text){

                                                    dataController.emailVerified = true;
                                                    dataController.update();

                                                    dataController.emailVerified || dataController.phoneVerified ?
                                                    // Get.snackbar('Success', 'Verified')

                                                Navigator.pushReplacement(
                                                        (context),
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                IntroVideoScreen()))
                                                        : Get.back();
                                                  }
                                                  else{
                                                    Get.snackbar('Error', 'Not Verified');
                                                  }
                                                },
                                            ),
                                          );
                                        });
                                  },
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      readOnly: true,

                                      keyboardType: TextInputType.emailAddress,
                                      autofocus: false,
                                      // focusNode: _focusNodeNumber,
                                      decoration: InputDecoration(
                                        hintText: dataController.emailVerified ? dataController.qrModel!.email! : null,

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(60.0),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        suffixIcon: dataController.emailVerified ?Icon(
                                          Icons.check_circle_rounded,
                                          color: Colors.green,
                                          size: 18,
                                        )  :Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: headingColor,
                                          size: 18,
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: 30.0, bottom: 15.0, top: 15.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: TextStyle(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                          color: Color(0xffC7C7C7),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 15, bottom: 10),
                          height: size.height * .27,
                          width: size.width,
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(21),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Enter your Phone Number",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: headingColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Text(
                                  dataController.convertToAstericks(dataController.qrModel!.phone!.toString(),true),
                                textAlign: TextAlign.center,
                                style: GoogleFonts.dmSans(
                                  textStyle: TextStyle(
                                      color: headingColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25.0, vertical: 5.0),
                                child: InkWell(
                                  splashColor: Colors.transparent,
                                  onTap: () {
                                    showDialog(
                                        barrierColor:
                                            Color(0xff121212).withOpacity(0.8),
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            elevation: 0.0,
                                            insetPadding: EdgeInsets.symmetric(
                                                horizontal: size.width * .08),
                                            contentPadding: EdgeInsets.zero,
                                            backgroundColor: Colors.transparent,
                                            content: VerificationDialogBox(
                                              Controller: mobile,
                                              KeyboardType: TextInputType.phone,
                                              title: "Enter your Phone Number",
                                              userInfo:dataController.convertToAstericks(dataController.qrModel!.phone!.toString(),true),

                                              VerifyButton: () async {
                                                // print(prefs.getString('reference_id'));
                                                if(dataController.qrModel!.phone.toString() == mobile.text){

                                                  dataController.phoneVerified = true;
                                                  dataController.update();

                                                  dataController.emailVerified || dataController.phoneVerified ?
                                                  // Get.snackbar('Success', 'Verified')
                                                  Navigator.pushReplacement(
                                                      (context),
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              IntroVideoScreen()))
                                                      :
                                                  Get.back();
                                                }
                                                else{
                                                  Get.snackbar('Error', 'Not Verified');
                                                }
                                              },
                                            ),
                                          );
                                        });
                                  },
                                  child: IgnorePointer(
                                    child: TextFormField(
                                      readOnly: true,
                                      keyboardType: TextInputType.phone,
                                      autofocus: false,
                                      // focusNode: _focusNodeNumber,
                                      decoration: InputDecoration(
                                        hintText: dataController.phoneVerified ? dataController.qrModel!.phone!.toString() : null,

                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(60.0),
                                          borderSide: BorderSide(
                                            width: 0,
                                            style: BorderStyle.none,
                                          ),
                                        ),
                                        suffixIcon:dataController.phoneVerified ?
                                        Icon(
                                          Icons.check_circle_rounded,
                                          color: Colors.green,
                                          size: 18,
                                        ):
                                        Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: headingColor,
                                          size: 18,
                                        ),
                                        contentPadding: const EdgeInsets.only(
                                            left: 30.0, bottom: 15.0, top: 15.0),
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintStyle: TextStyle(
                                          color: kPrimaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
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
    );
  }
}
