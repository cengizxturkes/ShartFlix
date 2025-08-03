import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:my_app/common/app_text/app_text_style.dart';
import 'package:my_app/models/enums/load_status.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/router/route_config.dart';
import 'package:my_app/ui/pages/profile_pages/profile_detail/profile_detail_cubit.dart';
import 'package:my_app/global_bloc/setting/app_setting_cubit.dart';
import 'package:my_app/ui/pages/profile_pages/profile_detail/profile_detail_navigator.dart';
import 'package:my_app/ui/pages/profile_pages/profile_detail/profile_detail_state.dart';
import 'package:my_app/ui/pages/profile_pages/profile_detail/widget/get_pro_widget.dart';
import 'package:my_app/ui/pages/profile_pages/profile_detail/widget/profile_detail_header_widget.dart';
import 'package:my_app/widgets/app_app_bar/app_app_bar.dart';
import 'package:my_app/widgets/movie_card/movie_card.dart';
import 'package:my_app/models/response/movies/favorites/favorite_movies.dart';
import 'package:my_app/models/response/movies/list/list_movies_response.dart';

class ProfileDetailPage extends StatelessWidget {
  const ProfileDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (con) {
        final authRepo = RepositoryProvider.of<AuthRepository>(context);
        final movieRepo = RepositoryProvider.of<MovieRepository>(context);
        return ProfileDetailCubit(
          navigator: ProfileDetailNavigator(context: context),
          authRepo: authRepo,
          movieRepo: movieRepo,
        );
      },
      child: const ProfileDetailChildPage(),
    );
  }
}

class ProfileDetailChildPage extends StatefulWidget {
  const ProfileDetailChildPage({super.key});

  @override
  State<ProfileDetailChildPage> createState() => _ProfileDetailChildPageState();
}

class _ProfileDetailChildPageState extends State<ProfileDetailChildPage> {
  late ProfileDetailCubit _cubit;

  // Convert FavoriteMoviesData to Movie
  Movie _convertToMovie(FavoriteMoviesData favoriteMovie) {
    return Movie(
      id: favoriteMovie.id,
      title: favoriteMovie.title,
      year: favoriteMovie.year,
      rated: favoriteMovie.rated,
      released: favoriteMovie.released,
      runtime: favoriteMovie.runtime,
      genre: favoriteMovie.genre,
      director: favoriteMovie.director,
      writer: favoriteMovie.writer,
      actors: favoriteMovie.actors,
      plot: favoriteMovie.plot,
      language: favoriteMovie.language,
      country: favoriteMovie.country,
      awards: favoriteMovie.awards,
      poster: favoriteMovie.poster,
      metascore: favoriteMovie.metascore,
      imdbRating: favoriteMovie.imdbRating,
      imdbVotes: favoriteMovie.imdbVotes,
      imdbId: favoriteMovie.imdbId,
      type: favoriteMovie.type,
      response: favoriteMovie.response,
      images: favoriteMovie.images,
      comingSoon: favoriteMovie.comingSoon,
      isFavorite: favoriteMovie.isFavorite,
    );
  }

  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<ProfileDetailCubit>(context);
    _cubit.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppSettingCubit, AppSettingState>(
      builder: (context, appSettingState) {
        return BlocBuilder<ProfileDetailCubit, ProfileDetailState>(
          builder: (context, state) {
            if (state.fetchUserStatus == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            final user = state.profileResponse?.data;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  "profileDetail".tr(),
                  style: AppTextStyle.whiteS15Regular,
                ),
                leadingWidth: 56.w + 4.w,
                leading: AppBackButton(width: 40.w, height: 40.h),
                actions: [
                  Padding(
                    padding: EdgeInsets.only(right: 26.w),
                    child: GetProWidget(
                      onTap: () {
                        _cubit.onPressedGetPro();
                      },
                    ),
                  ),
                ],
                centerTitle: true,
              ),
              body: SafeArea(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProfileDetailHeaderWidget(
                        userName: user?.name ?? '',
                        userId: (user?.id.toString() ?? '0000000').substring(
                          0,
                          6,
                        ),
                        profileImageUrl: user?.photoUrl,
                        onAddPhotoPressed: () async {
                          await _cubit.navigator.navigateToAddPhoto().then((
                            value,
                          ) {
                            _cubit.getUser();
                          });
                        },
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        'myFavoriteMovies'.tr(),
                        style: AppTextStyle.whiteS12Bold.copyWith(
                          fontSize: 13.sp,
                        ),
                      ),

                      SizedBox(height: 24.h),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, // 2 sütun
                          mainAxisSpacing: 12.h, // satırlar arası boşluk
                          crossAxisSpacing: 12.w, // sütunlar arası boşluk
                          childAspectRatio:
                              150.w /
                              250.h, // kartların en-boy oranı (kart genişliği / yüksekliği)
                        ),
                        itemCount: state.favoriteMovies?.data.length ?? 0,
                        itemBuilder: (context, index) {
                          final favoriteMovie =
                              state.favoriteMovies?.data[index];
                          if (favoriteMovie == null)
                            return const SizedBox.shrink();

                          final movie = _convertToMovie(favoriteMovie);
                          return MovieCard(
                            showFavoriteIcon: false,
                            movie: movie,
                            width: 150.w,
                            height: 250.h,
                            heroTag:
                                'profile_favorite_movie_poster_${movie.id}',
                            onTap: (movie) {
                              context.pushNamed(
                                AppRouter.movieDetail,
                                extra: movie,
                              );
                            },
                            onFavoriteToggle: () {},
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
