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

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          _isExpanded
              ? widget.text
              : '${widget.text.substring(0, widget.maxCharacters)}...',
          style:
              widget.textStyle ??
              AppTextStyle.whiteS12.copyWith(fontSize: 13.sp),
          maxLines: _isExpanded ? null : 3,
          overflow: _isExpanded ? null : TextOverflow.ellipsis,
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _isExpanded = !_isExpanded;
            });
          },
          child: Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Text(
              _isExpanded ? 'daha azını gör' : 'Daha Fazlası',
              style:
                  widget.buttonStyle ??
                  AppTextStyle.whiteS12.copyWith(
                    color: Colors.white,
                    decoration: TextDecoration.underline,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
