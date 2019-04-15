import 'package:flutter/material.dart';

class TabbedView extends StatefulWidget {
  final Function _tabBuilder;
  TabbedView(self._tabBuilder);

  @override
  _TabbedViewState createState() => _TabbedViewState(_tabBuilder);
}

class _TabbedViewState extends State<TabbedView> with SingleTickerProviderStateMixin {
//  final List<Tab> myTabs = <Tab>[
//    Tab(text: 'LEFT'),
//    Tab(text: 'RIGHT'),
//  ];

  Function _tabBuilder;
  TabController _tabController;

//  @override
//  void initState() {
//    super.initState();
//    _tabController = TabController(vsync: this, length: myTabs.length);
//  }

//  @override
//  void dispose() {
//    _tabController.dispose();
//    super.dispose();
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Tab tab) {
          return Center(child: Text(tab.text));
        }).toList(),
      ),
    );
  }
}