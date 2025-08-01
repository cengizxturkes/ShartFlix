import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_images/app_images.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/ui/pages/home/home_cubit.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //Header Logo
          Image.asset(
            AppImages.sinFlixLogo,
            width: AppDimens.logoWidth.w,
            height: AppDimens.logoHeight.h,
          ),
          //Header Search Icon
          AppSvgWidget(path: AppSvg.search, color: AppColors.white),
        ],
      ),
    );
  }
}
