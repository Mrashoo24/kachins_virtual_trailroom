import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachins/Services/Services.dart';
import 'package:kachins/pages/poses.dart';
import 'package:kachins/pages/thank_you.dart';
import 'package:kachins/widgets/ReviewBox.dart';
import '../Models/GetClass.dart';
import '../constants/constants.dart';
import 'package:path/path.dart';

class ReviewPicture extends StatefulWidget {
  @override
  _ReviewPictureState createState() => _ReviewPictureState();
}

class _ReviewPictureState extends State<ReviewPicture>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GetBuilder<DataController>(
      init: Get.put(DataController()),
      builder: (dataController) {
        var indexofProduct = dataController.qrModel!.processData!.indexOf(dataController.selectedProd!);
        var indexofPose = dataController.qrModel!.processData![indexofProduct].poses!.indexOf(dataController.currentpose!);



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
                                "Tap to view your picture for \nretaking and feedback options.",
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
                        Container(
                          child: SvgPicture.asset('assets/images/kachins-icon.svg'),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                      top: size.height * .225,
                      left: size.width * .06,
                      right: size.width * .06),
                  child:Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(21),
                      child: Container(
                        width: size.width,
                        padding: EdgeInsets.symmetric(
                            horizontal: 18, vertical: 10),
                        color: cardColor,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                // Text(
                                //   dataController.selectedProd!.poses![0].!.toString(),
                                //   textAlign: TextAlign.center,
                                //   style: GoogleFonts.dmSans(
                                //     textStyle: TextStyle(
                                //         color: Colors.black,
                                //         fontSize: 25,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),

                              ],
                            ),
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              height: size.height * 0.27,
                              width: size.width,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (BuildContext ctx, int poseindex) {

                                  var  currentPose = dataController.selectedProd!.poses![poseindex];

                                  return Column(
                                    children: [
                                      Container(
                                        width: size.width / 4.08,
                                        height: size.height / 4.35,
                                        margin: EdgeInsets.only(
                                            right:
                                            12),
                                        child: ClipRRect(
                                          borderRadius:
                                          BorderRadius.circular(21),
                                          child: Material(
                                            child: Ink.image(
                                              image:
                                              FileImage(currentPose.selectePoses!),
                                              fit: BoxFit.cover,
                                              child: InkWell(
                                                onTap: () {

                                                  dataController.currentpose = currentPose;
                                                  dataController.update();

                                                  // Get.to(PosesPhoneScreen());
                                                  Get.to(ReviewBox(imagephoto: currentPose.selectePoses!));


                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 12,
                                      ),
                                      Text(
                                        currentPose.code!,
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
                                itemCount: dataController.selectedProd!.poses!.length,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  // ListView.builder(
                  //     itemCount: dataController.qrModel!.processData!.length,
                  //     physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                  //     itemBuilder: (context,index){
                  //
                  //
                  //       var currentProd = dataController.qrModel!.processData![index];
                  //       var productPoses = currentProd.poses!;
                  //
                  //
                  //       return   Container(
                  //         margin: EdgeInsets.only(bottom: 20),
                  //         child: ClipRRect(
                  //           borderRadius: BorderRadius.circular(21),
                  //           child: Container(
                  //             width: size.width,
                  //             padding: EdgeInsets.symmetric(
                  //                 horizontal: 18, vertical: 10),
                  //             color: cardColor,
                  //             child: Column(
                  //               crossAxisAlignment: CrossAxisAlignment.center,
                  //               children: [
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Text(
                  //                   currentProd.poses![0].processId!.toString(),
                  //                       textAlign: TextAlign.center,
                  //                       style: GoogleFonts.dmSans(
                  //                         textStyle: TextStyle(
                  //                             color: Colors.black,
                  //                             fontSize: 25,
                  //                             fontWeight: FontWeight.bold),
                  //                       ),
                  //                     ),
                  //
                  //                   ],
                  //                 ),
                  //                 SizedBox(
                  //                   height: 16,
                  //                 ),
                  //                 Container(
                  //                   height: size.height * 0.27,
                  //                   width: size.width,
                  //                   child: ListView.builder(
                  //                     scrollDirection: Axis.horizontal,
                  //                     itemBuilder: (BuildContext ctx, int poseindex) {
                  //
                  //                     var  currentPose = currentProd.poses![poseindex];
                  //
                  //                       return Column(
                  //                         children: [
                  //                           Container(
                  //                             width: size.width / 4.08,
                  //                             height: size.height / 4.35,
                  //                             margin: EdgeInsets.only(
                  //                                 right:
                  //                                12),
                  //                             child: ClipRRect(
                  //                               borderRadius:
                  //                               BorderRadius.circular(21),
                  //                               child: Material(
                  //                                 child: Ink.image(
                  //                                   image:
                  //                                   FileImage(currentPose.selectePoses!),
                  //                                   fit: BoxFit.cover,
                  //                                   child: InkWell(
                  //                                     onTap: () {
                  //
                  //                                       dataController.currentpose = currentPose;
                  //                                       dataController.update();
                  //
                  //                                       // Get.to(PosesPhoneScreen());
                  //                                       Get.to(ReviewBox(imagephoto: currentPose.selectePoses!));
                  //
                  //
                  //                                     },
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                             ),
                  //                           ),
                  //                           SizedBox(
                  //                             height: 12,
                  //                           ),
                  //                           Text(
                  //                             currentPose.code!,
                  //                             textAlign: TextAlign.center,
                  //                             style: GoogleFonts.dmSans(
                  //                               textStyle: TextStyle(
                  //                                   color: headingColor,
                  //                                   fontSize: 15,
                  //                                   fontWeight: FontWeight.w400),
                  //                             ),
                  //                           ),
                  //                         ],
                  //                       );
                  //                     },
                  //                     itemCount: productPoses.length,
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     }
                  // )
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
                      onPressed: () async {

                       // // var checkProd =  dataController.qrModel!.processData!.map((e) {
                       //    var checkProd = dataController.selectedProd!.poses!.map((e) async {
                       //     // print('audio = ${e.audio?.path}');
                       //      var psoe = await e.selectePoses!.readAsBytes();
                       //     log('logimage =' + base64.encode(psoe));
                       //      return {
                       //         // 'prodid': e.processId,
                       //        'comment' : e.comment ?? '',
                       //        'code': e.code,
                       //      // 'preview' : e.image,
                       //      'image' : base64.encode(e.selectePoses!.readAsBytesSync()),
                       //        "poss_id": e.possId,
                       //        'audio' : e.audio?.path ?? ''
                       //      };
                       //    }).toList();
                       //  // }).toList();
                       //
                       //  print(checkProd);


                        var error = false;

                   var check =   await   Future.forEach<Poses>(dataController.selectedProd!.poses!, (e) async {
                     print('pose ${e.possId.toString()} ${e.code.toString()}');
                       Map<String, String> a =   {

                            'comment' : e.comment ?? 'a',
                            'code': e.code.toString(),

                            "pose_id": e.possId.toString(),


                          };

                         var check =  await dataController.sendData(e.selectePoses!, e.audio,a);

                         error = !check;

                         print('check = ${check}');


                       return check;
                        });

                   print('checkout = ${error}');



                   if(dataController.qrModel!.processData!.length - 1 >  indexofProduct){

                          dataController.selectedProd = dataController.qrModel!.processData![indexofProduct + 1];
                          dataController.currentpose = dataController.qrModel!.processData![indexofProduct + 1].poses![0];
                          dataController.update();



                          Get.snackbar('Submitted','Successfully',backgroundColor: Colors.white);

                          Get.to(PosesPhoneScreen());



                        }else{
                     if(error){
                       Get.snackbar('Error','Something went wrong',backgroundColor: Colors.white);

                     }else{
                       Get.snackbar('Submitted','Successfully',backgroundColor: Colors.white);

                       Get.to(ThankyouScreen());
                     }

                        }




                      },
                      child:dataController.loading ? Center(child: CircularProgressIndicator(),)  : Text("Confirm",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
