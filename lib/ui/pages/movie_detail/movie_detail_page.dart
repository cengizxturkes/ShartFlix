import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/global_bloc/auth/auth_cubit.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/ui/pages/movie_detail/movie_detail_cubit.dart';
import 'package:my_app/widgets/image/image_url_secured.dart';
import 'package:my_app/widgets/widgets.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieDetailCubit _movieDetailCubit;

  @override
  void initState() {
    super.initState();
    _movieDetailCubit = MovieDetailCubit(
      movieRepo: context.read<MovieRepository>(),
      authCubit: context.read<AuthCubit>(),
    );
  }

  @override
  void dispose() {
    _movieDetailCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _movieDetailCubit,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: CustomScrollView(
          slivers: [
            // Hero App Bar with Poster
            SliverAppBar(
              expandedHeight: 500.h,
              pinned: true,
              backgroundColor: Colors.transparent,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.5),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              actions: [
                IconButton(
                  onPressed: () {
                    _movieDetailCubit.toggleFavorite(widget.movie.id);
                  },
                  icon: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.5),
                      shape: BoxShape.circle,
                    ),
                    child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
                      builder: (context, state) {
                        return Icon(
                          state.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color:
                              state.isFavorite
                                  ? AppColors.buttonColor
                                  : Colors.white,
                          size: 20,
                        );
                      },
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Hero Poster
                    Hero(
                      tag: 'movie_detail_poster_${widget.movie.id}',
                      child: ImageUrlSecured(
                        imageUrl: widget.movie.poster,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // Gradient Overlay
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.3),
                            Colors.black.withValues(alpha: 0.8),
                          ],
                        ),
                      ),
                    ),
                    // Movie Info Overlay
                    Positioned(
                      bottom: 20.h,
                      left: 20.w,
                      right: 20.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.movie.title,
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
                              if (widget.movie.imdbRating.isNotEmpty) ...[
                                Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  widget.movie.imdbRating,
                                  style: AppTextStyle.whiteS14.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(width: 16.w),
                              ],
                              Text(
                                widget.movie.year,
                                style: AppTextStyle.whiteS14.copyWith(
                                  color: Colors.white70,
                                ),
                              ),
                              if (widget.movie.runtime.isNotEmpty) ...[
                                SizedBox(width: 16.w),
                                Text(
                                  widget.movie.runtime,
                                  style: AppTextStyle.whiteS14.copyWith(
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Movie Details Content
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Action Buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Play functionality
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.buttonColor,
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            icon: const Icon(Icons.play_arrow),
                            label: Text(
                              'Oynat',
                              style: AppTextStyle.whiteS16.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Container(
                          padding: EdgeInsets.all(12.w),
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: const Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),

                    // Plot
                    if (widget.movie.plot.isNotEmpty) ...[
                      Text(
                        'Özet',
                        style: AppTextStyle.whiteS18Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      ExpandableText(
                        text: widget.movie.plot,
                        maxCharacters: 100,
                        textStyle: AppTextStyle.whiteS14.copyWith(
                          color: Colors.white70,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],

                    // Genre
                    if (widget.movie.genre.isNotEmpty) ...[
                      Text(
                        'Tür',
                        style: AppTextStyle.whiteS18Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children:
                            widget.movie.genre
                                .split(',')
                                .map(
                                  (genre) => Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 12.w,
                                      vertical: 6.h,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey.withValues(alpha: 0.2),
                                      borderRadius: BorderRadius.circular(20.r),
                                    ),
                                    child: Text(
                                      genre.trim(),
                                      style: AppTextStyle.whiteS12.copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                      ),
                      SizedBox(height: 24.h),
                    ],

                    // Director
                    if (widget.movie.director.isNotEmpty) ...[
                      Text(
                        'Yönetmen',
                        style: AppTextStyle.whiteS18Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.movie.director,
                        style: AppTextStyle.whiteS14.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],

                    // Actors
                    if (widget.movie.actors.isNotEmpty) ...[
                      Text(
                        'Oyuncular',
                        style: AppTextStyle.whiteS18Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.movie.actors,
                        style: AppTextStyle.whiteS14.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],

                    // Awards
                    if (widget.movie.awards.isNotEmpty) ...[
                      Text(
                        'Ödüller',
                        style: AppTextStyle.whiteS18Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        widget.movie.awards,
                        style: AppTextStyle.whiteS14.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                      SizedBox(height: 24.h),
                    ],

                    // Language & Country
                    if (widget.movie.language.isNotEmpty ||
                        widget.movie.country.isNotEmpty) ...[
                      Text(
                        'Detaylar',
                        style: AppTextStyle.whiteS18Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      if (widget.movie.language.isNotEmpty) ...[
                        _buildDetailRow('Dil', widget.movie.language),
                        SizedBox(height: 4.h),
                      ],
                      if (widget.movie.country.isNotEmpty) ...[
                        _buildDetailRow('Ülke', widget.movie.country),
                        SizedBox(height: 4.h),
                      ],
                      if (widget.movie.released.isNotEmpty) ...[
                        _buildDetailRow('Yayın Tarihi', widget.movie.released),
                      ],
                    ],

                    SizedBox(height: 40.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80.w,
          child: Text(
            label,
            style: AppTextStyle.whiteS12.copyWith(color: Colors.white70),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyle.whiteS12.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
