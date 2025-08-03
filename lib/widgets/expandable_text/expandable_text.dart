import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_text/app_text_style.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int maxCharacters;
  final TextStyle? textStyle;
  final TextStyle? buttonStyle;

  const ExpandableText({
    super.key,
    required this.text,
    this.maxCharacters = 50,
    this.textStyle,
    this.buttonStyle,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final shouldShowButton = widget.text.length > widget.maxCharacters;

    if (!shouldShowButton) {
      return Text(
        widget.text,
        style:
            widget.textStyle ?? AppTextStyle.whiteS12.copyWith(fontSize: 13.sp),
      );
    }

    return RichText(
      text: TextSpan(
        style:
            widget.textStyle ?? AppTextStyle.whiteS12.copyWith(fontSize: 13.sp),
        children: [
          TextSpan(
            text:
                _isExpanded
                    ? widget.text
                    : widget.text.substring(0, widget.maxCharacters),
          ),
          if (!_isExpanded)
            TextSpan(
              text: '... ${'more'.tr()}',
              style:
                  widget.buttonStyle ??
                  AppTextStyle.whiteS12.copyWith(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () => setState(() => _isExpanded = true),
            ),
          if (_isExpanded)
            TextSpan(
              text: '  ${'less'.tr()}',
              style:
                  widget.buttonStyle ??
                  AppTextStyle.whiteS12.copyWith(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
              recognizer:
                  TapGestureRecognizer()
                    ..onTap = () => setState(() => _isExpanded = false),
            ),
        ],
      ),
    );
  }
}
