import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../theme/app_color.dart';
import '../widget/app_container.dart';
import '../widget/app_header.dart';

class WebViewScreen extends StatefulWidget {
  final String url;
  final String? title;

  const WebViewScreen({
    Key? key,
    required this.url,
    this.title,
  }) : super(key: key);

  @override
  State<WebViewScreen> createState() => _WebViewScreenState();
}

class _WebViewScreenState extends State<WebViewScreen> {
  InAppWebViewController? _webViewController;

  bool _isLoading = true;

  final GlobalKey webViewKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _webViewController?.loadUrl(
      urlRequest: URLRequest(
        url: WebUri(
          widget.url,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: widget.title ?? "",
          ),
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  key: webViewKey,
                  onLoadStart: (controller, url) async {
                    setState(() {
                      _isLoading = true;
                    });
                  },
                  onLoadStop: (controller, url) {
                    setState(() {
                      _isLoading = false;
                    });
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      setState(() {
                        _isLoading = false;
                      });
                    }
                  },
                  initialUrlRequest: URLRequest(
                    url: WebUri(widget.url),
                  ),
                ),
                Positioned.fill(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.primaryColor,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
