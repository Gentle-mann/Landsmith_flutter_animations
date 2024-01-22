import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShapeColorTween extends StatefulWidget {
  const ShapeColorTween({super.key});

  @override
  State<ShapeColorTween> createState() => _ShapeColorTweenState();
}

Color _randomColor() => Color(0xFF000000 + math.Random().nextInt(0x00FFFFFF));

class _ShapeColorTweenState extends State<ShapeColorTween> {
  Color _color = _randomColor();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: TweenAnimationBuilder(
            onEnd: () {
              setState(() {
                _color = _randomColor();
              });
            },
            tween: ColorTween(begin: _color, end: _randomColor()),
            duration: const Duration(seconds: 1),
            builder: (context, color, child) {
              return ColorFiltered(
                colorFilter: ColorFilter.mode(
                  color!,
                  BlendMode.srcATop,
                ),
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blue,
                ),
              );
            }),
      ),
    );
  }
}

class ColorClipper extends CustomClipper<Path> {
  const ColorClipper();
  @override
  Path getClip(Size size) {
    final path = Path();
    final clip = Rect.fromCircle(
        center: Offset(size.width * 0.5, size.height * 0.5),
        radius: size.width * 0.5);
    path.addOval(clip);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
