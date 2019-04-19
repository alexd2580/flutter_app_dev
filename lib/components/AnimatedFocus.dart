import 'dart:ui';

import 'package:flutter/material.dart';

class AnimatedFocus extends StatefulWidget {
  final WidgetBuilder build1;
  final WidgetBuilder build2;
  final double height1;
  final double height2;
  AnimatedFocus(
      {build1: WidgetBuilder,
      build2: WidgetBuilder,
      height1: double,
      height2: double})
      : build1 = build1,
        build2 = build2,
        height1 = height1,
        height2 = height2;

  _AnimatedFocusState createState() => _AnimatedFocusState();
}

class _AnimatedFocusState extends State<AnimatedFocus>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  double _oldHeight1;
  double _oldHeight2;

  @override
  void initState() {
    print("state init");
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _oldHeight1 = widget.height1;
    _oldHeight2 = widget.height2;
  }

  void didUpdateWidget(covariant AnimatedFocus old) {
    super.didUpdateWidget(old);

    _oldHeight1 = lerpDouble(_oldHeight1, old.height1, _controller.value);
    _oldHeight2 = lerpDouble(_oldHeight2, old.height2, _controller.value);

    _controller.reset();
    _controller.animateTo(1.0, curve: Curves.easeInOutCubic);
  }

  Function animationBuilder(BoxConstraints constraints) => (_, __) {
        final height = constraints.maxHeight;
        final factor = _controller.value;
        final fraction1 = lerpDouble(_oldHeight1, widget.height1, factor);
        final fraction2 = lerpDouble(_oldHeight2, widget.height2, factor);
        return Column(children: [
          SizedBox(
            height: height * fraction1,
            child: widget.build1(context),
          ),
          SizedBox(
            height: height * fraction2,
            child: widget.build2(context),
          )
        ]);
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
