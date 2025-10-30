import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:themeandpagination/core/databases/api/api_consumer.dart';
import 'package:themeandpagination/core/databases/api/end_points.dart';

import '../models/movie_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getPopularMovies({required int page});
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final ApiConsumer api;

  MovieRemoteDataSourceImpl({required this.api});
  @override
  Future<List<MovieModel>> getPopularMovies({required int page}) async {
    final response = await api.get(
      EndPoints.pupular,
      queryParameters: {
        "api_key": dotenv.env['API_KEY'],
        "language": "en-US",
        "page": page,
      },
    );

    final List results = response["results"];

    return results.map((json) => MovieModel.fromJson(json)).toList();
  }
}
