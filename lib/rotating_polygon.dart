import 'dart:math';

import 'package:flutter/material.dart';

class RotatingPolygon extends StatefulWidget {
  const RotatingPolygon({super.key});

  @override
  State<RotatingPolygon> createState() => _RotatingPolygonState();
}

Color _randomColor() => Color(
      0xFF000000 + Random().nextInt(0x00FFFFFF),
    );

class _RotatingPolygonState extends State<RotatingPolygon>
    with TickerProviderStateMixin {
  Color _activeColor = _randomColor();
  late AnimationController _sidesNumAnimationController;
  late AnimationController _rotationAnimationController;
  late AnimationController _radiusAnimationController;
  late Animation _sidesNumAnimation;
  late Animation _radiusAnimation;
  late Animation _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _sidesNumAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );
    _radiusAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );
    _rotationAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );
    _sidesNumAnimation =
        IntTween(begin: 3, end: 10).animate(_sidesNumAnimationController);
    _radiusAnimation =
        Tween<double>(begin: 200, end: 10).animate(_radiusAnimationController);
    _rotationAnimation = Tween<double>(begin: pi * 2, end: 0)
        .animate(_rotationAnimationController);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _sidesNumAnimationController.repeat();
    _radiusAnimationController.repeat();
    _rotationAnimationController.repeat();
  }

  @override
  void dispose() {
    _sidesNumAnimationController.dispose();
    _radiusAnimationController.dispose();
    _rotationAnimationController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              TweenAnimationBuilder(
                  duration: const Duration(seconds: 1),
                  onEnd: () {
                    setState(() {
                      _activeColor = _randomColor();
                    });
                  },
                  tween: ColorTween(begin: _activeColor, end: _randomColor()),
                  builder: (context, color, child) {
                    return ColorFiltered(
                      colorFilter:
                          ColorFilter.mode(color!, BlendMode.difference),
                      child: Container(
                        color: Colors.white,
                        child: SizedBox(
                          width: size.width,
                          height: size.width * 0.5,
                        ),
                      ),
                    );
                  }),
              AnimatedBuilder(
                  animation: Listenable.merge(
                    [
                      _sidesNumAnimationController,
                      _radiusAnimation,
                      _rotationAnimation,
                    ],
                  ),
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..rotateX(_rotationAnimation.value),
                      child: CustomPaint(
                        painter:
                            PolygonPainter(sidesNum: _sidesNumAnimation.value),
                        child: Container(
                          color: Colors.transparent,
                          width: _radiusAnimation.value,
                          height: _radiusAnimation.value,
                        ),
                      ),
                    );
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class PolygonPainter extends CustomPainter {
  final int sidesNum;

  PolygonPainter({super.repaint, required this.sidesNum});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.redAccent
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4;
    final path = Path();
    final center = Offset(size.width * 0.5, size.height * 0.5);
    final angle = (pi * 2) / sidesNum;
    final polygonAngles = List.generate(sidesNum, (index) {
      return index * angle;
    });
    final radius = size.width * 0.5;
    path.moveTo(
      center.dx + radius * cos(0),
      center.dy + radius * sin(0),
    );
    for (final angle in polygonAngles) {
      path.lineTo(
        center.dx + radius * cos(angle),
        center.dy + radius * sin(angle),
      );
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(PolygonPainter oldDelegate) =>
      oldDelegate.sidesNum != sidesNum;

  @override
  bool shouldRebuildSemantics(PolygonPainter oldDelegate) => true;
}
