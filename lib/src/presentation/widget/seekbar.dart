import 'package:flutter/material.dart';

class SeekBar extends StatefulWidget {
  final double progressWidth;
  final double minValue;
  final double maxValue;
  final double width;
  final double thumbRadius;
  final double value;
  final double secondValue;
  final Color barColor;
  final Color progressColor;
  final Color secondProgressColor;
  final Color thumbColor;
  final VoidCallback? onStartTrackingTouch;
  final ValueChanged<double>? onProgressChanged;
  final VoidCallback? onStopTrackingTouch;

  const SeekBar({
    Key? key,
    required this.width,
    this.minValue = 0.0,
    this.maxValue = 1.0,
    this.progressWidth = 2.0,
    this.thumbRadius = 7.0,
    this.value = 0.0,
    this.secondValue = 0.0,
    this.barColor = const Color(0x73FFFFFF),
    this.progressColor = Colors.white,
    this.secondProgressColor = const Color(0xBBFFFFFF),
    this.thumbColor = Colors.white,
    this.onStartTrackingTouch,
    this.onProgressChanged,
    this.onStopTrackingTouch,
  }) : super(key: key);

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  late double _value;
  late double _secondValue;

  @override
  void initState() {
    super.initState();
    _value = widget.value.clamp(widget.minValue, widget.maxValue);
    _secondValue = widget.secondValue.clamp(widget.minValue, widget.maxValue);
  }

  @override
  void didUpdateWidget(SeekBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    _value = widget.value.clamp(widget.minValue, widget.maxValue);
    _secondValue = widget.secondValue.clamp(widget.minValue, widget.maxValue);
  }

  void _updateValue(Offset localPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final double dx = localPosition.dx;
    final double newPos =
        dx / box.size.width; // Tính toán phần trăm dựa trên chiều rộng hiện tại
    final double range = widget.maxValue - widget.minValue;
    final double newValue = (newPos * range) +
        widget.minValue; // Chuyển đổi phần trăm thành giá trị thực tế
    setState(() {
      _value = newValue.clamp(widget.minValue, widget.maxValue);
    });
    widget.onProgressChanged?.call(_value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        _updateValue(details.localPosition);
      },
      onHorizontalDragStart: (details) {
        widget.onStartTrackingTouch?.call();
        _updateValue(details.localPosition);
      },
      onHorizontalDragEnd: (details) {
        widget.onStopTrackingTouch?.call();
      },
      onTapDown: (details) {
        widget.onStartTrackingTouch?.call();
        _updateValue(details.localPosition);
        widget.onStopTrackingTouch?.call();
      },
      child: CustomPaint(
        size: Size(widget.width, widget.thumbRadius * 2),
        painter: _SeekBarPainter(
          progressWidth: widget.progressWidth,
          minValue: widget.minValue,
          maxValue: widget.maxValue,
          thumbRadius: widget.thumbRadius,
          value: _value,
          secondValue: _secondValue,
          barColor: widget.barColor,
          progressColor: widget.progressColor,
          secondProgressColor: widget.secondProgressColor,
          thumbColor: widget.thumbColor,
        ),
      ),
    );
  }
}

class _SeekBarPainter extends CustomPainter {
  final double progressWidth;
  final double thumbRadius;
  final double minValue;
  final double maxValue;
  final double value;
  final double secondValue;
  final Color barColor;
  final Color progressColor;
  final Color secondProgressColor;
  final Color thumbColor;

  _SeekBarPainter({
    required this.progressWidth,
    required this.thumbRadius,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.secondValue,
    required this.barColor,
    required this.progressColor,
    required this.secondProgressColor,
    required this.thumbColor,
  });

  @override
  bool shouldRepaint(_SeekBarPainter old) {
    return value != old.value || secondValue != old.secondValue;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..isAntiAlias = true
      ..strokeCap = StrokeCap.round
      ..strokeWidth = progressWidth;
    final centerY = size.height / 2;
    final Offset startPoint = Offset(thumbRadius, centerY);
    final Offset endPoint = Offset(size.width - thumbRadius, centerY);

    // Draw the background bar
    paint.color = barColor;
    canvas.drawLine(startPoint, endPoint, paint);

    // Draw the secondary progress
    final Offset secondProgressPoint = Offset(size.width, centerY);
    paint.color = secondProgressColor;
    canvas.drawLine(startPoint, secondProgressPoint, paint);

    // Draw the primary progress
// Trong _SeekBarPainter

    final Offset progressPoint = Offset(
        thumbRadius +
            ((size.width - thumbRadius * 2) *
                ((value - minValue) / (maxValue - minValue))),
        centerY);

    paint.color = progressColor;
    canvas.drawLine(startPoint, progressPoint, paint);

    // Draw the thumb as a circle
    final Paint thumbPaint = Paint()
      ..color = thumbColor
      ..isAntiAlias = true;
    canvas.drawCircle(progressPoint, thumbRadius, thumbPaint);
  }
}
