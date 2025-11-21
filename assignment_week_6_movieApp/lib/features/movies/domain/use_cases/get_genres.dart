import 'package:themeandpagination/features/movies/domain/entities/genre.dart';
import 'package:themeandpagination/features/movies/domain/repositories/movie_repository.dart';

class GetGenres {
  final MovieRepository repository;

  GetGenres(this.repository);

  Future<List<Genre>> call() async {
    return await repository.getGenres();
  }
}
