import 'package:flutter/material.dart';

class InnerShadowContainer extends StatelessWidget {
  final Widget child;
  final BorderRadius borderRadius;
  final Color shadowColor;
  final double blur;
  final double offset;

  const InnerShadowContainer({
    super.key,
    required this.child,
    this.borderRadius = BorderRadius.zero,
    this.shadowColor = Colors.white54,
    this.blur = 6,
    this.offset = 0,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _InnerShadowPainter(
        borderRadius: borderRadius,
        shadowColor: shadowColor,
        blur: blur,
        offset: offset,
      ),
      child: child,
    );
  }
}

class _InnerShadowPainter extends CustomPainter {
  final BorderRadius borderRadius;
  final Color shadowColor;
  final double blur;
  final double offset;

  _InnerShadowPainter({
    required this.borderRadius,
    required this.shadowColor,
    required this.blur,
    required this.offset,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = borderRadius.toRRect(rect);

    // Mask layer
    canvas.saveLayer(rect, Paint());

    // Draw shadow
    final paint =
        Paint()
          ..color = shadowColor
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, blur);

    // Draw outer rect bigger than rrect
    canvas.drawRRect(rrect.shift(Offset(offset, offset)), paint);

    // Draw cutout with blend mode clear to create inner shadow effect
    paint.blendMode = BlendMode.clear;
    canvas.drawRRect(rrect, paint);

    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
