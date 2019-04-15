import 'package:flutter/material.dart';

class FuturePlaceholder extends StatelessWidget {
  final Future _future;
  final Function _displayContent;
  FuturePlaceholder(this._future, this._displayContent);

  Widget _displayFuture(BuildContext context, AsyncSnapshot<void> snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return Text("You don't have a Future");
      case ConnectionState.active:
        return Text("Why am i a stream???");
      case ConnectionState.waiting:
        return Text("Loading...");
      case ConnectionState.done:
        return snapshot.hasError
            ? Text('Error: ${snapshot.error}')
            : _displayContent();
    }
    return null; // unreachable
  }

  @override
  Widget build(BuildContext context) =>
      FutureBuilder<void>(future: _future, builder: _displayFuture);
}
