import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgWidget extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;
  final bool fromNetwork;

  const AppSvgWidget({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.fromNetwork = false,
  });

  @override
  Widget build(BuildContext context) {
    if (fromNetwork) {
      return SvgPicture.network(
        path,
        width: width,
        height: height,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        fit: fit,
        placeholderBuilder: (context) => const CircularProgressIndicator(),
      );
    } else {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        colorFilter:
            color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        fit: fit,
      );
    }
  }
}
