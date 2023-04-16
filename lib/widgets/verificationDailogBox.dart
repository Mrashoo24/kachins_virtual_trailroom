import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/constants.dart';

class VerificationDialogBox extends StatefulWidget {
  final String title, userInfo;
  final VoidCallback? VerifyButton;
  final TextInputType? KeyboardType;
  final TextEditingController? Controller;

  const VerificationDialogBox({
    super.key,
    required this.title,
    required this.userInfo,
    this.VerifyButton,
    required this.KeyboardType,
    required this.Controller
  });

  @override
  _VerificationDialogBoxState createState() => _VerificationDialogBoxState();
}

class _VerificationDialogBoxState extends State<VerificationDialogBox> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: size.height * .27,
          width: size.width,
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(21),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.title,
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
                widget.userInfo,
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
                padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 5.0),
                child: TextFormField(
                  controller: widget.Controller,
                  keyboardType: widget.KeyboardType,
                  autofocus: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(60.0),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    suffixIcon: GestureDetector(
                      onTap: widget.VerifyButton!,
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: headingColor,
                        size: 18,
                      ),
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
            ],
          ),
        ),
      ],
    );
  }
}
