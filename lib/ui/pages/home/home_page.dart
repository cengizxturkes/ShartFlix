// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_app/common/app_colors/app_colors.dart';
import 'package:my_app/common/app_navbar/app_navigation_bar.dart';
import 'package:my_app/repositories/auth/auth_repository.dart';
import 'package:my_app/repositories/movie/movie_repository.dart';
import 'package:my_app/ui/pages/home/home_cubit.dart';
import 'package:my_app/ui/pages/home/home_navigator.dart';
import 'package:my_app/ui/pages/home/home_state.dart';
import 'package:my_app/ui/pages/home/widget/widgets.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_cubit.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_navigator.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_page.dart';
import 'package:my_app/ui/pages/profile_pages/profile/profile_state.dart';
import 'package:my_app/router/route_config.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(
          create: (con) {
            final authRepo = RepositoryProvider.of<AuthRepository>(context);
            final movieRepo = RepositoryProvider.of<MovieRepository>(context);
            return HomeCubit(
              navigator: HomeNavigator(context: context),
              authRepo: authRepo,
              movieRepo: movieRepo,
            );
          },
        ),
        BlocProvider<ProfileCubit>(
          create: (con) {
            final authRepo = RepositoryProvider.of<AuthRepository>(context);
            final movieRepo = RepositoryProvider.of<MovieRepository>(context);
            return ProfileCubit(
              navigator: ProfileNavigator(context: context),
              authRepo: authRepo,
              movieRepo: movieRepo,
            );
          },
        ),
      ],
      child: const HomeChildPage(),
    );
  }
}

class HomeChildPage extends StatefulWidget {
  const HomeChildPage({super.key});

  @override
  State<HomeChildPage> createState() => _HomeChildPageState();
}

class _HomeChildPageState extends State<HomeChildPage> {
  late HomeCubit _cubit;
  late ProfileCubit _profileCubit;
  @override
  void initState() {
    super.initState();
    _cubit = BlocProvider.of<HomeCubit>(context);
    _profileCubit = BlocProvider.of<ProfileCubit>(context);
    Future.delayed(Duration.zero, () {
      _profileCubit.getUser();
      _cubit.fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        return BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, profileState) {
            return WillPopScope(
              onWillPop: () async => true,
              child: Scaffold(
                backgroundColor: AppColors.background,
                extendBody: true,
                bottomNavigationBar: CustomBottomNavigationBar(
                  currentIndex: homeState.currentNavigationIndex,
                  onTap: (int value) => _cubit.onNavigationChanged(value),
                ),
                body:
                    homeState.currentNavigationIndex == 0
                        ? SafeArea(
                          child: SingleChildScrollView(
                            child: SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: Column(
                                children: [
                                  HomeHeader(cubit: _cubit),
                                  Expanded(
                                    child: MovieListWidget(
                                      moviesResponse:
                                          homeState.filteredMovies ??
                                          homeState.movies,
                                      onMovieTap: (movie) {
                                        context.pushNamed(
                                          AppRouter.movieDetail,
                                          extra: movie,
                                        );
                                      },
                                      onFavoriteToggle: (String movieId) {
                                        _cubit.setMovieFavorite(movieId);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        : ProfilePage(),
              ),
            );
          },
        );
      },
    );
  }
}
