import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '/pages/camera_screen.dart';

class ImagePreview extends StatefulWidget {
  const ImagePreview({Key? key}) : super(key: key);

  @override
  State<ImagePreview> createState() => _ImagePreviewScreenState();
}

class _ImagePreviewScreenState extends State<ImagePreview> {
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
                        height: size.height * .86 - 10,
                        color: Colors.green,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: size.height * .04),
                        padding: EdgeInsets.only(left: 25, right: 25),
                        decoration: BoxDecoration(
                          color: ButtonColor,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "Next",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(bottom: size.height * .04),
                      //   padding: EdgeInsets.only(left: 10, right: 10),
                      //   decoration: BoxDecoration(
                      //     color: Colors.black,
                      //     borderRadius: BorderRadius.circular(30),
                      //   ),
                      //   child: FlatButton(
                      //     onPressed: () {},
                      //     child: Text(
                      //       "Next",
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
