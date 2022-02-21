import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_recommendation/core/constants.dart';
import 'package:movie_recommendation/core/widget/primary_button.dart';
import 'package:movie_recommendation/features/movie_flow/movie_flow_controller.dart';

class LandingScreen extends ConsumerWidget {
  const LandingScreen({
    Key? key,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
            onPressed: ref.read(movieFlowControllerProvider.notifier).nextPage,
            text: "Get Started",
          ),//this is custom widget
          const SizedBox(height: kMediumSpacing,)
        ],
      )),
    );
  }
  
}
