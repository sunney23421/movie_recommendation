import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation/features/movie_flow/movie_flow_state.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie.dart';

final MovieFlowControllerProvider =
    StateNotifierProvider.autoDispose<MovieFlowController, MovieFlowState>(
  (ref) {
    return MovieFlowController(
        MovieFlowState(pageController: PageController()));
  },
);

class MovieFlowController extends StateNotifier<MovieFlowState> {
  MovieFlowController(MovieFlowState state) : super(state);

  void toggleSelected(Genre genre) {
    state = state.copyWith(genres: [
      for (final oldGenre in state.genres)
        if (oldGenre == genre) oldGenre.toggleSelected()
    ]);
  }
}
