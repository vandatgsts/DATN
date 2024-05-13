import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/app_color.dart';

class AppLoading extends StatefulWidget {
  final Color? color;
  final Decoration? decoration;
  final double? size;
  final double? strokeValue;
  final Animation<Color?>? valueColor;

  const AppLoading({
    this.color,
    this.decoration,
    this.size,
    this.valueColor,
    Key? key,
    this.strokeValue,
  }) : super(key: key);

  @override
  AppLoadingState createState() => AppLoadingState();
}

class AppLoadingState extends State<AppLoading> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        height: widget.size ?? 40.0.sp,
        width: widget.size ?? 40.0.sp,
        decoration: widget.decoration ??
            BoxDecoration(
              color: widget.color ?? AppColor.white.withOpacity(0),
              shape: BoxShape.rectangle,
            ),
        child: CircularProgressIndicator(
          strokeWidth: widget.strokeValue ?? 2,
          valueColor: widget.valueColor ??
              const AlwaysStoppedAnimation(AppColor.loadingColor),
        ),
      ),
    );
  }
}
