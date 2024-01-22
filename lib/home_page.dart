import 'package:flutter/material.dart';
import 'package:flutter_animations/rotating_cuboid.dart';
import 'package:flutter_animations/models.dart';
import 'package:flutter_animations/rotating_polygon.dart';
import 'package:flutter_animations/rotating_rectangle.dart';
import 'package:flutter_animations/tween_builder.dart';

import 'details_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const DetailsPage()));
                      },
                      child: Hero(
                        tag: Product.products.imageUrl,
                        child: Image.asset(
                          Product.products.imageUrl,
                          width: 150,
                        ),
                      ),
                    ),
                    Text(Product.products.title),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RotatingRectangle()));
                      },
                      child: const Text('3 rotating rectangles'),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RotatingCube()));
                      },
                      child: const Text('Rotating Cube'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const ShapeColorTween()));
                      },
                      child: const Text('Shape Tween '),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => const RotatingPolygon()));
                      },
                      child: const Text('Rotating Polygons'),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
