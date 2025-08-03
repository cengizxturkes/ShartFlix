import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_text/app_text_style.dart';

import 'package:my_app/ui/pages/profile_pages/profile/profile_cubit.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_state.dart';
import 'package:my_app/widgets/image/full_screen_image_preview.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final VoidCallback? onBackPressed;

  const ProfileHeaderWidget({super.key, this.onBackPressed});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final user = state.profileResponse?.data;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const SizedBox(height: AppDimens.marginNormal),
              Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: AppColors.gray2,
                      shape: BoxShape.circle,
                    ),
                    child:
                        (user?.photoUrl.isNotEmpty ?? false)
                            ? GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder:
                                      (context) => AppFullScreenImageViewer(
                                        url: user.photoUrl,
                                        onClose: () => Navigator.pop(context),
                                      ),
                                );
                              },
                              child: ClipOval(
                                child: Image.network(
                                  user!.photoUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (_, __, ___) => Icon(
                                        Icons.person,
                                        size: 40,
                                        color: AppColors.textGray,
                                      ),
                                ),
                              ),
                            )
                            : Icon(
                              Icons.person,
                              size: 40,
                              color: AppColors.textGray,
                            ),
                  ),
                  const SizedBox(width: AppDimens.marginNormal),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.name ?? '---',
                          style: AppTextStyle.whiteS15Regular,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? '',
                          style: AppTextStyle.grayS12Medium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
