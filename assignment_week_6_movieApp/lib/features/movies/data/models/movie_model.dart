import 'package:hive/hive.dart';

import '../../domain/entities/movie.dart';

part 'movie_model.g.dart';


@HiveType(typeId: 0)
class MovieModel extends Movie with HiveObjectMixin {
  @HiveField(0)
  @override
  final int id;

  @HiveField(1)
  @override
  final String title;

  @HiveField(2)
  @override
  final String overview;

  @HiveField(3)
  @override
  final String posterPath;

  @HiveField(4)
  @override
  final double voteAverage;

  @HiveField(5)
  @override
  final List<int> genreIds;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    required this.genreIds,
  }) : super(
         id: id,
         title: title,
         overview: overview,
         posterPath: posterPath,
         voteAverage: voteAverage,
         genreIds: genreIds,
       );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      genreIds: List<int>.from(json['genre_ids']),
    );
  }
}
