import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';

class MovieInfoOverlay extends StatelessWidget {
  final Movie movie;

  const MovieInfoOverlay({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20.h,
      left: 20.w,
      right: 20.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            movie.title,
            style: AppTextStyle.whiteS24Bold.copyWith(
              color: Colors.white,
              fontSize: 28.sp,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              if (movie.imdbRating.isNotEmpty) ...[
                Icon(Icons.star, color: Colors.amber, size: 16.sp),
                SizedBox(width: 4.w),
                Text(
                  movie.imdbRating,
                  style: AppTextStyle.whiteS14.copyWith(color: Colors.white),
                ),
                SizedBox(width: 16.w),
              ],
              Text(
                movie.year,
                style: AppTextStyle.whiteS14.copyWith(color: Colors.white70),
              ),
              if (movie.runtime.isNotEmpty) ...[
                SizedBox(width: 16.w),
                Text(
                  movie.runtime,
                  style: AppTextStyle.whiteS14.copyWith(color: Colors.white70),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
