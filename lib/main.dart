import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'components/RequestStatusIndicator.dart';

import 'store/MoscowStations.dart';
import 'store/SensorData.dart';

import 'utils/RequestStatus.dart';
import 'utils/string.dart';
import 'utils/function.dart';

void main() => runApp(MultiProvider(
      providers: [
        Provider<MoscowStations>(value: MoscowStations()),
        // Provider<SensorData>(value: SensorData()),
      ],
      child: AppRoot(),
    ));

class AppRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Welcome to Flutter',
        home: SensorDataHome(),
      );
}

class StationListHome extends StatelessWidget {
  buildAppBody(context) {
    final moscowStations = Provider.of<MoscowStations>(context);
    return Observer(builder: (_) {
      switch (moscowStations.elementsRequestStatus) {
        case RequestStatus.success:
          return ElementListBody(moscowStations.elements);
        case RequestStatus.failure:
          return Text(moscowStations.loadingError);
        default:
          return RequestStatusIndicator(moscowStations.elementsRequestStatus);
      }
    });
  }

  buildActionButton(context) => FloatingActionButton(
        onPressed: Provider.of<MoscowStations>(context).queryStations,
        tooltip: 'Query Stations',
        child: Icon(Icons.file_download),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Welcome to Flutter')),
      body: Center(child: buildAppBody(context)),
      floatingActionButton: buildActionButton(context));
}

class SensorDataHome extends StatelessWidget {
  buildAppBody(context) => Text("lol");
//  {
//    final sensorData = Provider.of<SensorData>(context);
//    return Observer(
//      builder: (_) => Column(children: [
//            Text(sensorData.x.toString()),
//            Text(sensorData.y.toString()),
//            Text(sensorData.z.toString()),
//            Text(sensorData.measurements.toString())
//          ]),
//    );
//  }

//  buildAppBody() => RefreshGate(
//          500,
//          (context) =>
//              Column(children: [Text(DateTime.now().toIso8601String())]),
//          true),

//      builder: (context, child, model) =>

//      builder: (context, child, model) =>
//          model.elementsRequestStatus == RequestStatus.success
//              ? ElementListBody(model.elements)
//              : RequestStatusIndicator(model.elementsRequestStatus),
//      child: null);

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: Text('Accelerometer sensor data')),
      body: Center(child: buildAppBody(context)),
      floatingActionButton: FloatingActionButton(
        onPressed: /*Provider.of<SensorData>(context).*/startListening,
        tooltip: 'Start listening',
        child: Icon(Icons.file_download),
      ));
}

class ElementListBody extends StatefulWidget {
  final dynamic _elements;
  ElementListBody(this._elements);

  @override
  ElementListState createState() => ElementListState(_elements);
}

class ElementListState extends State<ElementListBody> {
  dynamic _elements;
  Map<int, bool> _opened = {};
  ElementListState(this._elements);

  @override
  Widget build(BuildContext context) {
    final makeHeaderBuilder = (element) =>
        (BuildContext context, bool isExpanded) => Text(
            utf8Decode(element["tags"]["name"]) +
                (isExpanded ? " Expanded" : " Closed"));

    final makeExpansionPanel = (element, index) => ExpansionPanel(
        headerBuilder: makeHeaderBuilder(element),
        body: Element(element),
        isExpanded: _opened[index] == true);

    final expandableList = ExpansionPanelList(
        children: mapWithIndex(_elements, makeExpansionPanel).toList(),
        expansionCallback: (int panelIndex, bool isExpanded) => setState(() {
              _opened[panelIndex] = !isExpanded;
            }));

    return ListView(children: [expandableList]);
  }
}

class Element extends StatelessWidget {
  final Map<String, dynamic> _element;
  Element(this._element);

  @override
  Widget build(BuildContext context) => Text(toPrettyString(_element));
}
