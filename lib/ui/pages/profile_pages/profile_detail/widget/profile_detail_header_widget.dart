import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';

class ProfileDetailHeaderWidget extends StatelessWidget {
  final String userName;
  final String userId;
  final String? profileImageUrl;
  final VoidCallback? onAddPhotoPressed;

  const ProfileDetailHeaderWidget({
    super.key,
    required this.userName,
    required this.userId,
    this.profileImageUrl,
    this.onAddPhotoPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppDimens.paddingNormal.w),
      child: Row(
        children: [
          // Profile Picture
          Container(
            width: 61.w,
            height: 61.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.profileCardBackground,
            ),
            child:
                profileImageUrl != null
                    ? ClipOval(
                      child: Image.network(
                        profileImageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return _buildDefaultProfileIcon();
                        },
                      ),
                    )
                    : _buildDefaultProfileIcon(),
          ),
          SizedBox(width: 9.w),
          // User Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: AppTextStyle.whiteS14Medium.copyWith(fontSize: 15.sp),
                ),
                SizedBox(height: 4.h),
                Text('ID: $userId', style: AppTextStyle.grayS12Medium),
              ],
            ),
          ),
          SizedBox(width: 16.w),
          // Add Photo Button
          AppButton(
            title: 'Fotoğraf Ekle',
            width: 121.w,
            height: 36.h,
            backgroundColor: AppColors.buttonColor,
            cornerRadius: 8.r,
            onPressed: onAddPhotoPressed,
            textStyle: AppTextStyle.whiteS12Bold,
          ),
        ],
      ),
    );
  }

  Widget _buildDefaultProfileIcon() {
    return Icon(Icons.person, size: 30.w, color: AppColors.white);
  }
}
