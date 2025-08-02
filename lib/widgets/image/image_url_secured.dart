import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/widgets/loading/app_loading_indicator.dart';

class ImageUrlSecured extends StatefulWidget {
  final String imageUrl;
  final double? height;
  final BoxFit? fit;
  final double? width;
  const ImageUrlSecured({
    super.key,
    required this.imageUrl,
    this.height,
    this.fit,
    this.width,
  });
  @override
  _ImageUrlSecuredState createState() => _ImageUrlSecuredState();
}

class _ImageUrlSecuredState extends State<ImageUrlSecured> {
  @override
  void initState() {
    super.initState();
  }

  String secureUrl(String url) {
    if (url.startsWith('http://')) {
      return url.replaceFirst('http://', 'https://');
    }
    return url;
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12.r),
      child: CachedNetworkImage(
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 300),
        imageUrl: secureUrl(widget.imageUrl),
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
