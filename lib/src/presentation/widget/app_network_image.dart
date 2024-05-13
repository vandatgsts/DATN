import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/app_utils.dart';
import 'app_loading.dart';

class AppNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? width, height;
  final double? loadingSize;
  final BoxFit? fit;

  const AppNetworkImage({
    Key? key,
    required this.imageUrl,
    this.height,
    this.width,
    this.loadingSize, this.fit,
  }) : super(key: key);

  Widget buildPlaceHolder() {
    return Center(
      child: SizedBox(
        width: loadingSize ?? 40.0.sp,
        height: loadingSize ?? 40.0.sp,
        child: AppLoading(
          size: loadingSize ?? 40.0.sp,
        ),
      ),
    );
  }

  Widget buildErrorWidget() {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: const Color(0xFFE7E7E7),
        borderRadius: BorderRadius.circular(12.0.sp),
        shape: BoxShape.rectangle,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 12.0.sp,
      ),
      child: Icon(
        Icons.error_outline,
        color: Colors.red,
        size: 24.0.sp,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return isNullEmpty(imageUrl)
        ? buildErrorWidget()
        : CachedNetworkImage(
            memCacheWidth: ((width ?? MediaQuery.of(context).size.width / 3) *
                    MediaQuery.of(context).devicePixelRatio)
                .round(),
            memCacheHeight:
                ((height ?? MediaQuery.of(context).size.height / 3) *
                        MediaQuery.of(context).devicePixelRatio)
                    .round(),
            width: width,
            height: height,
            imageUrl: imageUrl ?? '',
            placeholder: (context, url) {
              return buildPlaceHolder();
            },
            errorWidget: (context, url, error) {
              return buildErrorWidget();
            },
            filterQuality: FilterQuality.high,
            fit: fit ?? BoxFit.cover,
            useOldImageOnUrlChange: true,
            fadeInDuration: Duration.zero,
            cacheManager: CacheManager(
              Config(
                'ImageCacheKey',
                stalePeriod: const Duration(days: 30),
              ),
            ),
          );
  }
}
