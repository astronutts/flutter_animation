import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ExplicitAnimation extends StatefulWidget {
  const ExplicitAnimation({super.key});

  @override
  State<ExplicitAnimation> createState() => _ExplicitAnimationState();
}

class _ExplicitAnimationState extends State<ExplicitAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController = AnimationController(
    vsync: this,
  );

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Ticker((elapsed) => print(elapsed));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explicit Animation',
        ),
      ),
    );
  }
}
