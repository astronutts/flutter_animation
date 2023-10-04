import 'package:flutter/material.dart';

class MovingAnimation extends StatefulWidget {
  const MovingAnimation({super.key});

  @override
  State<MovingAnimation> createState() => _MovingAnimationState();
}

class _MovingAnimationState extends State<MovingAnimation> {
  bool _visible = true;

  void _trigger() {
    setState(() {
      _visible = !_visible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Moving Animation!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: 16,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Stack(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(seconds: 5),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Center(
                          child: _visible
                              ? Text('${index + 1}')
                              : Text('${index + 2}'),
                        ),
                      ),
                      AnimatedContainer(
                        transform: Matrix4.rotationX(_visible ? 0 : 1),
                        transformAlignment: _visible
                            ? Alignment.centerLeft
                            : Alignment.topRight,
                        width: _visible ? 100 : 30,
                        height: _visible ? 100 : 30,
                        decoration: const BoxDecoration(
                          color: Colors.yellow,
                        ),
                        duration: const Duration(
                          seconds: 2,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
              onPressed: _trigger,
              child: const Text(
                'Go',
                style: TextStyle(fontSize: 30),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
