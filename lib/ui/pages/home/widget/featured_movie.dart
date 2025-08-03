import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_dimens/app_dimens.dart';
import 'package:my_app/common/app_shadow/app_shadows.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/router/route_config.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';
import 'package:my_app/widgets/image/image_url_secured.dart';

class FeaturedMovie extends StatelessWidget {
  final Movie movie;
  final Function(Movie)? onTap;

  const FeaturedMovie({super.key, required this.movie, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(movie),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: AppDimens.featuredMovieBottomPadding.h,
        ),
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: AppDimens.paddingNormal),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: AppShadow.homePageFeaturedMovieShadow,
          ),
          child: Stack(
            children: [
              if (movie.poster.isNotEmpty)
                ImageUrlSecured(
                  imageUrl: movie.poster,
                  height: AppDimens.homePageFeaturedMovieHeight.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                )
              else
                Container(
                  height: AppDimens.homePageFeaturedMovieHeight.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: Colors.red,
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Icon(Icons.movie, size: 40.sp, color: AppColors.white),
                ),
              Positioned(
                bottom: 16.h,
                right: 0.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: SizedBox(
                    width: 150.w,
                    child: AppButton(
                      onPressed: () {
                        context.pushNamed(AppRouter.discover);
                      },
                      title: "Filmleri Keşfet",
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: AppDimens.featuredMovieBottomPositioned.h,
                left: AppDimens.featuredMovieLeftPositioned.w,
                right: AppDimens.featuredMovieRightPositioned.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      movie.title,
                      style: AppTextStyle.whiteS24Bold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        Text(
                          movie.year,
                          style: AppTextStyle.whiteS14.copyWith(
                            color: AppColors.gray1,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        if (movie.imdbRating.isNotEmpty) ...[
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: Text(
                              '★ ${movie.imdbRating}',
                              style: AppTextStyle.whiteS12.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(width: 16.w),
                        ],
                        if (movie.genre.isNotEmpty)
                          Expanded(
                            child: Text(
                              movie.genre.split(',').first.trim(),
                              style: AppTextStyle.whiteS14.copyWith(
                                color: AppColors.gray1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
