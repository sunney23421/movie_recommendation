import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/core/environment_variables.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre_entity.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie_entity.dart';
import 'package:movie_recommendation/main.dart';

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return TMDMovieRepository(dio: dio);
});

abstract class MovieRepository {
  Future<List<GenreEntity>> getMovieGenres();
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genreIds);
}

class TMDMovieRepository implements MovieRepository {
  TMDMovieRepository({required this.dio});
  final Dio dio;

  @override
  Future<List<GenreEntity>> getMovieGenres() async {
    final response = await dio.get("genre/movie/list", queryParameters: {
      "api_key": api,
      "language": "en-US",
    });
    final results = List<Map<String, dynamic>>.from(response.data["genres"]);
    final genres = results.map((e) => GenreEntity.fromMap(e)).toList();

    return genres;
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genreIds) async {
    final response = await dio.get("discover/movie", queryParameters: {
      "api_key": api,
      "language": "en_US",
      "sort_by": "popularity.desc",
      "include_adult": false,
      "vote_average.gte": rating,
      "page": 1,
      "release_date.gte": date,
      "wiht_genres": genreIds,
    });
    final results = List<Map<String, dynamic>>.from(response.data["results"]);
    final moives = results.map((e) => MovieEntity.from(e)).toList();
    return moives;
  }
}
//Lecture 3 - Creating the Repository
