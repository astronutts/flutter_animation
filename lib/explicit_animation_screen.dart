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
      seconds: 2,
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

  late final Animation<Decoration> _decoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(20),
    ),
    end: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(200),
    ),
  ).animate(_animationController);

  late final Animation<double> _rotation = Tween(
    begin: 0.0,
    end: 2.0,
  ).animate(_animationController);

  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 2.0,
  ).animate(_animationController);

  late final Animation<Offset> _Offset = Tween(
    begin: Offset.zero,
    end: const Offset(0, 0.5),
  ).animate(_animationController);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
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
            SlideTransition(
              position: _Offset,
              child: ScaleTransition(
                scale: _scale,
                child: RotationTransition(
                  turns: _rotation,
                  child: DecoratedBoxTransition(
                    decoration: _decoration,
                    child: const SizedBox(
                      height: 300,
                      width: 300,
                    ),
                  ),
                ),
              ),
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
