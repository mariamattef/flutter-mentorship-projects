import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themeandpagination/features/movies/domain/use_cases/get_genres.dart';
import 'package:themeandpagination/features/movies/domain/use_cases/get_popular_movies.dart';

import 'movie_state.dart';

class MovieCubit extends Cubit<MovieState> {
  final GetPopularMovies getPopularMovies;
  final GetGenres getGenres;

  int page = 1;

  MovieCubit(this.getPopularMovies, this.getGenres) : super(MovieInitial());

  void fetchMovies() async {
    try {
      if (state is MovieLoaded) {
        final currentMovies = (state as MovieLoaded).movies;
        final genres = (state as MovieLoaded).genres;
        final movies = await getPopularMovies(page: page);
        emit(MovieLoaded([...currentMovies, ...movies], genres));
      } else {
        final movies = await getPopularMovies(page: page);
        final genres = await getGenres();
        emit(MovieLoaded(movies, genres));
      }
      page++;
    } catch (e) {
      emit(MovieError(e.toString()));
    }
  }

  void fetchGenres() async {
    emit(GenresLoading());
    try {
      final genres = await getGenres();
      emit(GenresLoaded(genres));
    } catch (e) {
      emit(GenresError(e.toString()));
    }
  }
}
