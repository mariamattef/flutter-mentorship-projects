import 'package:hive_flutter/adapters.dart';
import 'package:themeandpagination/features/movies/data/models/genre_model.dart';
import 'package:themeandpagination/features/movies/data/models/movie_model.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MovieModelAdapter());
    Hive.registerAdapter(GenreModelAdapter());
  }
}
