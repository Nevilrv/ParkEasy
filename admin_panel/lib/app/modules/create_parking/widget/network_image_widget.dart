import 'package:admin_panel/app/utils/constants.dart';
import 'package:admin_panel/app/utils/screen_size.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final Widget? errorWidget;
  final BoxFit? fit;
  final double? borderRadius;
  final Color? color;

  const NetworkImageWidget({
    Key? key,
    this.height,
    this.width,
    this.fit,
    required this.imageUrl,
    this.borderRadius,
    this.errorWidget,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius ?? 0),
      child: CachedNetworkImage(
        fit: fit ?? BoxFit.cover,
        height: height ?? ScreenSize.height(8, context),
        width: width ?? ScreenSize.width(15, context),
        imageUrl: imageUrl,
        color: color,
        progressIndicatorBuilder: (context, url, downloadProgress) => const Center(
          child: CircularProgressIndicator(color: Colors.black),
        ),
        errorWidget: (context, url, error) =>
            errorWidget ??
            Image.asset(
              Constant.userPlaceHolder,
              height: height ?? ScreenSize.height(8, context),
              width: width ?? ScreenSize.width(15, context),
            ),
      ),
    );
  }
}
