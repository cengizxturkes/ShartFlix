import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/ui/pages/profile_pages/profile/widget/profile_widgets.dart';

class ProfileMenuList extends StatelessWidget {
  final List<ProfileMenuSection> sections;
  const ProfileMenuList({super.key, required this.sections});
  @override
  Widget build(BuildContext context) {
    return Column(
      children:
          sections.map((section) {
            return Column(
              children: [
                ProfileSectionWidget(
                  title: section.translationKey?.tr() ?? section.title,
                  children:
                      section.items.map((item) {
                        return ProfileMenuItemWidget(
                          icon: item.icon,
                          title: item.translationKey.tr(),
                          onTap: item.onTap,
                          showArrow: item.showArrow,
                          trailing: item.trailing,
                        );
                      }).toList(),
                ),
                if (section != sections.last) SizedBox(height: 24.h),
              ],
            );
          }).toList(),
    );
  }
}
