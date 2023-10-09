import 'package:flutter/material.dart';
import 'package:flutter_animation/implicit_animation_screen.dart';
import 'package:flutter_animation/moving_animation.dart';
import 'package:flutter_animation/swiping_cards_screen.dart';

import 'explicit_animation_screen.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _goScreen(BuildContext context, screen) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => screen,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fluttter Animations',
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _goScreen(
                  context,
                  const ImplicitAnimationScreen(),
                );
              },
              child: const Text(
                'Implicit Animations',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _goScreen(
                  context,
                  const MovingAnimation(),
                );
              },
              child: const Text(
                "moving Animation",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _goScreen(
                  context,
                  const ExplicitAnimation(),
                );
              },
              child: const Text(
                "Explicit Animation",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                _goScreen(
                  context,
                  const SwipingCardsScreen(),
                );
              },
              child: const Text(
                "Swiping Cards Animation",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
