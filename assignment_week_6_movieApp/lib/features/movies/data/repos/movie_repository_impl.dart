import 'package:themeandpagination/features/movies/data/data_source/movie_local_data_source.dart';
import 'package:themeandpagination/features/movies/data/data_source/movie_remote_data_source.dart';
import 'package:themeandpagination/features/movies/domain/entities/genre.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;
  final MovieLocalDataSource localDataSource;

  MovieRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<List<Movie>> getPopularMovies({required int page}) async {
    try {
      final movies = await remoteDataSource.getPopularMovies(page: page);
      await localDataSource.cacheMovies(movies);
      return movies;
    } catch (e) {
      return await localDataSource.getCachedMovies();
    }
  }

  @override
  Future<List<Genre>> getGenres() async {
    try {
      final genres = await remoteDataSource.getGenres();
      await localDataSource.cacheGenres(genres);
      return genres;
    } catch (e) {
      return await localDataSource.getCachedGenres();
    }
  }
}
