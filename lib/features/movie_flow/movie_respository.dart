import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/core/environment_variables.dart';
import 'package:movie_recommendation/core/failure.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre_entity.dart';
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
    try {
      final response = await dio.get('genre/movie/list', queryParameters: {
        'api_key': api,
        'language': 'en-US',
      });
      final results = List<Map<String, dynamic>>.from(response.data["genres"]);
      final genres = results.map((e) => GenreEntity.fromMap(e)).toList();

      return genres;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw Failure(
          message: "No internet conncetion",
          exception: e,
        );
      } //endtry catch

      throw Failure(
          message: e.response?.statusMessage ?? "Something went wrong",
          code: e.response?.statusCode);
    }
  }

  @override
  Future<List<MovieEntity>> getRecommendedMovies(
      double rating, String date, String genreIds) async {
    try {
      final response = await dio.get('discover/movie', queryParameters: {
        'api_key': api,
        'language': 'en-US',
        'sort_by': 'popularity.desc',
        'include_adult': false,
        'vote_average.gte': rating,
        'page': 1,
        'release_date.gte': date,
        'with_genres': genreIds,
      });
      final results = List<Map<String, dynamic>>.from(response.data['results']);
      final movies = results.map((e) => MovieEntity.fromMap(e)).toList();
      return movies;
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw Failure(
          message: "No internet conncetion2",
          exception: e,
        );
      } //end try
      throw Failure(
        message: e.response?.statusMessage ?? "Something went wrong",
        code: e.response?.statusCode,
      );
    }
  }
}
//Lecture 3 - Creating the Repository
