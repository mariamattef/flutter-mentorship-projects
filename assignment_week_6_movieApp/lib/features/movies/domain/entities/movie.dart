class Movie {
  final int id;
  final String title;
  final String? overview;
  final String? posterPath;
  final double voteAverage;
  final String? genre;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.voteAverage,
    this.genre,
  });
}
