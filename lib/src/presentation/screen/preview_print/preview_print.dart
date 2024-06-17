import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../resource/string/app_string.dart';
import '../../../utils/firebase_analytics.dart';
import '../../dialog/print_dialog.dart';
import '../../theme/app_color.dart';
import '../../widget/app_container.dart';
import '../../widget/app_header.dart';
import '../../widget/app_touchable.dart';

class PreviewPrint extends StatefulWidget {
  final Uint8List byteData;

  const PreviewPrint({
    super.key,
    required this.byteData,
  });

  @override
  State<PreviewPrint> createState() => _PreviewPrintState();
}

class _PreviewPrintState extends State<PreviewPrint> {
  TextStyle textStyle = TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
    color: Colors.white,
  );

  @override
  void initState() {
    super.initState();
  }

  void printImageFromByteData() async {

    final doc = pw.Document();

    final image = pw.MemoryImage(widget.byteData);

    doc.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Center(child: pw.Image(image));
      },
    ));

    await Printing.layoutPdf(
      onLayout: (format) async => doc.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppContainer(
      child: Column(
        children: [
          AppHeader(
            title: StringConstants.preview.tr,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.sp),
              ),
              padding: EdgeInsets.all(12.0.sp),
              child: Image.memory(widget.byteData),
            ),
          ),
          Gap(100.sp),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppTouchable(
                  onPressed: () async => showPrintDialog(
                        context,
                        onPressCancel: Get.back,
                        onPressConnect: printImageFromByteData,
                      ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 43.sp,
                    vertical: 12.sp,
                  ),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(8.sp),
                    border: Border.all(
                      color: AppColor.primaryColor,
                      width: 1.sp,
                    ),
                  ),
                  child: Text(
                    StringConstants.print.tr,
                    style: textStyle,
                  )),
              Gap(20.sp),
            ],
          ),
          Gap(MediaQuery.of(context).padding.bottom + 24.sp),
        ],
      ),
    );
  }
}
