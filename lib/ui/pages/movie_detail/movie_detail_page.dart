import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/global_bloc/auth/auth_cubit.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/ui/pages/movie_detail/movie_detail_cubit.dart';
import 'package:my_app/ui/pages/movie_detail/widgets/widgets.dart';

class MovieDetailPage extends StatefulWidget {
  final Movie movie;

  const MovieDetailPage({super.key, required this.movie});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late MovieDetailCubit _movieDetailCubit;
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
    super.dispose();
  }

  void _showFullScreenImages() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder:
          (context) => FullScreenImageViewer(
            images: widget.movie.images,
            poster: widget.movie.poster,
            initialIndex: _currentImageIndex,
            movieId: widget.movie.id,
          ),
    );
  }

  void _onImagePageChanged(int index) {
    setState(() {
      _currentImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _movieDetailCubit,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            MovieDetailAppBar(
              movieId: widget.movie.id,
              onFavoritePressed: () {
                _movieDetailCubit.toggleFavorite(widget.movie.id);
              },
            ),
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  MovieImageSection(
                    movie: widget.movie,
                    onImageTap: _showFullScreenImages,
                    currentImageIndex: _currentImageIndex,
                    onPageChanged: _onImagePageChanged,
                  ),
                  MovieInfoOverlay(movie: widget.movie),
                ],
              ),
            ),
            SliverToBoxAdapter(child: MovieContentSection(movie: widget.movie)),
          ],
        ),
      ),
    );
  }
}
