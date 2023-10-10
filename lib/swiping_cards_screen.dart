import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SwipingCardsScreen extends StatefulWidget {
  const SwipingCardsScreen({super.key});

  @override
  State<SwipingCardsScreen> createState() => _SwipingCardsScreenState();
}

class _SwipingCardsScreenState extends State<SwipingCardsScreen>
    with SingleTickerProviderStateMixin {
  late final size = MediaQuery.of(context).size;
  late final AnimationController _animationController = AnimationController(
    vsync: this,
    duration: const Duration(
      seconds: 5,
    ),
    lowerBound: (size.width + 100) * -1,
    upperBound: (size.width + 100),
    value: 0.0,
  );

  late final Tween<double> _rotation = Tween(
    begin: -15,
    end: 15,
  );

  late final Tween<double> _scale = Tween(
    begin: 0.8,
    end: 1.0,
  );

  double posX = 0;

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    _animationController.value += details.delta.dx;
    setState(() {
      _backGround = Colors.yellow;
    });
  }

  void _animateSlide() {
    _animationController.animateTo((size.width + 100) * -1).whenComplete(() {
      _animationController.value = 0;
      setState(() {
        _index = _index == 5 ? 1 : _index + 1;
      });
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    final bound = size.width - 100;
    if (_animationController.value.abs() >= bound) {
      if (_animationController.value.isNegative) {
        _animateSlide();
      } else {
        _animationController.animateTo(size.width + 100).whenComplete(() {
          _animationController.value = 0;
          setState(() {
            _index = _index == 5 ? 1 : _index + 1;
          });
        });
      }
    } else {
      _animationController.animateTo(
        0,
        curve: Curves.bounceOut,
      );
    }
    setState(() {
      _backGround = Colors.black;
    });
  }

  bool showFront = true;

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  int _index = 1;
  Color _backGround = Colors.white;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: _backGround,
      appBar: AppBar(
        title: const Text('Swiping Cards'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 600,
            child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                final angle = _rotation.transform(
                  (_animationController.value + size.width / 2) / size.width,
                );

                final scale = _scale
                    .transform(_animationController.value.abs() / size.width);
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Positioned(
                      top: 100,
                      child: Transform.scale(
                          scale: min(scale, 1.0),
                          child: Card(
                            index: _index == 5 ? 1 : _index + 1,
                          )),
                    ),
                    Positioned(
                      top: 100,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            showFront = !showFront;
                          });
                        },
                        onHorizontalDragUpdate: _onHorizontalDragUpdate,
                        onHorizontalDragEnd: _onHorizontalDragEnd,
                        child: Transform.translate(
                          offset: Offset(_animationController.value, 0),
                          child: Transform.rotate(
                            angle: (angle * pi) / 180,
                            child: AnimatedSwitcher(
                              duration: const Duration(
                                milliseconds: 200,
                              ),
                              child: showFront
                                  ? Card(index: _index)
                                  : const BehindCard(),
                            ),
                          ),
                        ),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  _animationController
                      .animateTo((size.width + 100) * -1)
                      .whenComplete(() {
                    _animationController.value = 0;
                    setState(() {
                      _index = _index == 5 ? 1 : _index + 1;
                    });
                  });
                },
                icon: const FaIcon(
                  FontAwesomeIcons.circleXmark,
                  size: 50,
                  color: Colors.red,
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              IconButton(
                onPressed: () {
                  _animationController
                      .animateTo(size.width + 100)
                      .whenComplete(() {
                    _animationController.value = 0;
                    setState(() {
                      _index = _index == 5 ? 1 : _index + 1;
                    });
                  });
                },
                icon: const FaIcon(
                  FontAwesomeIcons.circleCheck,
                  size: 50,
                  color: Colors.green,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class Card extends StatelessWidget {
  final int index;
  const Card({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: Image.asset(
          "assets/cover/$index.jpg",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class BehindCard extends StatelessWidget {
  const BehindCard({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Material(
      elevation: 10,
      borderRadius: BorderRadius.circular(10),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: size.width * 0.8,
        height: size.height * 0.5,
        child: const Center(child: Text('This is behind Card')),
      ),
    );
  }
}
