import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/widgets/movie_card/movie_card.dart';

class MovieList extends StatelessWidget {
  final String title;
  final List<Movie> movies;
  final Function(Movie)? onMovieTap;
  final VoidCallback? onFavoriteToggle;

  const MovieList({
    super.key,
    required this.title,
    required this.movies,
    this.onMovieTap,
    this.onFavoriteToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: Text(title, style: AppTextStyle.whiteS16Bold),
        ),
        SizedBox(
          height: 280.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(
                movie: movie,
                heroTag: 'movie_list_${title}_movie_poster_${movie.id}',
                onTap: onMovieTap,
                onFavoriteToggle: () => onFavoriteToggle?.call(),
              );
            },
          ),
        ),
      ],
    );
  }
}
