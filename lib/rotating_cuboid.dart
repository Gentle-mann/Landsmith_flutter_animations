import 'dart:math' show pi;

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class RotatingCube extends StatefulWidget {
  const RotatingCube({super.key});

  @override
  State<RotatingCube> createState() => _RotatingCubeState();
}

class _RotatingCubeState extends State<RotatingCube>
    with TickerProviderStateMixin {
  late AnimationController _xController;
  late AnimationController _yController;
  late AnimationController _zController;
  late Tween<double> _animation;

  @override
  void initState() {
    super.initState();
    _xController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    );
    _yController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 30),
    );
    _zController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 40),
    );

    _animation = Tween<double>(begin: 0.0, end: 2 * pi);
  }

  @override
  void dispose() {
    _xController.dispose();
    _yController.dispose();
    _zController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const depth = 100.0;

    _xController
      ..reset()
      ..repeat();
    _yController
      ..reset()
      ..repeat();
    _zController
      ..reset()
      ..repeat();
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: AnimatedBuilder(
                  animation: Listenable.merge(
                    [
                      _xController,
                      _yController,
                      _zController,
                    ],
                  ),
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateX(_animation.evaluate(_xController))
                        ..rotateY(_animation.evaluate(_yController))
                        ..rotateZ(
                          _animation.evaluate(_zController),
                        ),
                      child: Stack(
                        children: [
                          const CustomContainer(
                            color: Colors.amberAccent,
                            isCuboid: false,
                          ),
                          Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..translate(Vector3(0, 0, -depth)),
                            child: const CustomContainer(
                              color: Colors.pinkAccent,
                              isCuboid: false,
                            ),
                          ),
                          Transform(
                            alignment: Alignment.centerLeft,
                            transform: Matrix4.identity()..rotateY(pi * 0.5),
                            child: const CustomContainer(
                              color: Colors.blueAccent,
                              isCuboid: false,
                            ),
                          ),
                          Transform(
                            alignment: Alignment.centerRight,
                            transform: Matrix4.identity()..rotateY(-pi * 0.5),
                            child: const CustomContainer(
                              color: Colors.cyanAccent,
                              isCuboid: false,
                            ),
                          ),
                          Transform(
                            alignment: Alignment.topCenter,
                            transform: Matrix4.identity()..rotateX(-pi * 0.5),
                            child: const CustomContainer(
                              color: Colors.greenAccent,
                              isCuboid: false,
                            ),
                          ),
                          Transform(
                            alignment: Alignment.bottomCenter,
                            transform: Matrix4.identity()..rotateX(pi * 0.5),
                            child: const CustomContainer(
                              color: Colors.limeAccent,
                              isCuboid: false,
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.color,
    required this.isCuboid,
  });
  final Color color;
  final bool isCuboid;

  @override
  Widget build(BuildContext context) {
    const squareDimension = 100.0;
    const length = 200.0;
    const width = 150.0;

    return Container(
      color: color,
      width: isCuboid ? width : squareDimension,
      height: isCuboid ? length : squareDimension,
    );
  }
}
