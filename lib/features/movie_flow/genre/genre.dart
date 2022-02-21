import 'package:flutter/foundation.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre_entity.dart';
//List constructor

@immutable
//Unidirectional data flow
class Genre {
  final String name;
  final bool isSelected;
  final int id;
  const Genre({required this.name, this.id = 0, this.isSelected = false});

  factory Genre.fromEntity(GenreEntity entity) {
    return Genre(name: entity.name,id: entity.id,isSelected: false);
  }

  Genre toggleSelected() {
    return Genre(
      name: name,
      id: id,
      isSelected: false,
    );
  }

  @override
  String toString() => "Genre(name: $name, isSelected: $isSelected, id: $id)";

//hash code
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Genre &&
        other.name == name &&
        other.isSelected == isSelected &&
        other.id == id;
  }

  @override
  int get hashCode => name.hashCode ^ isSelected.hashCode ^ id.hashCode;
}
