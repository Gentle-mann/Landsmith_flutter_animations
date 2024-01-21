import 'package:flutter/material.dart';
import 'package:flutter_animations/home_page.dart';

import 'models.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

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
            children: [
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HomePage()));
                        },
                        child: Hero(
                          flightShuttleBuilder: (
                            flightContext,
                            animation,
                            flightDirection,
                            fromHomeContext,
                            toHeroContext,
                          ) {
                            switch (flightDirection) {
                              case HeroFlightDirection.push:
                                return ScaleTransition(
                                  scale: animation.drive(
                                    Tween<double>(
                                      begin: 0.0,
                                      end: 1.0,
                                    ).chain(
                                      CurveTween(
                                        curve: Curves.fastOutSlowIn,
                                      ),
                                    ),
                                  ),
                                  child: toHeroContext.widget,
                                );
                              case HeroFlightDirection.pop:
                                return fromHomeContext.widget;
                            }
                          },
                          tag: Product.products.imageUrl,
                          child: Image.asset(
                            Product.products.imageUrl,
                            width: 350,
                          ),
                        ),
                      ),
                    ),
                    Text(Product.products.title),
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
