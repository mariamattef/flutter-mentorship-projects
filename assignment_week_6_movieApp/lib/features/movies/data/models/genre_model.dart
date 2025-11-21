import 'package:hive_flutter/adapters.dart';
import 'package:themeandpagination/features/movies/domain/entities/genre.dart';

part 'genre_model.g.dart';

@HiveType(typeId: 1)
class GenreModel extends Genre with HiveObjectMixin {
  @HiveField(0)
  @override
  final int id;
  @HiveField(1)
  @override
  final String name;
  GenreModel({required this.id, required this.name})
    : super(id: id, name: name);

  factory GenreModel.fromJson(Map<String, dynamic> json) {
    return GenreModel(id: json['id'], name: json['name']);
  }
}
