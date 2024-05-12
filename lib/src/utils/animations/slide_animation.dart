import 'package:flutter/material.dart';

class SlideAnimation extends StatefulWidget {
  const SlideAnimation({
    Key? key,
    required this.child,
    this.slideBegin = const Offset(0, 1),
    this.slideEnd = Offset.zero,
    this.intervalStart = 0,
    this.intervalEnd = 1,
    this.duration = const Duration(milliseconds: 2000),
  }) : super(key: key);

  final Offset slideBegin;
  final Offset slideEnd;
  final Duration duration;
  final Widget child;
  final double intervalStart;
  final double intervalEnd;

  @override
  State<SlideAnimation> createState() => _SlideAnimationState();
}

class _SlideAnimationState extends State<SlideAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
            position: Tween<Offset>(
              begin: widget.slideBegin,
              end: widget.slideEnd,
            ).animate(CurvedAnimation(
              parent: _controller,
              curve: Interval(widget.intervalStart, widget.intervalEnd, curve: Curves.easeInOut),
            )),
            child: widget.child);
      },
    );
  }
}
