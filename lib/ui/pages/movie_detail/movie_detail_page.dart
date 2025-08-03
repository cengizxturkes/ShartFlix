import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/global_bloc/auth/auth_cubit.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/ui/pages/movie_detail/movie_detail_cubit.dart';
import 'package:my_app/widgets/app_app_bar/app_app_bar.dart';
import 'package:my_app/widgets/buttons/app_buttons.dart';
import 'package:my_app/widgets/image/image_url_secured.dart';
import 'package:my_app/widgets/image/full_screen_image_preview.dart';
import 'package:my_app/widgets/widgets.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieDetailCubit _movieDetailCubit;
  final PageController _imagePageController = PageController();
  int _currentImageIndex = 0;

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
    _imagePageController.dispose();
    super.dispose();
  }

  void _showFullScreenImages() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => _buildFullScreenImageDialog(),
    );
  }

  Widget _buildFullScreenImageDialog() {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.zero,
      child: _FullScreenImageViewer(
        images: widget.movie.images,
        poster: widget.movie.poster,
        initialIndex: _currentImageIndex,
        movieId: widget.movie.id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _movieDetailCubit,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 500.h,
              pinned: true,
              backgroundColor: Colors.transparent,
              leadingWidth: 56.w + 4.w,

              leading: AppBackButton(width: 40.w, height: 40.h),
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
                    _buildImageSection(),
                    IgnorePointer(
                      child: Container(
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
                    ),
                    // Image carousel indicators
                    if (widget.movie.images.isNotEmpty) ...[
                      Positioned(
                        top: 100.h,
                        left: 0,
                        right: 0,
                        child: _buildImageIndicators(),
                      ),
                    ],
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
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppButton(onPressed: () {}, title: 'play'.tr()),
                    SizedBox(height: 24.h),
                    if (widget.movie.plot.isNotEmpty) ...[
                      Text(
                        'summary'.tr(),
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
                    if (widget.movie.genre.isNotEmpty) ...[
                      Text(
                        'genre'.tr(),
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
                    if (widget.movie.director.isNotEmpty) ...[
                      Text(
                        'director'.tr(),
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
                    if (widget.movie.actors.isNotEmpty) ...[
                      Text(
                        'cast'.tr(),
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
                    if (widget.movie.awards.isNotEmpty) ...[
                      Text(
                        'awards'.tr(),
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
                    if (widget.movie.language.isNotEmpty ||
                        widget.movie.country.isNotEmpty) ...[
                      Text(
                        'details'.tr(),
                        style: AppTextStyle.whiteS18Bold.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      if (widget.movie.language.isNotEmpty) ...[
                        _buildDetailRow('language'.tr(), widget.movie.language),
                        SizedBox(height: 4.h),
                      ],
                      if (widget.movie.country.isNotEmpty) ...[
                        _buildDetailRow('country'.tr(), widget.movie.country),
                        SizedBox(height: 4.h),
                      ],
                      if (widget.movie.released.isNotEmpty) ...[
                        _buildDetailRow(
                          'releaseDate'.tr(),
                          widget.movie.released,
                        ),
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

  Widget _buildImageSection() {
    if (widget.movie.images.isNotEmpty) {
      // Create a list with poster first, then images
      final allImages = [widget.movie.poster, ...widget.movie.images];

      return GestureDetector(
        onTap: _showFullScreenImages,
        child: PageView.builder(
          controller: _imagePageController,
          onPageChanged: (index) {
            setState(() {
              _currentImageIndex = index;
            });
          },
          itemCount: allImages.length,
          itemBuilder: (context, index) {
            final isPoster = index == 0;
            return Hero(
              tag:
                  isPoster
                      ? 'movie_detail_poster_${widget.movie.id}'
                      : 'movie_detail_image_${widget.movie.id}_${index - 1}',
              child: ImageUrlSecured(
                imageUrl: allImages[index],
                fit: BoxFit.cover,
              ),
            );
          },
        ),
      );
    } else {
      return Hero(
        tag: 'movie_detail_poster_${widget.movie.id}',
        child: ImageUrlSecured(
          imageUrl: widget.movie.poster,
          fit: BoxFit.cover,
        ),
      );
    }
  }

  Widget _buildImageIndicators() {
    final totalImages =
        widget.movie.images.isNotEmpty
            ? widget.movie.images.length +
                1 // poster + images
            : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalImages, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: _currentImageIndex == index ? 24.w : 8.w,
          decoration: BoxDecoration(
            color:
                _currentImageIndex == index
                    ? AppColors.buttonColor
                    : Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
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

class _FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final String poster;
  final int initialIndex;
  final String movieId;

  const _FullScreenImageViewer({
    required this.images,
    required this.poster,
    required this.initialIndex,
    required this.movieId,
  });

  @override
  State<_FullScreenImageViewer> createState() => _FullScreenImageViewerState();
}

class _FullScreenImageViewerState extends State<_FullScreenImageViewer> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background
        Positioned.fill(
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(color: Colors.black.withValues(alpha: 0.9)),
          ),
        ),
        // Image carousel or single image
        Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 1.sw,
              height: 1.sh,
              child: _buildImageContent(),
            ),
          ),
        ),
        // Close button
        Positioned(
          top: MediaQuery.of(context).padding.top + 10,
          right: 16,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.close, color: Colors.white, size: 30),
          ),
        ),
        // Image indicators (if multiple images)
        if (widget.images.isNotEmpty)
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 20,
            left: 0,
            right: 0,
            child: _buildImageIndicators(),
          ),
      ],
    );
  }

  Widget _buildImageContent() {
    if (widget.images.isNotEmpty) {
      // Create a list with poster first, then images
      final allImages = [widget.poster, ...widget.images];

      return PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemCount: allImages.length,
        itemBuilder: (context, index) {
          final isPoster = index == 0;
          return Hero(
            tag:
                isPoster
                    ? 'fullscreen_movie_poster_${widget.movieId}'
                    : 'fullscreen_movie_image_${widget.movieId}_${index - 1}',
            child: ImageUrlSecured(
              imageUrl: allImages[index],
              fit: BoxFit.contain,
            ),
          );
        },
      );
    } else {
      return Hero(
        tag: 'fullscreen_movie_poster_${widget.movieId}',
        child: ImageUrlSecured(imageUrl: widget.poster, fit: BoxFit.contain),
      );
    }
  }

  Widget _buildImageIndicators() {
    final totalImages =
        widget.images.isNotEmpty
            ? widget.images.length +
                1 // poster + images
            : 0;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalImages, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          height: 8.h,
          width: _currentIndex == index ? 24.w : 8.w,
          decoration: BoxDecoration(
            color:
                _currentIndex == index
                    ? AppColors.buttonColor
                    : Colors.white.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(4.r),
          ),
        );
      }),
    );
  }
}
