import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_image.dart';
import '../theme/app_color.dart';
import '../theme/app_text_theme.dart';
import 'app_image_widget.dart';
import 'app_touchable.dart';

class AppHeader extends StatelessWidget {
  final String? title;
  final String? hintContent;
  final String? hintTitle;
  final Widget? leftWidget;
  final Widget? rightWidget;
  final Widget? middleWidget;
  final Widget? extendWidget;
  final CrossAxisAlignment? crossAxisAlignmentMainRow;
  final TextStyle? titleTextStyle;
  final Color? backgroundColor;
  final double? radius;
  final double? paddingBottom;
  final List<BoxShadow>? shadowHeader;
  final Function()? onPressBack;

  const AppHeader({
    Key? key,
    this.title,
    this.leftWidget,
    this.rightWidget,
    this.middleWidget,
    this.extendWidget,
    this.crossAxisAlignmentMainRow,
    this.hintContent,
    this.hintTitle,
    this.onPressBack,
    this.titleTextStyle,
    this.backgroundColor,
    this.radius,
    this.paddingBottom,
    this.shadowHeader,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(
        0.0,
        MediaQuery.of(context).padding.top + 6.0.sp,
        0.0,
        paddingBottom ?? 12.0.sp,
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppColor.backgroundColor,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(radius ?? 12.0.sp),
          bottomLeft: Radius.circular(radius ?? 12.0.sp),
        ),
        boxShadow: shadowHeader,
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment:
                crossAxisAlignmentMainRow ?? CrossAxisAlignment.center,
            children: [
              leftWidget ??
                  AppTouchable(
                    width: 40.0.sp,
                    height: 40.0.sp,
                    padding: EdgeInsets.all(5.0.sp),
                    margin: EdgeInsets.only(left: 10.sp),
                    onPressed: onPressBack ?? Get.back,
                    child: AppImageWidget.asset(
                      path: AppImage.icBack,
                    ),
                  ),
              Expanded(
                child: middleWidget ??
                    Text(
                      title ?? '',
                      textAlign: TextAlign.center,
                      style: titleTextStyle ??
                          AppTextTheme.titleLarge(AppColor.textColor)?.copyWith(
                              fontWeight: FontWeight.w400,
                              fontSize: 18.sp,
                              fontFamily: "ShortStack"),
                    ),
              ),
              SizedBox(width: 40.0.sp),
            ],
          ),
          extendWidget ?? const SizedBox.shrink(),
        ],
      ),
    );
  }
}
