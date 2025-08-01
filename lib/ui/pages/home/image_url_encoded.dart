import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';

import 'package:my_app/widgets/loading/app_loading_indicator.dart';

class ImageUrlEncoded extends StatefulWidget {
  final String imageUrl;
  final double? height;
  final BoxFit? fit;
  final double? width;
  const ImageUrlEncoded({
    super.key,
    required this.imageUrl,
    this.height,
    this.fit,
    this.width,
  });
  @override
  _ImageUrlEncodedState createState() => _ImageUrlEncodedState();
}

class _ImageUrlEncodedState extends State<ImageUrlEncoded> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: CachedNetworkImage(
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 300),
        imageUrl: widget.imageUrl.replaceAll("http:", "https:"),
        height: widget.height,
        width: widget.width ?? double.infinity,
        fit: widget.fit ?? BoxFit.cover,
        placeholder:
            (context, url) =>
                const Center(child: AppCircularProgressIndicator()),
        errorWidget:
            (context, url, error) => const Center(child: Icon(Icons.error)),
      ),
    );
  }
}
