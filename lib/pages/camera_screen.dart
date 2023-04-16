import 'dart:developer';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:kachins/main.dart';
import 'package:kachins/pages/GalleryScreen.dart';
import 'package:kachins/pages/ReviewScreen.dart';
import 'package:kachins/pages/poses.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:kachins/constants/constants.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Models/GetClass.dart';
import '../Services/Services.dart';
import 'ReviewPicture.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with WidgetsBindingObserver {
  CameraController? controller;
  bool _isCameraInitialized = false;
  List<File> capturedImages = [];
  var currentView = 'back';

  Future onNewCameraSelected(CameraDescription cameraDescription) async {
    final previousCameraController = controller;
    final CameraController cameraController = CameraController(
      cameraDescription,
      ResolutionPreset.max,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );
    // await previousCameraController?.dispose();
    if (mounted) {
      setState(() {
        controller = cameraController;
      });
    }
    cameraController.addListener(() {
      if (mounted) setState(() {});
    });
    try {
      await cameraController.initialize();
    } on CameraException catch (e) {
      print('Error initializing camera: $e');
    }
    if (mounted) {
      setState(() {
        _isCameraInitialized = controller!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    onNewCameraSelected(cameras[0]);
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  // ...

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = controller;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      // Free up memory when camera not active
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      // Reinitialize the camera with same properties
      onNewCameraSelected(cameraController.description);
    }
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController!.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }
    try {
      XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      print('Error occured while taking picture: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var scale;
    if (_isCameraInitialized) {
      scale = 1 /
          (controller!.value.aspectRatio *
              MediaQuery.of(context).size.aspectRatio);
    }
    var size = MediaQuery.of(context).size;
    return GetBuilder<DataController>(
      init: Get.put(DataController()),
      builder: (dataController) {



        var indexofProduct = dataController.qrModel!.processData!.indexOf(dataController.selectedProd!);
        var indexofPose = dataController.qrModel!.processData![indexofProduct].poses!.indexOf(dataController.currentpose!);

        log('lengthofpose = ${dataController.qrModel!.processData![indexofProduct].poses![indexofPose].selectePoses?.path}');

        return Scaffold(
          body: _isCameraInitialized
              ? Container(
                  width: size.width,
                  height: size.height,
                  child: Stack(
                    children: [
                      dataController.qrModel!.processData![indexofProduct].poses![indexofPose].selectePoses != null
                          ? Container(
                    height: Get.height,
                    width: Get.width,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      image: dataController.qrModel!.processData![indexofProduct].poses![indexofPose].selectePoses != null
                          ? DecorationImage(
                          image: FileImage(dataController.qrModel!.processData![indexofProduct].poses![indexofPose].selectePoses!),
                          fit: BoxFit.cover)
                          : null,
                    ),
                  )
                          : Transform.scale(
                        scale: scale,
                        alignment: Alignment.topCenter,
                        child: CameraPreview(controller!),
                      ),
                      // Center(
                      //   child: Image.asset(
                      //     'assets/images/Scanner Frame.png',
                      //     width: 500,
                      //     height: 500,
                      //   ),
                      // ),

                      Container(
                        // color: Colors.red,
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                          top: size.height * .08,
                          left: size.width * .06,
                          right: size.width * .06,
                        ),

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
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
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 28),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 25, vertical: 2),
                                alignment: Alignment.center,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: chColor,
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.asset(
                                      'assets/images/speaking1.png',
                                      width: size.width * 0.075,
                                    ),
                                    Text(
                                      "Say 'Cheese'",
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.dmSans(
                                        textStyle: TextStyle(
                                            color: headingColor,
                                            fontSize: size.width * 0.049,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              child: SvgPicture.asset('assets/images/Click.svg'),
                              onTap: () async {
                                XFile? rawImage =
                                await takePicture();
                                File imageFile =
                                File(rawImage!.path);

                                int currentUnix = DateTime.now()
                                    .millisecondsSinceEpoch;

                                final directory =
                                await getApplicationDocumentsDirectory();

                                String fileFormat = imageFile.path
                                    .split('.')
                                    .last;

                                print(fileFormat);

                                await imageFile.copy(
                                  '${directory.path}/$currentUnix.$fileFormat',
                                );


                                await controller!.setFlashMode(
                                    FlashMode.off);


                                // dataController.currentpose!.selectePoses.add(imageFile);


                                  dataController.qrModel!.processData![indexofProduct].poses![indexofPose].selectePoses = imageFile;

                                  dataController.update();






                                // try {
                                //XFile? rawImage = await takePicture();

                                //File imageFile = File(rawImage!.path);
                                // print("ImageFile ${imageFile}");
                                //int currentUnix =
                                //  DateTime.now().millisecondsSinceEpoch;
                                //final directory =
                                // await getApplicationDocumentsDirectory();
                                //String fileFormat = imageFile.path.split('.').last;

                                //await imageFile.copy(
                                //'${directory.path}/$currentUnix.$fileFormat',
                                //);
                                //setState(() {
                                //capturedImages.add(File(rawImage.path));
                                // print("Image List ${capturedImages}");
                                //});

                                // } catch (e) {}
                              },
                            ),
                          ],
                        ),
                      ),

                      dataController.qrModel!.processData![indexofProduct].poses![indexofPose].selectePoses != null ?    Container(
                        alignment: Alignment.bottomCenter,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(onPressed: () {
                              dataController.qrModel!.processData![indexofProduct].poses![indexofPose].selectePoses = null;//Return if no image
                              dataController.update();
                            },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(ButtonColor),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(18.0),
                                           
                                        )
                                    )
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 30.0,vertical: 12),
                                  child: Text('Retake',style: TextStyle(fontSize: 20),),
                                )),
                            ElevatedButton(onPressed: () {
                              // if (dataController.qrModel!.processData![indexofProduct].poses![indexofPose].selectePoses == null) return; //Return if no image


                              if(dataController.qrModel!.processData![indexofProduct].poses!.length -1 >  indexofPose){
                                dataController.currentpose = dataController.qrModel!.processData![indexofProduct].poses![indexofPose + 1];

                                Get.to(PosesPhoneScreen());
                                dataController.update();
                              }else{



                                // else{
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ReviewPicture(
                                          )));
                                // }


                                print('else condtion ${dataController.qrModel!.processData![indexofProduct].poses!.length - 1} $indexofPose ');

                              }


                            },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(ButtonColor),
                                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),

                                        )
                                    )
                                ),
                                child: Padding(
                                  padding:  EdgeInsets.symmetric(horizontal: 30.0,vertical: 12),
                                  child: Text('Confirm',style: TextStyle(fontSize: 20),),
                                )),
                          ],
                        ),
                      ) : SizedBox()


                      ,Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 100.0),
                          child: IconButton(onPressed: ()async {

                            currentView == 'back' ? await onNewCameraSelected(cameras[1]) : await onNewCameraSelected(cameras[0]);
                            if (mounted) {
                              setState(() {
                                currentView = currentView == 'back' ? 'front' : 'front';
                              });
                            }

                          }, icon: Icon(Icons.swap_horizontal_circle,size: 50,),color: Colors.white,),
                        ),
                      )

                    ],
                  ),
                )
              : Container(),
        );
      }
    );
  }
}
