import 'dart:async';

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
    duration: const Duration(
      seconds: 10,
    ),
  )..addListener(() {
      setState(() {});
    });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(
        const Duration(
          milliseconds: 500,
        ), (timer) {
      print(_animationController.value);
    });
  }

  void _play() {
    _animationController.forward();
  }

  void _pause() {
    _animationController.stop();
  }

  void _rewind() {
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Explicit Animation',
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Text(
                  '${_animationController.value}',
                  style: const TextStyle(
                    fontSize: 40,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _pause,
                  child: const Icon(
                    Icons.pause_rounded,
                  ),
                ),
                ElevatedButton(
                  onPressed: _play,
                  child: const Icon(
                    Icons.play_arrow_rounded,
                  ),
                ),
                ElevatedButton(
                  onPressed: _rewind,
                  child: const Icon(
                    Icons.fast_rewind_rounded,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
