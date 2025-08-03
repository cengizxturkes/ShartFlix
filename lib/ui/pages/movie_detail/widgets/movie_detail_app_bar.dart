import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/card/app_decoartion.dart';
import 'package:my_app/ui/pages/movie_detail/movie_detail_cubit.dart';
import 'package:my_app/widgets/app_app_bar/app_app_bar.dart';

class MovieDetailAppBar extends StatelessWidget {
  final String movieId;
  final VoidCallback onFavoritePressed;

  const MovieDetailAppBar({
    super.key,
    required this.movieId,
    required this.onFavoritePressed,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 500.h,
      pinned: true,
      backgroundColor: Colors.transparent,
      leadingWidth: 56.w + 4.w,
      leading: AppBackButton(width: 40.w, height: 40.h),
      actions: [
        IconButton(
          onPressed: onFavoritePressed,
          icon: Container(
            padding: EdgeInsets.all(8.w),
            decoration: context.favoriteButtonDecoration,
            child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
              builder: (context, state) {
                return Icon(
                  state.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color:
                      state.isFavorite ? AppColors.buttonColor : Colors.white,
                  size: 20,
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
