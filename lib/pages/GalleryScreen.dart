import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kachins/constants/constants.dart';
import 'package:kachins/pages/ReviewPicture.dart';
import 'package:kachins/pages/ReviewScreen.dart';
import '/pages/camera_screen.dart';

// TODO Not necessary

class GalleryScreen extends StatelessWidget {
  final List<File> images;
  final CameraController? controller;
  const GalleryScreen({Key? key, required this.images, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    print(
        "Bottom Size : ${size.height - MediaQuery.of(context).padding.top - size.height * .86 - size.height * .03}");
    return SafeArea(
      bottom: false,
      child: Scaffold(
        body: Container(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext ctx, int index) {
              return Container(
                child: Row(
                  children: <Widget>[
                    // color: Colors.red,
                    Container(
                      width: size.width,
                      height: size.height,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          Image.file(
                            images[index],
                            height: size.height,
                            width: size.width,
                            fit: BoxFit.cover,
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: size.width * .06,
                            ),
                            margin: EdgeInsets.only(
                                bottom: size.height -
                                    MediaQuery.of(context).padding.top -
                                    size.height * .86 -
                                    size.height * .02),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      // bottom: size.height * .06,
                                      right: 10,
                                    ),
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: kSecondaryColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      child: Text(
                                        "Retake",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.only(
                                        // bottom: size.height * .06,
                                        left: 10),
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    decoration: BoxDecoration(
                                      color: kSecondaryColor,
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    child: ElevatedButton
                                      (
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ReviewScreen()));
                                      },
                                      child: Text(
                                        "Confirm",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: images.length,
          ),
        ),
      ),
    );
  }
}
