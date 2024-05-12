import 'package:flutter/material.dart';
import 'package:plusclouds/src/utils/animations/slide_animation.dart';

class ContinuousSlideFadeAnimation extends StatefulWidget {
  const ContinuousSlideFadeAnimation({
    Key? key,
    required this.child,
    this.begin = 0.5,
    this.end = 1,
    this.beginOffset = const Offset(0, 1),
    this.endOffset = Offset.zero,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  final double begin;
  final double end;
  final Duration duration;
  final Widget child;
  final Offset beginOffset;
  final Offset endOffset;

  @override
  State<ContinuousSlideFadeAnimation> createState() => _ContinuousFadeAnimationState();
}

class _ContinuousFadeAnimationState extends State<ContinuousSlideFadeAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideAnimation(
      slideBegin: widget.beginOffset,
      slideEnd: widget.endOffset,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: Tween<double>(
              begin: widget.begin,
              end: widget.end,
            ).animate(_controller).value,
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}
