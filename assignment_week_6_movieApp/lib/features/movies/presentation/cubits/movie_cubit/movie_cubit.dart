import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themeandpagination/features/movies/domain/use_cases/get_popular_movies.dart';

import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetPopularMovies getPopularMovies;

  int page = 1;

  MovieCubit(this.getPopularMovies) : super(MovieInitial());

  void fetchMovies() async {
    
    try {
      final movies = await getPopularMovies(page: page);
      if (state is MovieLoaded) {
        final currentMovies = (state as MovieLoaded).movies;
        emit(MovieLoaded([...currentMovies, ...movies]));
      } else {
        emit(MovieLoaded(movies));
      }
      page++;
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }
}
