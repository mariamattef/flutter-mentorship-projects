import 'package:hive/hive.dart';
import 'package:themeandpagination/features/movies/data/models/genre_model.dart';
import 'package:themeandpagination/features/movies/data/models/movie_model.dart';

abstract class MovieLocalDataSource {
  Future<void> cacheMovies(List<MovieModel> movies);
  Future<List<MovieModel>> getCachedMovies();
  Future<void> cacheGenres(List<GenreModel> genres);
  Future<List<GenreModel>> getCachedGenres();
}

class MovieLocalDataSourceImpl implements MovieLocalDataSource {
  final HiveInterface hive;

  MovieLocalDataSourceImpl(this.hive);

  @override
  Future<void> cacheMovies(List<MovieModel> movies) async {
    final box = await hive.openBox<MovieModel>('movies');
    await box.addAll(movies);
  }

  @override
  Future<List<MovieModel>> getCachedMovies() async {
    final box = await hive.openBox<MovieModel>('movies');
    return box.values.toList();
  }

  @override
  Future<void> cacheGenres(List<GenreModel> genres) async {
    final box = await hive.openBox<GenreModel>('genres');
    await box.addAll(genres);
  }

  @override
  Future<List<GenreModel>> getCachedGenres() async {
    final box = await hive.openBox<GenreModel>('genres');
    return box.values.toList();
  }
}
