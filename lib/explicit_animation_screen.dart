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
  )
    ..addListener(() {
      _value.value = _animationController.value;
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _animationController.forward();
      }
    });

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(
        const Duration(
          milliseconds: 500,
        ),
        (timer) {});
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

  final ValueNotifier<double> _value = ValueNotifier(0.0);
  void _onChanged(double value) {
    _value.value = 0;
    _animationController.value = value;
    //_animationController.animateTo(value);
  }

  late final Animation<Decoration> _decoration = DecorationTween(
    begin: BoxDecoration(
      color: Colors.amber,
      borderRadius: BorderRadius.circular(20),
    ),
    end: BoxDecoration(
      color: Colors.red,
      borderRadius: BorderRadius.circular(40),
    ),
  ).animate(_animationController);

  late final Animation<double> _rotation = Tween(
    begin: 0.0,
    end: 0.5,
  ).animate(_curve);

  late final Animation<double> _scale = Tween(
    begin: 1.0,
    end: 1.5,
  ).animate(_curve);

  late final Animation<Offset> _Offset = Tween(
    begin: Offset.zero,
    end: const Offset(0, 0),
  ).animate(_curve);

  late final CurvedAnimation _curve =
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut);

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _animationController.dispose();
  }

  bool _looping = false;
  void _toggleLooping() {
    if (_looping) {
      _animationController.stop();
    } else {
      _animationController.repeat(
        reverse: true,
      );
    }
    setState(() {
      _looping = !_looping;
    });
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
            ),
            const SizedBox(
              height: 20,
            ),
            ValueListenableBuilder(
              valueListenable: _value,
              builder: (context, value, child) {
                return Slider(value: value, onChanged: _onChanged);
              },
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: _toggleLooping,
              child: const Text(
                '무한버튼',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
