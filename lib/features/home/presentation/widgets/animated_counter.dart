import 'package:flutter/material.dart';

class AnimatedCounter extends ImplicitlyAnimatedWidget {
  final double value;
  final TextStyle? style;
  final int fractionDigits;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.style,
    this.fractionDigits = 0,
    super.duration = const Duration(milliseconds: 700),
    super.curve = Curves.easeOutCubic,
  });

  @override
  ImplicitlyAnimatedWidgetState<AnimatedCounter> createState() {
    return _AnimatedCounterState();
  }
}

class _AnimatedCounterState
    extends ImplicitlyAnimatedWidgetState<AnimatedCounter> {
  Tween<double>? _valueTween;

  @override
  Widget build(BuildContext context) {
    final value = _valueTween?.evaluate(animation) ?? widget.value;

    return Text(
      value.toStringAsFixed(widget.fractionDigits),
      style: widget.style,
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _valueTween = visitor(
      _valueTween,
      widget.value,
          (dynamic value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }
}