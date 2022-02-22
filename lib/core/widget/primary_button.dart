import 'package:flutter/material.dart';
import 'package:movie_recommendation/core/constants.dart';

//coustom widget
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.isLoading = false,
    this.width = double.infinity,
  }) : super(key: key);
//VoidCallback is function which takes no parameters and returns no parameters

  final VoidCallback onPressed;
  final bool isLoading;
  final String text;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: TextButton(
        style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            fixedSize: Size(width, 48)),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onPrimary,
              )
            else
              Text(
                text,
                style: Theme.of(context).textTheme.button,
              ),
          ],
        ),
      ),
    );
  }
}
