import 'package:flutter/material.dart';

import '../../utils/disable_glow_behavior.dart';

class AppScrollview extends StatelessWidget {
  final Widget child;
  final ScrollController? controller;
  final EdgeInsets? padding;
  final ScrollPhysics? physics;

  const AppScrollview({
    Key? key,
    required this.child,
    this.controller,
    this.padding,
    this.physics,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: DisableGlowBehavior(),
      child: SingleChildScrollView(
        padding: padding ?? EdgeInsets.zero,
        scrollDirection: Axis.vertical,
        reverse: false,
        physics: physics ?? const ClampingScrollPhysics(),
        controller: controller,
        child: child,
      ),
    );
  }
}
