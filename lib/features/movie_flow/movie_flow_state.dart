//riverpod
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/features/movie_flow/movie_flow.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie.dart';

import 'genre/genre.dart';


@immutable
class MovieFlowState {
  final PageController pageController;
  final int rating;
  final int yearsBack;
  final AsyncValue<List<Genre>> genres;
  final AsyncValue<Movie> movie;

  const MovieFlowState({
    required this.pageController,
    required this.movie,
    required this.genres,
    this.rating = 5,
    this.yearsBack = 10,
  }); //constuger

  MovieFlowState copyWith({
    PageController? pageController,
    int? rating,
    int? yearsBack,
    AsyncValue<List<Genre>>? genres,
    AsyncValue<Movie>? movie,
  }) {
    return MovieFlowState(
      pageController: pageController ?? this.pageController,
      rating: rating ?? this.rating,
      yearsBack: yearsBack ?? this.yearsBack,
      genres: genres ?? this.genres,
      movie: movie ?? this.movie,
      //?? if xxx is null, use defalse value
    );
  } //copy orginan state

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MovieFlowState &&
        other.pageController == pageController &&
        other.rating == rating &&
        other.yearsBack == yearsBack &&
        other.genres == genres &&
        other.movie == movie;
  }

  @override
  int get hashCode {
    return pageController.hashCode ^ rating.hashCode ^ yearsBack.hashCode ^ genres.hashCode ^ movie.hashCode;
  }
}
