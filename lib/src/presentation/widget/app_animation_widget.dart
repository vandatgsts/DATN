import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class AppAnimationWidget extends StatefulWidget {
  final String path;
  final BoxFit? fit;
  final double? width;
  final double? height;
  final int? duration;

  const AppAnimationWidget({
    super.key,
    required this.path,
    this.fit,
    this.width,
    this.height,
    this.duration,
  });

  @override
  State<AppAnimationWidget> createState() => _AppAnimationWidgetState();
}

class _AppAnimationWidgetState extends State<AppAnimationWidget>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: widget.duration ?? 750),
    );

    // _controller.addListener(() {
    //   if (_controller.value > 0.5) {
    //     _controller.value = 0.5;
    //   }
    // });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      widget.path,
      fit: widget.fit,
      width: widget.width,
      repeat: true,
      controller: _controller,
      height: widget.height,
      onLoaded: (comp) {
        _controller.duration = comp.duration;
        _controller.forward(from: 0);
        _controller.repeat();
      },

    );
  }
}
