import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/common/app_images/app_svg.dart';
import 'package:my_app/common/app_navbar/app_navigation_bar.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/global_bloc/auth/auth_cubit.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/router/route_config.dart';
import 'package:my_app/ui/pages/discover/discover_cubit.dart';
import 'package:my_app/widgets/icon/app_svg_widget.dart';
import 'package:my_app/widgets/loading/app_loading_indicator.dart';
import 'package:my_app/widgets/image/image_url_secured.dart';
import 'package:my_app/widgets/widgets.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({super.key});

  @override
  State<DiscoverPage> createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  late DiscoverCubit _discoverCubit;
  final PageController _verticalPageController = PageController();
  int _currentMovieIndex = 0;

  @override
  void initState() {
    super.initState();
    _discoverCubit = DiscoverCubit(
      movieRepo: context.read<MovieRepository>(),
      authCubit: context.read<AuthCubit>(),
    );
    _discoverCubit.fetchMovies();
  }

  @override
  void dispose() {
    _discoverCubit.close();
    _verticalPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _discoverCubit,
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 3,
          onTap: (int value) {
            context.pop();
          },
        ),
        body: BlocBuilder<DiscoverCubit, DiscoverState>(
          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(DiscoverState state) {
    if (state.fetchMovieStatus == LoadStatus.loading && state.movies == null) {
      return const Center(child: AppCircularProgressIndicator());
    }

    if (state.fetchMovieStatus == LoadStatus.failure) {
      return _buildErrorWidget();
    }

    final movies = state.movies?.data.movies ?? [];

    if (movies.isEmpty) {
      return _buildEmptyStateWidget();
    }

    return _buildMovieStack(movies, state);
  }

  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.white),
          SizedBox(height: 16.h),
          Text(
            'Filmler yüklenirken hata oluştu',
            style: AppTextStyle.whiteS16.copyWith(color: Colors.white),
          ),
          SizedBox(height: 16.h),
          ElevatedButton(
            onPressed: () => _discoverCubit.fetchMovies(),
            child: const Text('Tekrar Dene'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.movie, size: 64, color: Colors.white),
          SizedBox(height: 16.h),
          Text(
            'Keşfetmenin sonuna geldin!',
            style: AppTextStyle.whiteS18Bold.copyWith(color: Colors.white),
          ),
          SizedBox(height: 8.h),
          Text(
            'Tüm filmleri favoriledin',
            style: AppTextStyle.whiteS14.copyWith(color: Colors.white70),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieStack(List<Movie> movies, DiscoverState state) {
    return Stack(
      children: [
        Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _verticalPageController,
                scrollDirection: Axis.vertical,
                itemCount: movies.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentMovieIndex = index;
                  });

                  // Load more movies if we're near the end
                  if (index >= movies.length - 3 && state.hasMoreData) {
                    _discoverCubit.loadMoreMovies();
                  }
                },
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return MovieCardWidget(
                    movie: movie,
                    movieIndex: index,
                    totalMovies: movies.length,
                    onLike: () => _handleLikeMovie(movies),
                  );
                },
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
        Positioned(
          bottom: 150.h,
          right: 16.w,
          child: _buildActionButtons(movies),
        ),
      ],
    );
  }

  void _handleLikeMovie(List<Movie> movies) {
    if (_currentMovieIndex < movies.length) {
      final movie = movies[_currentMovieIndex];
      _discoverCubit.likeMovie(movie.id);
      if (_currentMovieIndex < movies.length - 1) {
        _verticalPageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    }
  }

  Widget _buildActionButtons(List<Movie> movies) {
    if (movies.isEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () => _handleLikeMovie(movies),
          child: Container(
            width: 49.18.w,
            height: 71.7.h,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1,
              ),
              borderRadius: BorderRadius.circular(82.r),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(82.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7.5, sigmaY: 7.5),
                child: Center(
                  child: AppSvgWidget(
                    path: AppSvg.like,
                    width: 24.w,
                    height: 24.w,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MovieCardWidget extends StatefulWidget {
  final Movie movie;
  final int movieIndex;
  final int totalMovies;
  final VoidCallback onLike;

  const MovieCardWidget({
    super.key,
    required this.movie,
    required this.movieIndex,
    required this.totalMovies,
    required this.onLike,
  });

  @override
  State<MovieCardWidget> createState() => _MovieCardWidgetState();
}

class _MovieCardWidgetState extends State<MovieCardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: Stack(
          children: [
            Positioned.fill(child: _buildImageCarousel()),
            _buildGradientOverlay(),
            _buildMovieInfo(),
            _buildMovieCounter(),
            _buildImageIndicator(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCarousel() {
    return ImageUrlSecured(imageUrl: widget.movie.poster, fit: BoxFit.cover);
  }

  Widget _buildGradientOverlay() {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withValues(alpha: 0.3),
              Colors.black.withValues(alpha: 0.7),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMovieInfo() {
    return Positioned(
      bottom: 0,
      left: 20.w,
      right: 0,
      child: GestureDetector(
        onTap: () {
          context.pushNamed(AppRouter.movieDetail, extra: widget.movie);
        },
        child: Row(
          children: [
            AppSvgWidget(
              path: AppSvg.discover,
              width: 40.w,
              height: 40.w,
              fit: BoxFit.contain,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: AppTextStyle.whiteS18SemiBold.copyWith(
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    ExpandableText(text: widget.movie.plot),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMovieCounter() {
    return Positioned(
      top: 50.h,
      right: 20.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          '${widget.movieIndex + 1}/${widget.totalMovies}',
          style: AppTextStyle.whiteS12.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildImageIndicator() {
    // Sadece poster gösterildiği için indicator'a gerek yok
    return const SizedBox.shrink();
  }
}
