import 'package:themeandpagination/features/home/data/data_source/movie_remote_data_source.dart';

import '../../domain/entities/movie.dart';
import '../../domain/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  Future< List<Movie>> getPopularMovies({required int page}) async {
    return await remoteDataSource.getPopularMovies(page: page);
  }
}
