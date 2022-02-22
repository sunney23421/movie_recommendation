import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/features/movie_flow/genre/genre.dart';
import 'package:movie_recommendation/features/movie_flow/movie_flow_state.dart';
import 'package:movie_recommendation/features/movie_flow/movie_service.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie.dart';

//riverpod manager
final movieFlowControllerProvider =
    StateNotifierProvider.autoDispose<MovieFlowController, MovieFlowState>(
        (ref) {
  return MovieFlowController(
    MovieFlowState(
      pageController: PageController(),
      movie: AsyncValue.data(Movie.initial()),
      genres: const AsyncValue.data([]),
    ),
    ref.watch(movieServiceProvider),
  );
});

class MovieFlowController extends StateNotifier<MovieFlowState> {
  MovieFlowController(
    MovieFlowState state,
    this._movieService,
  ) : super(state) {
    loadGenres();
  }
  final MovieService _movieService;

  Future<void> loadGenres() async {
    state = state.copyWith(genres: const AsyncValue.loading());
    final result = await _movieService.getGenres();

    result.when((error) {
      state = state.copyWith(genres: AsyncValue.error(error));
    }, (genres) {
      final updatedGenres = AsyncValue.data(genres);
      state = state.copyWith(genres: updatedGenres);
    });
  }

  Future<void> getRecommendedMovie() async {
    state = state.copyWith(movie: const AsyncValue.loading());
    final selectedGenres = state.genres.asData?.value
            .where((e) => e.isSelected == true)
            .toList(growable: false) ??
        [];
    final result = await _movieService.getRecommendedMovie(
      state.rating,
      state.yearsBack,
      selectedGenres,
    );
    // Lecture 5 - AsyncValue and Fetching

    result.when((error) {
      state = state.copyWith(movie: AsyncValue.error(error));
    }, (movie) {
      state = state.copyWith(movie: AsyncValue.data(movie));
    });
  }// module 4 Lecture 2 - Multiple return types

  void toggleSelected(Genre genre) {
    state = state.copyWith(
      genres: AsyncValue.data([
        for (final oldGenre in state.genres.asData!.value)
          if (oldGenre == genre) oldGenre.toggleSelected() else oldGenre
      ]),
    );
  } //?????

  void updateRating(int updateRating) {
    state = state.copyWith(rating: updateRating);
  }

  void updateYearsBack(int updateYearsBack) {
    state = state.copyWith(yearsBack: updateYearsBack);
  }

  void nextPage() {
    if (state.pageController.page! >= 1) {
      if (!state.genres.asData!.value
          .any((element) => element.isSelected == true)) {
        return;
      }
    }
    state.pageController.nextPage(
        duration: const Duration(microseconds: 600),
        curve: Curves.easeInOutCubic);
  }

  void previousPage() {
    state.pageController.previousPage(
        duration: const Duration(microseconds: 600),
        curve: Curves.easeOutCubic);
  }

  @override
  void dispose() {
    state.pageController.dispose();
    super.dispose();
  }
}
//Lecture 2 - Controller and Provider, have to watch back
//Lecture 3 - Transitioning to Riverpod -- using riverpod