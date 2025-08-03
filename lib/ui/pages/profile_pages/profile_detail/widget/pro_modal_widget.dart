// ignore_for_file: deprecated_member_use

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_images/app_images.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';
import 'package:my_app/widgets/inner_shadow_container.dart';

class ProModalWidget extends StatefulWidget {
  final VoidCallback onClose;
  final VoidCallback onSeeAllTokens;

  const ProModalWidget({
    super.key,
    required this.onClose,
    required this.onSeeAllTokens,
  });

  @override
  State<ProModalWidget> createState() => _ProModalWidgetState();
}

class _ProModalWidgetState extends State<ProModalWidget> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20.r),
        topRight: Radius.circular(20.r),
      ),
      child: Container(
        height: 654.h,
        decoration: BoxDecoration(color: AppColors.background),
        child: Stack(
          children: [
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 108.695.w,
              top: -83.74.h,
              child: Container(
                width: 217.39.w,
                height: 217.39.h,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  shape: BoxShape.circle,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 108.125, sigmaY: 108.125),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: MediaQuery.of(context).size.width / 2 - 108.695.w,
              top: 503.12.h,
              child: Container(
                width: 217.39.w,
                height: 217.39.h,
                decoration: BoxDecoration(
                  color: AppColors.red,
                  shape: BoxShape.circle,
                ),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 125, sigmaY: 125),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                children: [
                  Text('limitedOffer'.tr(), style: AppTextStyle.whiteS20Bold),
                  SizedBox(height: 10.h),
                  Text(
                    'Jeton paketin\'ni seçerek bonus\nkazanın ve yeni bölümlerin kilidini açın!',
                    style: AppTextStyle.whiteS12Regular,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    width: 366.08.w,
                    height: 173.71.h,
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 22.h,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                      gradient: RadialGradient(
                        center: Alignment(0.09, 0),
                        radius: 1.65,
                        colors: [
                          Colors.white.withOpacity(0.1),
                          Colors.white.withOpacity(0.03),
                        ],
                        stops: [0, 1],
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          'youWillGet'.tr(),
                          style: AppTextStyle.whiteS16Bold.copyWith(
                            fontSize: 15.sp,
                          ),
                        ),
                        SizedBox(height: 14.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildBonusItem(
                              icon: AppImages.pro_diamond,
                              label: "premiumAccount".tr(),
                            ),
                            _buildBonusItem(
                              icon: AppImages.heart,
                              label: "moreMatches".tr(),
                            ),
                            _buildBonusItem(
                              icon: AppImages.trending,
                              label: "moreViews".tr(),
                            ),
                            _buildBonusItem(
                              icon: AppImages.aheart,
                              label: "moreLikes".tr(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 21.h),
                  Text(
                    'selectTokenPackage'.tr(),
                    style: AppTextStyle.whiteS16Bold,
                  ),
                  SizedBox(height: 30.h),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          child: _buildTokenPackage(
                            bonus: '+10%',
                            originalAmount: '200',
                            newAmount: '330',
                            price: '₺99,99',
                            isRecommended: false,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _buildTokenPackage(
                            bonus: '+70%',
                            originalAmount: '2.000',
                            newAmount: '3.375',
                            price: '₺799,99',
                            isRecommended: true,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: _buildTokenPackage(
                            bonus: '+35%',
                            originalAmount: '1.000',
                            newAmount: '1.350',
                            price: '₺399,99',
                            isRecommended: false,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // See all tokens button
                  AppButton(
                    title: 'seeAllTokens'.tr(),
                    cornerRadius: 18.r,
                    onPressed: widget.onSeeAllTokens,
                    textStyle: AppTextStyle.whiteS14Medium.copyWith(
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBonusItem({required String icon, required String label}) {
    String formattedLabel = label.replaceAll(' ', '\n');
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                InnerShadowCircle(size: 55.w),
                Image.asset(icon, width: 33.w, height: 33.h),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        SizedBox(
          width: 60.w,
          child: Text(
            formattedLabel,
            style: AppTextStyle.whiteS12,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.visible,
            softWrap: true,
          ),
        ),
      ],
    );
  }

  Widget _buildTokenPackage({
    required String bonus,
    required String originalAmount,
    required String newAmount,
    required String price,
    required bool isRecommended,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            gradient:
                isRecommended
                    ? LinearGradient(
                      colors: [
                        const Color(0xff6A4FF2),
                        const Color(0xff5949E6),
                        const Color(0xffE50914),
                      ],
                      stops: const [0.0, 0.1, 1.0],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                    : null,
            color: isRecommended ? null : AppColors.red,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.white, width: 1),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10.h),
              Text(
                originalAmount,
                style: AppTextStyle.whiteS15Regular.copyWith(
                  decoration: TextDecoration.lineThrough,
                  decorationColor: AppColors.white.withOpacity(0.3),
                ),
              ),
              Text(
                newAmount,
                style: AppTextStyle.whiteS24.copyWith(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w900,
                ),
              ),
              Text('jeton'.tr(), style: AppTextStyle.whiteS15Regular),
              SizedBox(height: 35.h),
              Container(
                width: 87.w,
                child: Divider(
                  color: AppColors.white.withOpacity(0.1),
                  height: 1,
                  thickness: 1,
                ),
              ),
              SizedBox(height: 13.h),
              // Price
              Text(
                price,
                style: AppTextStyle.whiteS16Bold.copyWith(fontSize: 15.sp),
              ),
              SizedBox(height: 8.h),
              Text(
                'perWeek'.tr(),
                style: AppTextStyle.whiteS12Regular.copyWith(fontSize: 11.sp),
                maxLines: 1,
              ),
            ],
          ),
        ),
        Positioned(
          top: -12.h,
          left: 0,
          right: 0,
          child: Center(
            child: InnerShadowContainer(
              borderRadius: BorderRadius.circular(12.r),
              shadowColor: Colors.white.withOpacity(0.5),
              blur: 10,
              offset: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color:
                      isRecommended ? Color(0xff5949E6) : AppColors.buttonColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.white, width: 1.w),
                ),
                child: Text(bonus, style: AppTextStyle.whiteS12Bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InnerShadowCircle extends StatelessWidget {
  final double size;

  const InnerShadowCircle({super.key, this.size = 55});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(size: Size(size, size), painter: _InnerShadowPainter());
  }
}

class _InnerShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;

    // Ana dolgu rengi
    final paint = Paint()..color = Colors.white;
    canvas.drawOval(rect, paint);

    // İç gölge efekti
    final shadowPaint =
        Paint()
          ..color = Color(0xff6F060B)
          ..maskFilter = const MaskFilter.blur(BlurStyle.inner, 10);

    // İçe gölge için ters çizim yapıyoruz
    final path = Path()..addOval(rect);
    canvas.saveLayer(rect, Paint());
    canvas.drawPath(path, shadowPaint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
