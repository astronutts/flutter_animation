import 'package:flutter/material.dart';
import 'package:flutter_animation/implicit_animation_screen.dart';

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
            ElevatedButton(
              onPressed: () {
                _goScreen(context, const ImplicitAnimationScreen());
              },
              child: const Text(
                'Implicit Animations',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
