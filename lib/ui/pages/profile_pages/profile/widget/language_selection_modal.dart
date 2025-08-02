import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/global_bloc/setting/app_setting_cubit.dart';
import 'package:my_app/models/enums/language.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';

class LanguageSelectionModal extends StatelessWidget {
  const LanguageSelectionModal({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.textGray,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),

              // Title
              Padding(
                padding: EdgeInsets.all(AppDimens.paddingNormal),
                child: Text('language'.tr(), style: AppTextStyle.whiteS18Bold),
              ),

              // Language options
              _buildLanguageOption(
                context: context,
                language: Language.turkish,
                flagPath: AppSvg.tr,
                languageName: 'Türkçe',
                isSelected: state.language == Language.turkish,
              ),

              _buildLanguageOption(
                context: context,
                language: Language.english,
                flagPath: AppSvg.en,
                languageName: 'English',
                isSelected: state.language == Language.english,
              ),

              SizedBox(height: 20.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption({
    required BuildContext context,
    required Language language,
    required String flagPath,
    required String languageName,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        context.read<AppSettingCubit>().changeLanguage(language: language);
        print(language.name);
        if (language.name == "turkish") {
          context.locale = const Locale('tr');
        } else {
          context.locale = const Locale('en');
        }
        Navigator.of(context).pop();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppDimens.paddingNormal,
          vertical: AppDimens.paddingSmall,
        ),
        padding: EdgeInsets.all(AppDimens.paddingNormal),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.primary.withOpacity(0.2)
                  : AppColors.profileCardBackground,
          borderRadius: BorderRadius.circular(12.r),
          border:
              isSelected
                  ? Border.all(color: AppColors.primary, width: 2)
                  : null,
        ),
        child: Row(
          children: [
            // Flag
            AppSvgWidget(path: flagPath, width: 32.w, height: 24.h),

            SizedBox(width: AppDimens.marginNormal),

            // Language name
            Expanded(
              child: Text(languageName, style: AppTextStyle.whiteS16Medium),
            ),

            // Check icon if selected
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 24),
          ],
        ),
      ),
    );
  }
}
