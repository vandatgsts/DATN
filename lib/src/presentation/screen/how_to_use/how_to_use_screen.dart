import 'package:ar_drawing/src/presentation/theme/app_color.dart';
import 'package:ar_drawing/src/resource/string/app_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';


import '../../widget/app_container.dart';
import '../../widget/app_header.dart';

class HowToUseScreen extends StatefulWidget {
  const HowToUseScreen({super.key});

  @override
  State<HowToUseScreen> createState() => _HowToUseScreenState();
}

class _HowToUseScreenState extends State<HowToUseScreen> {
  final String _videoUrl =
      "https://raw.githubusercontent.com/PNThanggg/Video/main/76da3a2b-7360-4c9a-aba0-999fc58516ef.mp4";

  VideoPlayerController? _controller;

  Future<VideoPlayerController> downloadVideo() async {
    VideoPlayerController controller;
    controller = VideoPlayerController.networkUrl(Uri.parse(_videoUrl))
      ..initialize().then((_) {});

    controller.play();
    controller.setLooping(true);

    return controller;

    // final directory = await getTemporaryDirectory();
    // final file = File('${directory.path}/video.mp4');
    //
    // VideoPlayerController controller;
    //
    // if (await file.exists()) {
    //   controller = VideoPlayerController.file(file)
    //     ..initialize().then((_) {
    //       setState(() {});
    //     });
    //
    //   return controller;
    // }
    //
    // final response = await http.get(Uri.parse(_videoUrl));
    //
    // AppLog.debug("Downloaded video: ${response.bodyBytes}");
    //
    // file.writeAsBytesSync(response.bodyBytes);
    //
    // AppLog.debug("Downloaded video: ${file.path}");
    //
    // controller = VideoPlayerController.file(file)
    //   ..initialize().then((_) {
    //     setState(() {});
    //   });
    //
    // return controller;
  }

  @override
  void dispose() {
    _controller?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: StringConstants.howToUse.tr,
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Center(
                    child: SizedBox(
                      width: 32.0.sp,
                      height: 32.0.sp,
                      child: const CircularProgressIndicator(
                        color: AppColor.primaryColor,
                      ),
                    ),
                  ),
                ),
                FutureBuilder<VideoPlayerController>(
                  future: downloadVideo(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done &&
                        snapshot.hasData) {
                      _controller = snapshot.data;
                      snapshot.data?.play();

                      return AspectRatio(
                        aspectRatio: 1080 / 1920,
                        child: VideoPlayer(snapshot.data!),
                      );
                    } else {
                      return Center(
                        child: SizedBox(
                          width: 32.0.sp,
                          height: 32.0.sp,
                          child: const CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
