import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../Services/Services.dart';
import '../constants/constants.dart';
import 'package:flutter_sound/flutter_sound.dart' hide PlayerState;
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:audioplayers/audioplayers.dart';

import '../pages/poses.dart';

class ReviewBox extends StatefulWidget {
  final File imagephoto;

  ReviewBox({
    super.key,
    required this.imagephoto,
  });

  @override
  _ReviewBox createState() => _ReviewBox();
}

class _ReviewBox extends State<ReviewBox> {
  //TODO text Editor
  TextEditingController comment = TextEditingController();
  bool isOpened = false;

  //TODO Recorder
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;

  //TODO Siri animation
  final siri_controller = SiriWaveController();

  //TODO Audio
  final audioplayer = AudioPlayer();
  IconData PlayBtn = Icons.play_arrow;
  Duration? duration;
  bool isPlaying = false;

  //TODO comment and player visible
  bool postVisible = false;
  bool PreVisible = true;
   File? audioFile = null;


  //TODO Recording
  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop(DataController dataController) async {
    if (!isRecorderReady) return;
    final path = await recorder.stopRecorder();
    setState(() {
       audioFile = File(path!);
    });

    dataController.currentpose!.audio = audioFile;

    dataController.update();
    print("Path is  : $audioFile");
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      throw 'MicroPhone permission not granted';
    }
    await recorder.openRecorder();
    isRecorderReady = true;
  }

  // TODO Slider animation


  @override
  void initState() {
    super.initState();
    initRecorder();
    siri_controller.setAmplitude(0);
    siri_controller.setFrequency(0);
  }

  @override
  void dispose() {
    recorder.closeRecorder();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: GetBuilder<DataController>(
        init: Get.put(DataController()),
        builder: (dataController) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: size.height * 0.85,
                    width: size.width,
                    decoration: BoxDecoration(
                      color: cardColor,
                      borderRadius: BorderRadius.circular(21),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
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
                                child: IconButton(
                                  icon: const Icon(
                                    Icons.close,
                                    size: 22,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    print("object");
                                    Navigator.pop(context);
                                  },
                                ),
                              ),
                              Center(
                                child: Text(
                                  dataController.currentpose!.code!,
                                  style: GoogleFonts.dmSans(
                                    textStyle: const TextStyle(
                                        color: headingColor,
                                        fontSize: 24,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ),
                              Container(
                                //this container help to center heading
                                width: 40,
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: Text(
                            dataController.currentpose!.possId.toString()!,
                            style: GoogleFonts.dmSans(
                              textStyle: const TextStyle(
                                  color: descriptionColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(21.0),
                          ),
                          color: Colors.white,
                          elevation: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    height: size.height * 0.42,
                                    width: size.width,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(21),
                                      child: Image.file(
                                        dataController.currentpose!.selectePoses!,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      ),
                                    )),
                                const SizedBox(
                                  height: 10,
                                ),
                                dataController.currentpose!.comment != null  || dataController.currentpose!.audio != null ?
                                _CommentAndAudio(dataController)
                                    :
                                // TODO do no delete below comment
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Container(
                                        // padding: EdgeInsets.only(left: 25, right: 25),
                                        decoration: BoxDecoration(
                                          color: kPrimaryColor,
                                          borderRadius: BorderRadius.circular(30),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            showComment(dataController);
                                            postVisible = true;
                                            PreVisible = false;
                                          },
                                          child: const Text(
                                            "Comment",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                                color: Colors.white),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      width: 47,
                                      height: 47,
                                      decoration: BoxDecoration(
                                        color: kSecondaryColor,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: IconButton(
                                        icon: const Icon(
                                          Icons.mic_none,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                        onPressed: () async {
                                          _showAudioRecorder(dataController);
                                          postVisible = true;
                                          PreVisible = false;
                                        },
                                      ),
                                    ),
                                  ],
                                )

                                // _CommentAndAudio(),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        _PreCommentAndAudio(dataController)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }

  void showComment(DataController dataController) {
    showModalBottomSheet(
      backgroundColor: cardColor,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: comment,
                  autofocus: true,
                  maxLines: 5,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    // border: InputBorder.none,
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 1, color: Colors.white),
                    ),
                    hintText: "Enter you comment here...",
                    contentPadding: const EdgeInsets.only(
                        left: 20.0, bottom: 18.0, top: 18.0, right: 20.0),
                    filled: true,
                    fillColor: Colors.white,
                    hintStyle: TextStyle(
                        // color: Color(formHint),
                        ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 25, right: 25),
                  decoration: BoxDecoration(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextButton(
                    onPressed: () {
                      dataController.currentpose!.comment = comment.value.text;
                      dataController.update();
                      Get.back();
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showAudioRecorder(DataController dataController) {
    showModalBottomSheet(
      backgroundColor: cardColor,
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 170,
                  child: SiriWave(
                    controller: siri_controller,
                    style: SiriWaveStyle.ios_7,
                    options: const SiriWaveOptions(
                      backgroundColor: Color.fromRGBO(216, 217, 215, 255),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    if (recorder.isRecording) {
                      await stop(dataController);
                      setState(() {
                        siri_controller.setAmplitude(0);
                        siri_controller.setFrequency(0);
                      });
                    } else {
                      await record();
                      setState(() {
                        siri_controller.setAmplitude(1);
                        siri_controller.setFrequency(5);
                      });
                    }
                  },
                  child: const Icon(
                    Icons.mic_none,
                    size: 22,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Container _CommentAndAudio(DataController dataController) {
    var size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              InkWell(
                onTap: (){
                  showComment(dataController);
                  postVisible = true;
                  PreVisible = false;
                },
                child: Container(
                    decoration: const BoxDecoration(
                        color: chColor,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    width: size.width - 50,
                    height: size.height * 0.1,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Text(dataController.currentpose!.comment ?? ''),
                    )),
              ),
            ],
          ),
      dataController.currentpose!.audio != null ?
      Container(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () async {
                    if(!isPlaying){
                      await audioplayer.play(DeviceFileSource(dataController.currentpose!.audio!.path));

                      setState(() {
                        isPlaying = true;
                      });
                    }
                    else{
                      await audioplayer.pause();

                      setState(() {
                        isPlaying = false;
                      });
                    }

                  },
                  icon: Icon(isPlaying ? Icons.pause : PlayBtn)),
            ),
            Expanded(
              flex: 9,
              child: Slider(
                activeColor: Colors.blueGrey,
                inactiveColor: Colors.grey,
                value: 00,
                onChanged: (value) {
                  setState(() {
                    audioplayer.getCurrentPosition();
                  });
                },
              ),
            ),
            IconButton(
                onPressed: () async {
                  setState(() {
                    audioFile = null;
                  });
                dataController.currentpose!.audio = null;
dataController.update();
                },
                icon: Icon(Icons.restore_from_trash_outlined)),
          ],
        ),
      )

          : audioFile !=null  ?

        Container(
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: IconButton(
                      onPressed: () async {
                        if(!isPlaying){
                          await audioplayer.play(DeviceFileSource(audioFile!.path));
                          setState(() {
                            isPlaying = true;
                          });
                        }
                        else{
                          await audioplayer.pause();
                          setState(() {
                            isPlaying = false;
                          });
                        }

                      },
                      icon: Icon(isPlaying ? Icons.pause :PlayBtn)),
                ),
                Expanded(
                  flex: 9,
                  child: Slider(
                    activeColor: Colors.blueGrey,
                    inactiveColor: Colors.grey,
                    value: 00,
                    onChanged: (value) {
                      setState(() {
                        audioplayer.getCurrentPosition();
                      });
                    },
                  ),
                ),
              ],
            ),
          )


            :  Container(
    alignment: Alignment.center,
    width: 47,
    height: 47,
    decoration: BoxDecoration(
    color: kSecondaryColor,
    borderRadius: BorderRadius.circular(50),
    ),
    child: IconButton(
    icon: const Icon(
    Icons.mic_none,
    size: 22,
    color: Colors.white,
    ),
    onPressed: () async {
    _showAudioRecorder(dataController);
    postVisible = true;
    PreVisible = false;
    },
    ),
    ),
        ],
      ),
    );
  }

  Container _PreCommentAndAudio(DataController dataController) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                color: ButtonColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {


                  Get.to(PosesPhoneScreen());
                },
                child: const Text(
                  "Retake",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 25, right: 25),
              decoration: BoxDecoration(
                color: ButtonColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Save",
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
    );
  }

}


