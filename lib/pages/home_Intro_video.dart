import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kachins/pages/qr_scanner.dart';
import 'package:kachins/widgets/VideoPlayerFullScreen.dart';
import 'package:video_player/video_player.dart';

import '../constants/constants.dart';

class HomeIntroVideoScreen extends StatefulWidget {
  const HomeIntroVideoScreen({Key? key}) : super(key: key);

  @override
  State<HomeIntroVideoScreen> createState() => _HomeIntroVideoScreenState();
}

class _HomeIntroVideoScreenState extends State<HomeIntroVideoScreen> {
  VideoPlayerController? controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = VideoPlayerController.network(
        "https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4")
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((_) => controller!.play());
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  Widget buildPlay() => controller!.value.isPlaying
      ? Container()
      : Container(
          color: Colors.black26,
          child: Center(
            child: Icon(
              Icons.play_circle_outline_rounded,
              color: Colors.white,
              size: 70,
            ),
          ),
        );

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
                      color: descriptionColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: VideoProgressIndicator(
                      controller!,
                      allowScrubbing: true,
                      padding: EdgeInsets.zero,
                      colors: VideoProgressColors(
                          playedColor: kSecondaryColor,
                          bufferedColor: Colors.white,
                          backgroundColor: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => controller!.value.isPlaying
                        ? controller!.pause()
                        : controller!.play(),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          height: size.height * .86 - 10.1,
                          color: Colors.transparent,
                          child: VideoPlayerFullscreenWidget(
                              controller: controller),
                        ),
                        Container(
                          height: size.height * .86 - 10.1,
                          child: buildPlay(),
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const QRScanner()),
                              );
                            },
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
                        //   margin: EdgeInsets.only(bottom: size.height * .02),
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
