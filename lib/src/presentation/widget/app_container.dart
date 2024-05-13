import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../theme/app_color.dart';

class AppContainer extends GetView {
  const AppContainer({
    Key? key,
    this.appBar,
    this.onWillPop,
    this.bottomNavigationBar,
    this.child,
    this.backgroundColor,
    this.coverScreenWidget,
    this.resizeToAvoidBottomInset = false,
    this.floatingActionButton,
    this.showBanner = false,
    this.isCollapsible = true,
    this.havePadding = true,
  }) : super(key: key);

  final PreferredSizeWidget? appBar;
  final Future<bool> Function()? onWillPop;
  final Widget? bottomNavigationBar;
  final Widget? child;
  final Color? backgroundColor;
  final Widget? coverScreenWidget;
  final bool? resizeToAvoidBottomInset;
  final Widget? floatingActionButton;
  final bool showBanner;
  final bool isCollapsible;
  final bool havePadding;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop ?? () async => false,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: resizeToAvoidBottomInset,
              backgroundColor: backgroundColor ?? AppColor.backgroundColor,
              appBar: appBar,
              body: SizedBox(
                width: Get.width,
                height: Get.height,
                child: havePadding
                    ? Padding(
                        padding: EdgeInsets.only(
                          left: 12.0.sp,
                          right: 12.0.sp,
                          bottom:
                              MediaQuery.of(context).padding.bottom + 4.0.sp,
                        ),
                        child: child ?? const SizedBox.shrink(),
                      )
                    : Padding(
                        padding: EdgeInsets.only(
                          bottom:
                              MediaQuery.of(context).padding.bottom,
                        ),
                        child: child ?? const SizedBox.shrink(),
                      ),
              ),
              floatingActionButton: floatingActionButton,
              bottomNavigationBar: bottomNavigationBar,
            ),
          ),
          coverScreenWidget == null
              ? const SizedBox.shrink()
              : coverScreenWidget!,
        ],
      ),
    );
  }
}
