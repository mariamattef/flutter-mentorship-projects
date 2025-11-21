import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:themeandpagination/core/databases/api/api_consumer.dart';
import 'package:themeandpagination/core/databases/api/end_points.dart';
import 'package:themeandpagination/features/movies/data/models/genre_model.dart';

import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies({required int page});
  Future<List<GenreModel>> getGenres();
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiConsumer api;

  MovieRemoteDataSourceImpl({required this.api});
  @override
  Future<List<MovieModel>> getPopularMovies({required int page}) async {
    final response = await api.get(
      EndPoints.popular,
      queryParameters: {
        "api_key": dotenv.env['API_KEY'],
        "language": "en-US",
        "page": page,
      },
    );

    final List results = response["results"];

    return results.map((json) => MovieModel.fromJson(json)).toList();
  }

  @override
  Future<List<GenreModel>> getGenres() async {
    final response = await api.get(
      EndPoints.genres,
      queryParameters: {
        "api_key": dotenv.env['API_KEY'],
        "language": "en-US",
      },
    );

    final List results = response["genres"];

    return results.map((json) => GenreModel.fromJson(json)).toList();
  }
}
