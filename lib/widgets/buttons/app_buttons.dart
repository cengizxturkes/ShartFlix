import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/widgets/loading/app_loading_indicator.dart';

class AppButton extends StatelessWidget {
  //Attributes
  final String title;
  final double width;
  final double height;
  final double borderWidth;
  final double cornerRadius;
  final Color? borderColor;
  final Color backgroundColor;
  final Color disableBackgroundColor;
  final TextStyle? textStyle;

  //Child widgets
  final Widget? leadingIcon;
  final Widget? trailingIcon;

  //Status
  final bool isLoading;

  //Action & callback
  final VoidCallback? onPressed;

  final EdgeInsets? padding;

  final List<BoxShadow>? boxShadow;

  final bool isEnabled;

  const AppButton({
    super.key,
    this.title = "",
    this.width = double.infinity,
    this.height = AppDimens.buttonHeight,
    this.borderWidth = 0,
    this.cornerRadius = AppDimens.buttonCornerRadius,
    this.borderColor,
    this.backgroundColor = AppColors.buttonColor,
    this.disableBackgroundColor = AppColors.buttonBGDisabled,
    this.textStyle,
    this.leadingIcon,
    this.trailingIcon,
    this.isLoading = false,
    this.onPressed,
    this.padding,
    this.boxShadow,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(cornerRadius.r),
        border:
            borderColor != null
                ? Border.all(color: borderColor!, width: borderWidth)
                : null,
        boxShadow: boxShadow,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(cornerRadius.r),
        child: Material(
          color: isEnabled ? backgroundColor : AppColors.gray1,
          borderRadius: BorderRadius.circular(cornerRadius.r),
          child: InkWell(
            onTap: isEnabled ? onPressed : null,
            child: Padding(
              padding: padding ?? EdgeInsets.zero,
              child: _buildChildWidget(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChildWidget() {
    if (isLoading) {
      return const AppCircularProgressIndicator();
    } else {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          leadingIcon ?? Container(),
          Expanded(
            child: Center(
              child:
                  title.isNotEmpty
                      ? Text(
                        title,
                        style: textStyle ?? AppTextStyle.whiteS15Regular,
                      )
                      : Container(),
            ),
          ),
          trailingIcon ?? Container(),
        ],
      );
    }
  }
}
