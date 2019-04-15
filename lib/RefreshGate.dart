import 'dart:async';
import 'package:flutter/material.dart';

class RefreshGate extends StatefulWidget {
  final int _msecs;
  final Function _childBuilder;
  final bool _running;

  RefreshGate(this._msecs, this._childBuilder, [this._running]);

  @override
  createState() => RefreshGateState(_msecs, _childBuilder, _running);
}

class RefreshGateState extends State<RefreshGate> {
  Timer _timer;
  bool _running = false;

  final Function _childBuilder;

  RefreshGateState(int msecs, this._childBuilder, this._running) {
    _timer = Timer.periodic(Duration(milliseconds: msecs), _callback);
  }

  void _callback(Timer timer) {
    if (_running) {
      setState(() {
        //Refresh
      });
    }
  }

  @override
  Widget build(BuildContext context) => _childBuilder(context);
}

