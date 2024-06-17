import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';


import '../../../resource/string/app_string.dart';
import '../../../utils/app_log.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/firebase_analytics.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_touchable.dart';
import '../../widget/custom_control_video.dart';
import '../deny_permission_camera/deny_camera_screen.dart';

class PreviewAfterDrawCamera extends StatefulWidget {
  final bool isImage;
  final XFile xFile;

  const PreviewAfterDrawCamera({
    super.key,
    required this.isImage,
    required this.xFile,
  });

  @override
  State<PreviewAfterDrawCamera> createState() => _PreviewAfterDrawCameraState();
}

class _PreviewAfterDrawCameraState extends State<PreviewAfterDrawCamera> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;

  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    color: AppColor.textColor,
  );

  @override
  void initState() {
    super.initState();

    _initVideo();
  }

  void _initVideo() {
    _videoPlayerController = VideoPlayerController.file(File(widget.xFile.path))
      ..initialize().then((_) async {
        await _videoPlayerController.setVolume(0.5);

        _chewieController = ChewieController(
          videoPlayerController: _videoPlayerController,
          autoPlay: true,
          looping: false,
          aspectRatio: _videoPlayerController.value.aspectRatio,
          materialProgressColors: ChewieProgressColors(
            playedColor: AppColor.primaryColor,
            handleColor: AppColor.primaryColor,
            backgroundColor: Colors.grey,
            bufferedColor: Colors.grey,
          ),
          placeholder: Container(
            color: Colors.black,
          ),
          showControls: true,
          customControls: const SizedBox(),
        );

        setState(() {});
      });
  }

  void _saveToGallery() async {

    List<Permission> permissions = [];
    AndroidDeviceInfo androidInfo = await DeviceInfoPlugin().androidInfo;
    permissions = [
      Permission.storage,
    ];

    if (androidInfo.version.sdkInt >= 33) {
      permissions.add(Permission.photos);
    }

    PermissionStatus status = await permissions.last.status;
    if (status != PermissionStatus.granted) {
      status = await permissions.last.request();
      if (status != PermissionStatus.granted) {
        Get.to(() => const DenyCameraScreen(
              isDenyPhoto: true,
            ));
        return;
      } else {
        final answer = await ImageGallerySaver.saveFile(
          widget.xFile.path,
          isReturnPathOfIOS: true,
        );

        if (answer['isSuccess'] as bool) {
          showToast(StringConstants.saveSuccess.tr);
        } else {
          showToast(StringConstants.saveFail.tr);
        }
      }
      // _saveToGallery();
    } else {
      final answer = await ImageGallerySaver.saveFile(
        widget.xFile.path,
        isReturnPathOfIOS: true,
      );

      if (answer['isSuccess'] as bool) {
        showToast(StringConstants.saveSuccess.tr);
      } else {
        showToast(StringConstants.saveFail.tr);
      }
    }
  }

  void _share() async {

    AppLog.info(widget.xFile.path);
    ShareResult result = await Share.shareXFiles([widget.xFile]);

    if (result.status == ShareResultStatus.success) {
      showToast(StringConstants.shareSuccess.tr);
    } else {
      showToast(StringConstants.shareFail.tr);
    }
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: StringConstants.preview.tr,
            onPressBack: () {
              _videoPlayerController.dispose();
              _chewieController?.dispose();
              Get.back();
            },
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.sp),
              ),
              padding: EdgeInsets.all(12.0.sp),
              child: Column(
                children: [
                  SizedBox(
                    height: 12.0.sp,
                  ),
                  Expanded(
                    child: widget.isImage
                        ? Image.file(File(widget.xFile.path))
                        : _chewieController == null
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : AspectRatio(
                                aspectRatio:
                                    _videoPlayerController.value.aspectRatio,
                                child: Chewie(
                                  controller: _chewieController!,
                                ),
                              ),
                  ),
                  widget.isImage
                      ? const SizedBox()
                      : SizedBox(
                          width: Get.width,
                          height: 80.0.sp,
                          child: CustomControlsVideo(
                            controller: _videoPlayerController,
                          ),
                        )
                ],
              ),
            ),
          ),
          Gap(50.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTouchable(
                onPressed: () async => _saveToGallery(),
                padding: EdgeInsets.symmetric(
                  horizontal: 43.sp,
                  vertical: 12.sp,
                ),
                radius: 8.0.sp,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8.sp),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 1.sp,
                  ),
                ),
                child: Text(
                  StringConstants.save.tr,
                  style: textStyle,
                ),
              ),
              Gap(20.sp),
              AppTouchable(
                onPressed: () => _share(),
                padding: EdgeInsets.symmetric(
                  horizontal: 43.sp,
                  vertical: 12.sp,
                ),
                radius: 8.0.sp,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor,
                  borderRadius: BorderRadius.circular(8.sp),
                  border: Border.all(
                    color: AppColor.primaryColor,
                    width: 1.sp,
                  ),
                ),
                child: Text(
                  StringConstants.share.tr,
                  style: textStyle.copyWith(color: Colors.white),
                ),
              ),
            ],
          ),
          Gap(30.sp),
        ],
      ),
    );
  }
}
