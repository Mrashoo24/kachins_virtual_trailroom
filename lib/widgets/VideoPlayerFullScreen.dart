import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerFullscreenWidget extends StatelessWidget {
  final VideoPlayerController? controller;

  const VideoPlayerFullscreenWidget({super.key, this.controller});

  @override
  Widget build(BuildContext context) =>
      controller != null && controller!.value.isInitialized
          ? Container(
              // alignment: Alignment.topCenter,
              child: buildVideo(),
            )
          : SizedBox.shrink();
  // : Center(
  //     child: CircularProgressIndicator(
  //     strokeWidth: 1,
  //   ));

  Widget buildVideo() => Stack(
        fit: StackFit.expand,
        children: <Widget>[
          buildVideoPlayer(),
          // BasicOverlayWidget(controller: controller),
        ],
      );

  Widget buildVideoPlayer() => buildFullScreen(
        child: AspectRatio(
          aspectRatio: controller!.value.aspectRatio,
          child: Container(
            color: Colors.green,
            child: VideoPlayer(controller!),
          ),
        ),
      );

  Widget buildFullScreen({
    @required Widget? child,
  }) {
    final size = controller!.value.size;
    final width = size.width;
    final height = size.height;

    return FittedBox(
      fit: BoxFit.cover,
      child: SizedBox(width: width, height: height, child: child),
    );
  }
}
