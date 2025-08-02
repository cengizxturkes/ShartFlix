import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_text/app_text_style.dart';

class PhotoSelectionModal extends StatelessWidget {
  final Function() onCameraTap;
  final Function() onGalleryTap;

  const PhotoSelectionModal({
    super.key,
    required this.onCameraTap,
    required this.onGalleryTap,
  });

  @override
  Widget build(BuildContext context) {
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
            child: Text('Fotoğraf Seç', style: AppTextStyle.whiteS18Bold),
          ),

          // Photo options
          _buildPhotoOption(
            context: context,
            icon: Icons.camera_alt,
            title: 'Kamera',
            subtitle: 'Fotoğraf çek',
            onTap: onCameraTap,
          ),

          _buildPhotoOption(
            context: context,
            icon: Icons.photo_library,
            title: 'Galeri',
            subtitle: 'Galeriden seç',
            onTap: onGalleryTap,
          ),

          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildPhotoOption({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        onTap();
      },
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: AppDimens.paddingNormal,
          vertical: AppDimens.paddingSmall,
        ),
        padding: EdgeInsets.all(AppDimens.paddingNormal),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Icon
            Container(
              width: 48.w,
              height: 48.h,
              decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(icon, color: AppColors.primary, size: 24),
            ),

            SizedBox(width: AppDimens.marginNormal),

            // Text content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.whiteS16Medium),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: AppTextStyle.whiteS12Regular.copyWith(
                      color: AppColors.textGray,
                    ),
                  ),
                ],
              ),
            ),

            // Arrow icon
            Icon(Icons.arrow_forward_ios, color: AppColors.textGray, size: 16),
          ],
        ),
      ),
    );
  }
}
