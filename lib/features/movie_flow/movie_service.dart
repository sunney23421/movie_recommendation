//act like middle man between _controller and _respository

import 'dart:math';

import 'package:movie_recommendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation/features/movie_flow/movie_respository.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie_entity.dart';
import 'package:riverpod/riverpod.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  final movieRepository = ref.watch(movieRepositoryProvider);
  return TMDBMovieService(movieRepository);
});

abstract class MovieService {
  Future<List<Genre>> getGenres();
  Future<Movie> getRecommendedMovie(
    int rating,
    int yearsBack,
    List<Genre> genres, [
    DateTime? yearsBackFromDate,
  ]);
}

class TMDBMovieService implements MovieService {
  TMDBMovieService(this._movieRepository);
  final MovieRepository _movieRepository;

  @override
  Future<List<Genre>> getGenres() async {
    final genreEntities = await _movieRepository.getMovieGenres();
    final genres = genreEntities.map((e) => Genre.fromEntity(e)).toList();
    return genres;
  }

  @override
  Future<Movie> getRecommendedMovie(
      int rating, int yearsBack, List<Genre> genres,
      [DateTime? yearsBackFromDate]) async {
    final date = yearsBackFromDate ?? DateTime.now();
    final year = date.year - yearsBack;
    final genreIds = genres.map((e) => e.id).toList().join(',');
    final movieEntities = await _movieRepository.getRecommendedMovies(
        rating.toDouble(), '$year-01-01', genreIds);
    final movies =
        movieEntities.map((e) => Movie.fromEntity(e, genres)).toList();
    final rnd = Random();
    final randomMovie = movies[rnd.nextInt(movies.length)];
    return randomMovie;
  }
}
//  Lecture 4 - Creating the Service