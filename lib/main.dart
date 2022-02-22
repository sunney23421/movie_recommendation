import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommendation/features/movie_flow/movie_flow.dart';
import 'package:movie_recommendation/theme/custom_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(
    baseUrl: "https://api.themoviedb.org/3/",
  ));
});

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("main");
    return MaterialApp(
      title: 'Flutter Demo',
      darkTheme: CustomTheme.darkTheme(context),
      themeMode: ThemeMode.dark,
      home: const MovieFlow(),
    );
  }
}
