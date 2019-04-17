import 'package:flutter/material.dart';

import '../utils/RequestStatus.dart';

class RequestStatusIndicator extends StatelessWidget {
  final RequestStatus _status;

  RequestStatusIndicator(this._status);

  Widget build(BuildContext context) {
    switch (_status) {
      case RequestStatus.waiting:
        return Text("Waiting...");
      case RequestStatus.inProgress:
        return Text("Loading");
      case RequestStatus.failure:
        return Text("Error!");
      case RequestStatus.success:
        return Text("Success.");
    }
    return null;
  }
}