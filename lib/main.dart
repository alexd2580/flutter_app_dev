import 'package:flutter/material.dart';
import 'OverpassModel.dart';
import 'SensorDataModel.dart';
import 'RefreshGate.dart';
import 'utils.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  final stationsModel = MoscowStationsModel();
  final withStations =
      ScopedModel<MoscowStationsModel>(model: stationsModel, child: AppRoot());
  final sensorDataModel = SensorDataModel();
  final withSensors =
      ScopedModel<SensorDataModel>(model: sensorDataModel, child: withStations);
  runApp(withSensors);
}

class AppRoot extends StatelessWidget {
  buildAppBody() => ScopedModelDescendant<SensorDataModel>(
      builder: (context, child, model) => RefreshGate(
          500,
          (context) =>
              Column(children: [Text(DateTime.now().toIso8601String())]),
          true),
//      builder: (context, child, model) => Column(children: [Text(model.x.toString()), Text(model.y.toString()), Text(model.z.toString()), Text(model.measurements.toString())]),

//      builder: (context, child, model) =>
//          model.elementsRequestStatus == RequestStatus.success
//              ? ElementListBody(model.elements)
//              : RequestStatusIndicator(model.elementsRequestStatus),
      child: null);

  buildActionButton(context) => FloatingActionButton(
        onPressed: ScopedModel.of<SensorDataModel>(context).startListening,
        tooltip: 'Query Stations',
        child: Icon(Icons.file_download),
      );

  buildHome(context) => Scaffold(
      appBar: AppBar(title: Text('Welcome to Flutter')),
      body: Center(child: buildAppBody()),
      floatingActionButton: buildActionButton(context));

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Welcome to Flutter',
        home: buildHome(context),
      );
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
