import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/common/app_images/app_svg.dart';
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
  final PageController _pageController = PageController();
  int _currentIndex = 0;

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
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _discoverCubit,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            'Filmleri Keşfet',
            style: AppTextStyle.whiteS18SemiBold.copyWith(color: Colors.white),
          ),
          leading: IconButton(
            onPressed: () {
              context.pushNamed(AppRouter.home);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: BlocBuilder<DiscoverCubit, DiscoverState>(
          builder: (context, state) {
            if (state.fetchMovieStatus == LoadStatus.loading &&
                state.movies == null) {
              return const Center(child: AppCircularProgressIndicator());
            }

            if (state.fetchMovieStatus == LoadStatus.failure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.white,
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      'Filmler yüklenirken hata oluştu',
                      style: AppTextStyle.whiteS16.copyWith(
                        color: Colors.white,
                      ),
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

            final movies = state.movies?.data.movies ?? [];

            if (movies.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.movie, size: 64, color: Colors.white),
                    SizedBox(height: 16.h),
                    Text(
                      'Keşfetmenin sonuna geldin!',
                      style: AppTextStyle.whiteS18Bold.copyWith(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Tüm filmleri favoriledin',
                      style: AppTextStyle.whiteS14.copyWith(
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: movies.length,
                        onPageChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });

                          // Load more movies if we're near the end
                          if (index >= movies.length - 3 && state.hasMoreData) {
                            _discoverCubit.loadMoreMovies();
                          }
                        },
                        itemBuilder: (context, index) {
                          final movie = movies[index];
                          return _buildMovieCard(movie, index);
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
          },
        ),
      ),
    );
  }

  Widget _buildMovieCard(Movie movie, int index) {
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
            Positioned.fill(
              child: ImageUrlSecured(
                imageUrl: movie.poster,
                fit: BoxFit.contain,
              ),
            ),
            Positioned.fill(
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
            ),
            Positioned(
              bottom: 20,
              left: 20.w,
              right: 0,
              child: Row(
                children: [
                  AppSvgWidget(
                    path: AppSvg.discover,
                    width: 40.w,
                    height: 40.w,
                    fit: BoxFit.contain,
                  ),
                  Expanded(
                    // <-- önemli
                    child: Container(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            style: AppTextStyle.whiteS18SemiBold.copyWith(
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          _buildExpandableText(movie.plot),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 50.h,
              right: 20.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  '${index + 1}/${_discoverCubit.state.movies?.data.movies.length ?? 0}',
                  style: AppTextStyle.whiteS12.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpandableText(String text) {
    return ExpandableText(text: text);
  }

  Widget _buildActionButtons(List<Movie> movies) {
    if (movies.isEmpty) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        GestureDetector(
          onTap: () {
            if (_currentIndex < movies.length) {
              final movie = movies[_currentIndex];
              _discoverCubit.likeMovie(movie.id);
              if (_currentIndex < movies.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            }
          },
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
