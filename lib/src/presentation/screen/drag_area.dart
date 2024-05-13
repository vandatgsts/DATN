import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../widget/matrix_gesture_detector.dart';

class DragArea extends StatefulWidget {
  final Widget child;

  const DragArea({
    super.key,
    required this.child,
  });

  @override
  State<DragArea> createState() => _DragAreaState();
}

class _DragAreaState extends State<DragArea> {
  final ValueNotifier<Matrix4> notifier = ValueNotifier(Matrix4.identity());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Get.height,
      width: Get.width,
      child: MatrixGestureDetector(
        onMatrixUpdate: (m, tm, sm, rm) => notifier.value = m,
        onScaleStart: () {},
        onScaleEnd: () {},
        child: AnimatedBuilder(
          animation: notifier,
          builder: (ctx, child) {
            return Transform(
              transform: notifier.value,
              child: widget.child,
            );
          },
        ),
      ),
    );
  }
}
