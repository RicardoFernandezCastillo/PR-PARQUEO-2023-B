/*

import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay;
  final Widget child;

  FadeAnimation(this.delay, this.child);

  @override
  Widget build(BuildContext context) {
    final tween = MultiTrackTween([
      Track("opacity").add(Duration(milliseconds: 500), Tween(begin: 0.0, end: 1.0)),
      Track("translateY").add(
        Duration(milliseconds: 500), Tween(begin: -30.0, end: 0.0),
        curve: Curves.easeOut)
    ]);

    
    // Simple staggered tween
    final tween1 = MovieTween()
      ..tween('width', Tween(begin: 0.0, end: 100),
              duration: const Duration(milliseconds: 1500), curve: Curves.easeIn)
          .thenTween('width', Tween(begin: 100, end: 200),
              duration: const Duration(milliseconds: 750), curve: Curves.easeOut);

    // Design tween by composing scenes
    final tween2 = MovieTween()
      ..scene(
              begin: const Duration(milliseconds: 0),
              duration: const Duration(milliseconds: 500))
          .tween('width', Tween<double>(begin: 0.0, end: 400.0))
          .tween('height', Tween<double>(begin: 500.0, end: 200.0))
          .tween('color', ColorTween(begin: Colors.red, end: Colors.blue))
      ..scene(
              begin: const Duration(milliseconds: 700),
              end: const Duration(milliseconds: 1200))
          .tween('width', Tween<double>(begin: 400.0, end: 500.0));

    // Type-safe alternative
    final width = MovieTweenProperty<double>();
    final color = MovieTweenProperty<Color?>();

    final tween3 = MovieTween()
      ..tween<double>(width, Tween(begin: 0.0, end: 100))
      ..tween<Color?>(color, ColorTween(begin: Colors.red, end: Colors.blue));


    return ControlledAnimation(
      delay: Duration(milliseconds: (500 * delay).round()),
      duration: tween.duration,
      tween: tween,
      child: child,
      builderWithChild: (context, child, animation) => Opacity(
        opacity: animation["opacity"],
        child: Transform.translate(
          offset: Offset(0, animation["translateY"]), 
          child: child
        ),
      ),
    );
  }
}
*/