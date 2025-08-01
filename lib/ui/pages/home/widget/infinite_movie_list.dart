import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/ui/pages/home/home_cubit.dart';
import 'package:my_app/ui/pages/home/home_state.dart';
import 'package:my_app/ui/pages/home/widget/featured_movie.dart';
import 'package:my_app/ui/pages/home/image_url_encoded.dart';
import 'package:my_app/widgets/movie_card/movie_card.dart';
import 'dart:math';

class MovieListWidget extends StatefulWidget {
  final ListMoviesResponse? moviesResponse;
  final VoidCallback? onMovieTap;
  final Function(String)? onFavoriteToggle;

  const MovieListWidget({
    super.key,
    this.moviesResponse,
    this.onMovieTap,
    this.onFavoriteToggle,
  });

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final ScrollController _scrollController = ScrollController();
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      final cubit = context.read<HomeCubit>();
      cubit.loadMoreMovies();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.fetchMovieStatus == LoadStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.white),
          );
        }

        if (state.fetchMovieStatus == LoadStatus.failure) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  color: AppColors.white,
                  size: 48,
                ),
                SizedBox(height: 16.h),
                const Text(
                  'Bir hata oluştu',
                  style: TextStyle(color: AppColors.white),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeCubit>().fetchMovies();
                  },
                  child: const Text('Tekrar Dene'),
                ),
              ],
            ),
          );
        }

        if (state.movies?.data.movies == null ||
            state.movies!.data.movies.isEmpty) {
          return const Center(
            child: Text(
              'Film bulunamadı',
              style: TextStyle(color: AppColors.white),
            ),
          );
        }

        final movies = state.movies!.data.movies;

        return RefreshIndicator(
          onRefresh: () async {
            context.read<HomeCubit>().refreshMovies();
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: FeaturedMovie(
                  movie: movies.first,
                  onTap: widget.onMovieTap,
                ),
              ),
              SliverToBoxAdapter(child: _buildTopMoviesSection(movies)),
              ..._buildGenreCategories(movies),
              SliverToBoxAdapter(
                child: Container(
                  color: AppColors.background,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Tüm Filmler', style: AppTextStyle.whiteS20Bold),
                    ],
                  ),
                ),
              ),

              // All Movies Grid
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 16.h,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final movie = movies[index];
                    return MovieCard(
                      movie: movie,
                      onTap: widget.onMovieTap,
                      onFavoriteToggle: () {
                        if (widget.onFavoriteToggle != null) {
                          widget.onFavoriteToggle!(movie.id);
                        }
                      },
                    );
                  }, childCount: movies.length),
                ),
              ),
              if (state.loadMoreStatus == LoadStatus.loading)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: const Center(
                      child: CircularProgressIndicator(color: AppColors.white),
                    ),
                  ),
                ),
              if (!state.hasMoreData && movies.isNotEmpty)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    child: Center(
                      child: Text(
                        'Tüm filmler yüklendi',
                        style: AppTextStyle.whiteS14.copyWith(
                          color: AppColors.white.withValues(alpha: 0.7),
                        ),
                      ),
                    ),
                  ),
                ),

              // Bottom padding for navigation bar
              SliverToBoxAdapter(child: SizedBox(height: 80.h)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTopMoviesSection(List<Movie> movies) {
    // Get random 10 movies from API data
    final randomMovies = List<Movie>.from(movies);
    randomMovies.shuffle(_random);
    final topMovies = randomMovies.take(10).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Text(
            'Öne Çıkan Filmler',
            style: AppTextStyle.whiteS20Bold.copyWith(fontSize: 24.sp),
          ),
        ),
        SizedBox(
          height: 250.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: topMovies.length,
            itemBuilder: (context, index) {
              final movie = topMovies[index];
              return Container(
                margin: EdgeInsets.only(right: 12.w),
                child: MovieCard(
                  movie: movie,
                  width: 150.w,
                  height: 250.h,
                  onTap: widget.onMovieTap,
                  onFavoriteToggle: () {
                    if (widget.onFavoriteToggle != null) {
                      widget.onFavoriteToggle!(movie.id);
                    }
                  },
                ),
              );
            },
          ),
        ),
        SizedBox(height: 24.h),
      ],
    );
  }

  List<Widget> _buildGenreCategories(List<Movie> movies) {
    final genres = <String, List<Movie>>{};

    // Group movies by genre
    for (final movie in movies) {
      final genreList = movie.genre.split(',').map((g) => g.trim()).toList();
      for (final genre in genreList) {
        if (genre.isNotEmpty) {
          genres.putIfAbsent(genre, () => []).add(movie);
        }
      }
    }

    // Get top 5 genres with most movies
    final sortedGenres =
        genres.entries.toList()
          ..sort((a, b) => b.value.length.compareTo(a.value.length));

    return sortedGenres.take(5).map((entry) {
      final genre = entry.key;
      final genreMovies =
          entry.value.take(10).toList(); // Show max 10 movies per genre

      return SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Text(genre, style: AppTextStyle.whiteS20Bold),
            ),
            SizedBox(
              height: 300.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                itemCount: genreMovies.length,
                itemBuilder: (context, index) {
                  final movie = genreMovies[index];
                  return Container(
                    margin: EdgeInsets.only(right: 12.w),
                    child: MovieCard(
                      movie: movie,
                      width: 150.w,
                      height: 250.h,
                      onTap: widget.onMovieTap,
                      onFavoriteToggle: () {
                        if (widget.onFavoriteToggle != null) {
                          widget.onFavoriteToggle!(movie.id);
                        }
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
