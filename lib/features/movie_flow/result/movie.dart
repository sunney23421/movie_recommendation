import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie_entity.dart';

// return from api

@immutable
class Movie {
  final String title;
  final String overview;
  final num  voteAverage;
  final List<Genre> genres;
  final String releaseDate;
  final String? backdropPath;
  final String? posterPath;

  const Movie({
    required this.title,
    required this.overview,
    required this.voteAverage,
    required this.genres,
    required this.releaseDate,
    this.backdropPath,
    this.posterPath,
    //nomal constructor
  });

  Movie.initial()
      : title = "",
        overview = "",
        voteAverage = 0,
        genres = [],
        releaseDate = "",
        backdropPath = "",
        posterPath = "";

  factory Movie.fromEntity(MovieEntity entity, List<Genre> genres) {
    return Movie(
      title: entity.title,
      overview: entity.overview,
      voteAverage: entity.voteAverage,
      genres: genres
          .where((genre) => entity.genreIds.contains(genre.id))
          .toList(growable: false),
      releaseDate: entity.releaseDate,
      backdropPath: "https://image.tmdb.org/t/p/original/${entity.backdropPath}",
      posterPath: "https://image.tmdb.org/t/p/original/${entity.posterPath}"
    );
  }
  //movie constuger

  String get genresCommaSeperated =>
      genres.map((e) => e.name).toList().join(",");

  @override
  String toString() {
    return "Movie(title: $title, overview:$overview, voteAverage: $voteAverage, genres: $genres, releaseDate:$releaseDate)";
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.title == title &&
        other.overview == overview &&
        other.voteAverage == voteAverage &&
        listEquals(other.genres, genres) &&
        other.releaseDate == releaseDate;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        overview.hashCode ^
        voteAverage.hashCode ^
        genres.hashCode ^
        releaseDate.hashCode;
  }
}
