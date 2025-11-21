import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:themeandpagination/core/app_theme.dart';
import 'package:themeandpagination/core/cubits/theme_cubit.dart';
import 'package:themeandpagination/core/cubits/theme_state.dart';
import 'package:themeandpagination/core/databases/api/dio_consumer.dart';
import 'package:themeandpagination/core/databases/cache/cache_helper.dart';
import 'package:themeandpagination/core/services/hive_service.dart';
import 'package:hive/hive.dart';
import 'package:themeandpagination/features/movies/data/data_source/movie_local_data_source.dart';
import 'package:themeandpagination/features/movies/data/data_source/movie_remote_data_source.dart';
import 'package:themeandpagination/features/movies/data/repos/movie_repository_impl.dart'
    show MovieRepositoryImpl;
import 'package:themeandpagination/features/movies/domain/use_cases/get_genres.dart';
import 'package:themeandpagination/features/movies/domain/use_cases/get_popular_movies.dart';
import 'package:themeandpagination/features/movies/presentation/cubits/movie_cubit/movie_cubit.dart';
import 'package:themeandpagination/features/movies/presentation/views/movie_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await CacheHelper().init();
  HiveService.init();

  final dioConsumer = DioConsumer(dio: Dio());
  final remoteDataSource = MovieRemoteDataSourceImpl(api: dioConsumer);
  final localDataSource = MovieLocalDataSourceImpl(Hive);
  final repository = MovieRepositoryImpl(remoteDataSource, localDataSource);

  final getMovies = GetPopularMovies(repository);
  final getGenres = GetGenres(repository);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit()),
        BlocProvider(create: (_) => MovieCubit(getMovies, getGenres)..fetchMovies()),
      ],
      child: MyApp(getMovies: getMovies),
    ),
  );
}

class MyApp extends StatelessWidget {
  final GetPopularMovies getMovies;
  const MyApp({super.key, required this.getMovies});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Movies App',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: state.themeMode,
          home: const MovieListScreen(),
        );
      },
    );
  }
}
