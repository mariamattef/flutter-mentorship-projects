import 'package:themeandpagination/features/movies/domain/entities/genre.dart';

import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getPopularMovies({required int page});
  Future<List<Genre>> getGenres();
}
