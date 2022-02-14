import 'package:flutter/material.dart';
import 'package:movie_recommendation/core/constants.dart';
import 'package:movie_recommendation/core/widget/primary_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({
    Key? key,
    required this.nextPage,
    required this.previousPage,
  }) : super(key: key);

  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: Column(
        children: [
          Text(
            "Let's find a movie",
            style: Theme.of(context).textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Image.asset("images/logo.png"),
          const Spacer(),
          PrimaryButton(
            onPressed: nextPage,
            text: "Get Started",
          ),//this is custom widget
          const SizedBox(height: kMediumSpacing,)
        ],
      )),
    );
  }
  
}
