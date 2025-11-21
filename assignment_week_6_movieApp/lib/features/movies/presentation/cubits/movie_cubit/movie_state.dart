import 'package:themeandpagination/features/movies/domain/entities/genre.dart';

import '../../../domain/entities/movie.dart';

abstract class MovieState {}

class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<Movie> movies;
  final List<Genre> genres;
  MovieLoaded(this.movies, this.genres);
}

class MovieError extends MovieState {
  final String message;
  MovieError(this.message);
}

class GenresLoading extends MovieState {}

class GenresLoaded extends MovieState {
  final List<Genre> genres;
  GenresLoaded(this.genres);
}

class GenresError extends MovieState {
  final String message;
  GenresError(this.message);
}
