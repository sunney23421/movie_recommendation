//riverpod
import 'package:flutter/material.dart';
import 'package:movie_recommendation/features/movie_flow/movie_flow.dart';
import 'package:movie_recommendation/features/movie_flow/result/movie.dart';

import 'genre/genre.dart';

const genresMock = [
  Genre(name: "Action"),
  Genre(name: "Comedy"),
  Genre(name: "Horror"),
  Genre(name: "Anime"),
  Genre(name: "Drame"),
  Genre(name: "Family"),
  Genre(name: "Romance"),
];

const movieMock = Movie(
  title: "The hulk",
  overview: "this is the oveview",
  voteAverage: 4.5,
  genres: [Genre(name: "Action"), Genre(name: "Fantasy")],
  releaseDate: "2019-05-24",
  backdropPath: "",
  posterPath: "",
  //fake obj
);

@immutable
class MovieFlowState {
  final PageController pageController;
  final int rating;
  final int yearsBack;
  final List<Genre> genres;
  final Movie movie;

  const MovieFlowState({
    required this.pageController,
    this.movie = movieMock,
    this.genres = genresMock,
    this.rating = 5,
    this.yearsBack = 10,
  }); //constuger

  MovieFlowState copyWith({
    PageController? pageController,
    int? rating,
    int? yearsBack,
    List<Genre>? genres,
    Movie? movie,
  }) {
    return MovieFlowState(
      pageController: pageController ?? this.pageController,
      rating: rating ?? this.rating,
      yearsBack: yearsBack ?? this.yearsBack,
      genres: genres ?? this.genres,
      movie: movie ?? this.movie,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is MovieFlowState &&
        other.pageController == pageController &&
        other.rating == rating &&
        other.yearsBack == yearsBack &&
        other.movie == movie;
  }

  @override
  int get hashCode {
    return pageController.hashCode ^
        rating.hashCode ^
        yearsBack.hashCode ^
        genres.hashCode ^
        movie.hashCode;
  }
}
