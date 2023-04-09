import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: const Center(
        child: SizedBox(
          height: 50.0,
          width: 50.0,
          child: LoadingIndicator(
            indicatorType: Indicator.ballPulse,
            colors: [Colors.purple],
          ),
        ),
      ),
    );
  }
}
