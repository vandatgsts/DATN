import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../data/more_app_item.dart';
import '../../../../utils/app_image.dart';
import '../../../app/app_controller.dart';
import '../../../theme/app_color.dart';
import '../../../theme/app_text_theme.dart';
import '../../../widget/app_image_widget.dart';
import '../../../widget/app_touchable.dart';

class MoreAppWidget extends StatelessWidget {
  final MoreAppItem item;

  const MoreAppWidget({
    super.key,
    required this.item,
  });

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppTouchable(
      onPressed: () {
        Get.find<AppController>().avoidShowOpenApp = true;

        if (Platform.isAndroid) {
          Uri url = Uri.parse(
              'https://play.google.com/store/apps/details?id=${item.idAndroidApp}');
          _launchInBrowser(url);
        } else {
          StoreRedirect.redirect(
            iOSAppId: item.idIosApp,
          );
        }
      },
      margin: EdgeInsets.only(
        top: 4.0.sp,
        bottom: 6.0.sp,
      ),
      radius: 12.0.sp,
      padding: EdgeInsets.symmetric(
        horizontal: 12.0.sp,
        vertical: 10.0.sp,
      ),
      decoration: BoxDecoration(
        color: AppColor.white,
        borderRadius: BorderRadius.circular(12.sp),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(0, 4),
            blurRadius: 6,
          )
        ],
      ),
      child: Stack(
        children: [
          Row(
            children: [
              AppImageWidget.asset(
                path: item.icPath,
                width: 60.0.sp,
                height: 60.0.sp,
              ),
              SizedBox(
                width: 8.0.sp,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTextTheme.titleMedium(AppColor.textColor),
                    ),
                    Text(
                      item.subText,
                      style: AppTextTheme.bodySmall(AppColor.textColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            right: 0.0,
            child: AppImageWidget.asset(
              path: AppImage.labelAds,
              width: 24.0.sp,
            ),
          ),
        ],
      ),
    );
  }
}
