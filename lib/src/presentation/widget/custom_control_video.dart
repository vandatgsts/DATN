import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../utils/app_image.dart';
import '../theme/app_color.dart';
import 'app_touchable.dart';
import 'custom_track_slider.dart';

class CustomControlsVideo extends StatefulWidget {
  final VideoPlayerController controller;

  const CustomControlsVideo({
    super.key,
    required this.controller,
  });

  @override
  State<CustomControlsVideo> createState() => _CustomControlsVideoState();
}

class _CustomControlsVideoState extends State<CustomControlsVideo> {
  double _currentSliderValue = 0;
  bool hasVolume = true;

  @override
  void initState() {
    super.initState();
    // Cập nhật vị trí khi video chạy
    widget.controller.addListener(() {
      setState(() {
        _currentSliderValue =
            widget.controller.value.position.inSeconds.toDouble();
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        // Positioned.fill(
        //   child: AppTouchable(
        //     radius: 0,
        //     rippleColor: AppColor.transparent,
        //     onPressed: () {
        //       setState(() {
        //         if (widget.controller.value.isPlaying) {
        //           widget.controller.pause();
        //         } else {
        //           widget.controller.play();
        //         }
        //       });
        //     },
        //     backgroundColor: AppColor.transparent,
        //     child: const SizedBox.shrink(),
        //   ),
        // ),
        Positioned(
          bottom: 10.sp,
          right: 24.sp,
          left: 24.sp,
          child: Column(
            children: [
              Container(
                  width: Get.width,
                  height: 13.sp,
                  alignment: Alignment.centerLeft,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 2.0,
                      trackShape: CustomTrackShape(),
                      thumbShape:
                          RoundSliderThumbShape(enabledThumbRadius: 6.0.sp),
                    ),
                    child: Slider(
                      value: _currentSliderValue,
                      min: 0,
                      max:
                          widget.controller.value.duration.inSeconds.toDouble(),
                      onChanged: (value) {
                        setState(() {
                          _currentSliderValue = value;
                        });
                        widget.controller
                            .seekTo(Duration(seconds: value.toInt()));
                      },
                      inactiveColor: const Color(0xFFD9D9D9).withOpacity(0.6),
                      activeColor: const Color(0xFFD9D9D9).withOpacity(0.6),
                      thumbColor: AppColor.primaryColor.withOpacity(0.8),
                    ),
                  )),
              Row(
                children: [
                  AppTouchable(
                    rippleColor: AppColor.transparent,
                    padding: EdgeInsets.all(4.sp),
                    child: !widget.controller.value.isPlaying
                        ? Image.asset(
                            AppImage.icPlay,
                            height: 20.sp,
                          )
                        : Image.asset(
                            AppImage.icPause,
                            height: 20.sp,
                          ),
                    onPressed: () {
                      setState(() {
                        if (widget.controller.value.isPlaying) {
                          widget.controller.pause();
                        } else {
                          widget.controller.play();
                        }
                      });
                    },
                  ),
                  Gap(10.sp),
                  AppTouchable(
                    rippleColor: AppColor.transparent,
                    padding: EdgeInsets.all(4.sp),
                    onPressed: () {
                      hasVolume = !hasVolume;
                      if (hasVolume) {
                        widget.controller.setVolume(100);
                      } else {
                        widget.controller.setVolume(0);
                      }
                      setState(() {});
                    },
                    child: Image.asset(
                      hasVolume ? AppImage.icVolume : AppImage.icNoVolume,
                      height: 24.sp,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    _formatDuration(widget.controller.value.position),
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColor.textColor,
                    ),
                  ),
                  Text(
                    '/${_formatDuration(widget.controller.value.duration)}',
                    style: context.textTheme.bodySmall?.copyWith(
                      color: AppColor.textColor,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.controller.removeListener(() {});
    super.dispose();
  }
}
