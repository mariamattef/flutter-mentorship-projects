import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:themeandpagination/core/app_theme.dart';
import 'package:themeandpagination/core/cubits/theme_cubit.dart';
import 'package:themeandpagination/core/cubits/theme_state.dart';
import 'package:themeandpagination/core/databases/api/dio_consumer.dart';
import 'package:themeandpagination/core/databases/cache/cache_helper.dart';
import 'package:themeandpagination/features/home/data/data_source/movie_remote_data_source.dart';
import 'package:themeandpagination/features/home/data/repos/movie_repository_impl.dart'
    show MovieRepositoryImpl;
import 'package:themeandpagination/features/home/domain/use_cases/get_popular_movies.dart';
import 'package:themeandpagination/features/home/presentation/cubits/movie_cubit/movie_cubit.dart';
import 'package:themeandpagination/features/home/presentation/views/movie_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await CacheHelper().init();
  final repository = MovieRepositoryImpl(
    MovieRemoteDataSourceImpl(api: DioConsumer(dio: Dio())),
  );
  final getMovies = GetPopularMovies(repository);

  runApp(
    BlocProvider(
      create: (context) => ThemeCubit(),
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
          home: BlocProvider(
            create: (_) => MovieCubit(getMovies)..fetchMovies(),
            child: const MovieListScreen(),
          ),
        );
      },
    );
  }
}
