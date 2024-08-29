import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class CachedImage extends StatelessWidget {
  final double? placeHolerSize;
  final double? imageWidth;
  final double? imageHeight;
  final String imageUrl;
  final BoxShape boxShape;
  final Color? color;
  const CachedImage({
    Key? key,
    this.placeHolerSize = 40,
    this.imageWidth,
    this.imageHeight,
    this.imageUrl = "",
    this.boxShape = BoxShape.rectangle,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != ""
        ? CachedNetworkImage(
            placeholder: (context, imageUrl) => SizedBox(
              width: placeHolerSize!.sp,
              height: placeHolerSize!.sp,
              child: Container(
                width: imageWidth,
                height: imageHeight,
                alignment: Alignment.center,
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.appColor),
                ),
              ),
            ),
            errorWidget: (context, imageUrl, error) => Center(
              child: Container(),
            ),
            imageBuilder: (context, imageProvider) => Container(
              width: imageWidth,
              height: imageHeight,
              decoration: BoxDecoration(
                shape: boxShape,
                image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
              ),
            ),
            imageUrl: imageUrl,
            color: color,
          )
        : Container();
  }
}
