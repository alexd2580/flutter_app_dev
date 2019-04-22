import 'dart:ui';

import 'package:flutter/material.dart';

import '../utils/function.dart';

class AnimatedFocus extends StatefulWidget {
  final List<WidgetBuilder> builders;
  final int indexFocused;
  AnimatedFocus({List<WidgetBuilder> builders, int indexFocused})
      : builders = builders,
        indexFocused = indexFocused;

  _AnimatedFocusState createState() => _AnimatedFocusState();
}

class _AnimatedFocusState extends State<AnimatedFocus>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  List<double> _oldHeight;
  List<double> _newHeight;

  double perUnfocused;

  void updatePerUnfocused() {
    perUnfocused = widget.indexFocused != null
        ? 0.2 / (widget.builders.length - 1)
        : 1.0 / widget.builders.length;
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    updatePerUnfocused();
    _oldHeight = List.filled(widget.builders.length, perUnfocused);
    _newHeight = List.of(_oldHeight);
    if (widget.indexFocused != null) {
      _oldHeight[widget.indexFocused] = 0.8;
    }
  }

  void didUpdateWidget(covariant AnimatedFocus old) {
    super.didUpdateWidget(old);

    updatePerUnfocused();
    for (var index = 0; index < _oldHeight.length; index++) {
      _oldHeight[index] =
          lerpDouble(_oldHeight[index], _newHeight[index], _controller.value);
      _newHeight[index] = index == widget.indexFocused ? 0.8 : perUnfocused;
    }
    _controller.reset();
    _controller.animateTo(1.0, curve: Curves.easeInOutCubic);
  }

  Function animationBuilder(BoxConstraints constraints) => (_, __) {
        final height = constraints.maxHeight;
        final factor = _controller.value;
        final children = mapWithIndex(widget.builders, (builder, index) {
          final fraction =
              lerpDouble(_oldHeight[index], _newHeight[index], factor);
          return SizedBox(
            height: height * fraction,
            child: builder(context),
          );
        });
        return Column(children: children);
      };

  Widget layoutBuilder(_, BoxConstraints constraints) => AnimatedBuilder(
      animation: _controller, builder: animationBuilder(constraints));

  @override
  Widget build(_) => LayoutBuilder(builder: layoutBuilder);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
