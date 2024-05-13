import 'package:flutter/material.dart';

import '../../utils/share_preference_utils.dart';
import 'tooltip/tool_tip.dart';

class ToolTipWidget extends StatefulWidget {
  final Widget child;
  final Widget contentWidget;

  const ToolTipWidget({
    super.key,
    required this.child,
    required this.contentWidget,
  });

  @override
  State<ToolTipWidget> createState() => _ToolTipWidgetState();
}

class _ToolTipWidgetState extends State<ToolTipWidget> {
  final TooltipController _controller = TooltipController();

  bool _showTooltip = false;

  Future<bool> _willPopCallback() async {
    if (_controller.isVisible) {
      await _controller.hideTooltip();
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();

    _showTooltip = PreferenceUtils.getBool("``first_show_tooltip``") ?? true;

    if (_showTooltip) {
      setState(() {
        _controller.showTooltip();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: GestureDetector(
        onTap: () async {
          if (_controller.isVisible) {
            await _controller.hideTooltip();
            // PreferenceUtils.setBool("first_show_tooltip", false);
          } else {
            await _controller.showTooltip();
          }
        },
        child: SuperTooltip(
          showBarrier: false,
          controller: _controller,
          popupDirection: TooltipDirection.up,
          backgroundColor: const Color(0xFFFFFFFF),
          arrowTipDistance: 15.0,
          arrowBaseWidth: 20.0,
          arrowLength: 20.0,
          borderWidth: 2.0,
          constraints: const BoxConstraints(
            minHeight: 0.0,
            maxHeight: 100,
            minWidth: 0.0,
            maxWidth: 100,
          ),
          showCloseButton: ShowCloseButton.none,
          touchThroughAreaShape: ClipAreaShape.rectangle,
          touchThroughAreaCornerRadius: 30,
          barrierColor: const Color.fromARGB(26, 47, 45, 47),
          hasShadow: false,
          content: widget.contentWidget,
          child: widget.child,
        ),
      ),
    );
  }
}
