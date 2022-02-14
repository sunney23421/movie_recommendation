import 'package:flutter/material.dart';
import 'package:movie_recommendation/features/movie_flow/landing/landing_screen.dart';

class MovieFlow extends StatefulWidget {
  const MovieFlow({Key? key}) : super(key: key);

  @override
  _MovieFlowState createState() => _MovieFlowState();
}

class _MovieFlowState extends State<MovieFlow> {
  final pageController = PageController();
  //page controller. and need to dispose of it

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      //how long and how animation of goint to next page
    );
  } //this one call method

  void previousPage() {
    pageController.previousPage(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  } //dispose methond

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      //physics: const NeverScrollableScrollPhysics(),
      children: [
        LandingScreen(nextPage: nextPage,previousPage: previousPage,),
        Scaffold(body: Container(color: Colors.red)),
        Scaffold(body: Container(color: Colors.blue)),
        Scaffold(body: Container(color: Colors.orange)),
        Scaffold(body: Container(color: Colors.pink)),
        Scaffold(body: Container(color: Colors.green))
      ],
    );
  } //page view
}
 