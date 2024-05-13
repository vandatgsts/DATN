import 'package:ar_drawing/src/presentation/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../native_bridge/in_app_review/in_app_review.dart';
import '../../../resource/string/app_string.dart';
import '../../../utils/app_image.dart';
import '../../../utils/share_preference_utils.dart';
import '../../theme/app_color.dart';
import '../../theme/short_stack_text_theme.dart';
import '../app_button.dart';
import '../app_image_widget.dart';
import 'rating_bar.dart';

class RatingDialog extends StatefulWidget {
  const RatingDialog({Key? key}) : super(key: key);

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  double _rating = 5.0;

  bool firstRate = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      firstRate = PreferenceUtils.getBool("first_rate") ?? true;

      setState(() {});
    });
  }

  Widget _closeButton() {
    return AppButton(
      onTap: () => Get.back(),
      text: StringConstants.close.tr,
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 18.0,
      ),
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
        side: const BorderSide(
          color: AppColor.primaryColor,
          width: 1.0,
        ),
      ),
      color: AppColor.white,
      textColor: AppColor.textColor,
      fontWeight: FontWeight.w600,
      fontSize: 16.0.sp,
    );
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  Widget _rateButton() {
    return AppButton(
      onTap: () async {
        if (_rating <= 3.0) {
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: 'i2s.team.coding@gmail.com', // Địa chỉ email của người nhận
            query: _encodeQueryParameters({
              'subject': 'Feedback for App Ar Drawing',
              'body': '',
            }),
          );

          if (!await launchUrl(Uri.parse(emailLaunchUri.toString()))) {
            throw Exception(
                'Could not launch ${Uri.parse(emailLaunchUri.toString())}');
          }

          Get.back();
        } else {
          await PreferenceUtils.setBool("first_rate", false);
          Get.find<AppController>().isFirstRate = false;

          final InAppReview inAppReview = InAppReview.instance;
          if (await inAppReview.isAvailable()) {
            await inAppReview.requestReview();
          }

          Get.back();
        }
      },
      text: StringConstants.rate.tr,
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 18.0,
      ),
      shapeBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
      ),
      color: AppColor.primaryColor,
      textColor: AppColor.white,
      fontWeight: FontWeight.w600,
      fontSize: 16.0.sp,
    );
  }

  Widget _buildRateMoreThan3() {
    return !firstRate
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: Get.width * 0.1),
              Expanded(
                child: _closeButton(),
              ),
              SizedBox(width: Get.width * 0.1),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: Get.width * 0.1),
              Expanded(
                child: _closeButton(),
              ),
              SizedBox(width: Get.width * 0.06),
              Expanded(
                child: _rateButton(),
              ),
              SizedBox(width: Get.width * 0.1),
            ],
          );
  }

  Widget _buildRateLessThan3() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(width: Get.width * 0.1),
        Expanded(
          child: _closeButton(),
        ),
        SizedBox(width: Get.width * 0.06),
        Expanded(
          child: _rateButton(),
        ),
        SizedBox(width: Get.width * 0.1),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AlertDialog(
        elevation: 0.0,
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(
              10.0.sp,
            ),
          ),
        ),
        contentPadding: const EdgeInsets.only(
          top: 10.0,
        ),
        content: SizedBox(
          width: Get.width * 0.9,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: Get.height * 0.01),
              Text(
                StringConstants.rate.tr,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColor.textColor,
                  fontSize: 16.0.sp,
                  fontFamily: "ShortStack",
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.15,
                ),
              ),
              SizedBox(height: Get.height * 0.01),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.sp),
                child: Text(
                  _rating == 5
                      ? StringConstants.subRate5.tr
                      : _rating == 4
                          ? StringConstants.subRate4.tr
                          : _rating == 3
                              ? StringConstants.subRate3.tr
                              : StringConstants.subRate12.tr,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: const Color(0xFF3A3A3A),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: Get.height * 0.03),
              Row(
                children: [
                  SizedBox(width: 50.sp),
                  AppImageWidget.asset(path: AppImage.icArrowRate),
                  SizedBox(width: 30.sp),
                  AppImageWidget.asset(
                    path: _rating == 5
                        ? AppImage.icRate5
                        : _rating == 4
                            ? AppImage.icRate4
                            : _rating == 3
                                ? AppImage.icRate3
                                : _rating == 2
                                    ? AppImage.icRate2
                                    : AppImage.icRate1,
                  ),
                ],
              ),
              SizedBox(height: 6.sp),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                itemCount: 5,
                itemSize: 50.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 1.0.sp),
                itemBuilder: (context, _) => SvgPicture.asset(
                  AppImage.selectedStar,
                ),
                onRatingUpdate: (rating) {
                  setState(() {
                    _rating = rating;
                  });
                },
                updateOnDrag: true,
              ),
              SizedBox(height: Get.height * 0.02),
              _rating > 3.0 ? _buildRateMoreThan3() : _buildRateLessThan3(),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
