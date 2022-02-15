import 'package:flutter/material.dart';
import 'package:movie_recommendation/core/constants.dart';
import 'package:movie_recommendation/core/widget/primary_button.dart';

class YearsBackScreen extends StatefulWidget {
  const YearsBackScreen({
    Key? key,
    required this.nextPage,
    required this.previousPage,
  }) : super(key: key);

  final VoidCallback nextPage;
  final VoidCallback previousPage;

  @override
  _YearsBackScreenState createState() => _YearsBackScreenState();
}

class _YearsBackScreenState extends State<YearsBackScreen> {
  double yearsBack = 10;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(onPressed: widget.previousPage),
      ),
      body: Center(
          child: Column(
        children: [
          Text(
            "How many years back should we check for",
            style: theme.textTheme.headline5,
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text("${yearsBack.ceil()}"),
            Text(
              "Years back",
              style: theme.textTheme.headline4?.copyWith(
                color: theme.textTheme.headline4?.color?.withOpacity(0.62),
              ),
            ),
          ]),
          const Spacer(),
          Slider(
            onChanged: (value) {
              setState(() {
                yearsBack = value;
              });
            },
            value: yearsBack,
            min: 0,
            max: 70,
            divisions: 70,
            label: '${yearsBack.ceil()}',
          ),
          const Spacer(),
          PrimaryButton(
            onPressed: () {},
            text: "Amazing",
          ),
          const SizedBox(
            height: kMediumSpacing,
          )
        ],
      )),
    );
  }
}
