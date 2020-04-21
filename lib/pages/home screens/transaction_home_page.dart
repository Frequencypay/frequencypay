import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TransactionHomePage extends StatefulWidget {

  final DocumentSnapshot userInfo;
  final String uid;

  TransactionHomePage({this.userInfo, this.uid});

  @override
  _TransactionHomePageState createState() => _TransactionHomePageState();
}

class _TransactionHomePageState extends State<TransactionHomePage> {
  @override
  Widget build(BuildContext context) {

    return Center(
        child: Column(children: <Widget>[
          Container(
              child: Expanded(
                  flex: 1,
                  child: Container(
                      child: Column(children: <Widget>[
                        Container(child: Expanded(flex: 1, child: BuildDonutChart())),
                        Divider(thickness: 5)
                      ])))),
          Container(
              child: Expanded(
                  flex: 1,
                  child: ListView(children: <Widget>[
                    BuildTransactionItem(),
                    BuildTransactionItem(),
                    BuildTransactionItem(),
                    BuildTransactionItem(),
                    BuildTransactionItem()
                  ])))
        ]));
  }
}

Widget BuildDonutChart() {
  return Center(
      child: Stack(children: <Widget>[
        Column(children: <Widget>[
          Container(
              child: Expanded(flex: 7, child: DonutPieChart.withSampleData())),
          Container(child: Expanded(flex: 1, child: Container()))
        ]),
        Center(
            child: Column(children: <Widget>[
              Container(
                  child: Expanded(
                      flex: 7,
                      child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white)))),
              Container(child: Expanded(flex: 1, child: Container()))
            ])),
        Center(
            child: Column(children: <Widget>[
              Spacer(flex: 4),
              Container(child: Expanded(flex: 3, child: Text("00%", style: TextStyle(fontSize: 50, color: Colors.blue[800])))),
              Container(child: Expanded(flex: 1, child: Text("Progress", style: TextStyle(fontSize: 15, color: Colors.grey[600])))),
              Spacer(flex: 4),
              Container(child: Expanded(flex: 1, child: Text("Pay Off Date:", style: TextStyle(fontWeight: FontWeight.bold)))),
              Container(child: Expanded(flex: 1, child: Text("X/XX/XXXX"))),
            ]))
      ]));
}

Widget BuildTransactionItem() {
  return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: <Widget>[
          Container(child: Expanded(flex: 1, child: CircleAvatar(radius: 30))),
          Container(
              child: Expanded(
                  flex: 3,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 15),
                        Text("<Message>",
                            style: TextStyle(color: Colors.grey[700])),
                        SizedBox(height: 15),
                        Icon(Icons.person, color: Colors.grey[700])
                      ]))),
          Container(
              child: Expanded(
                  flex: 1,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("\$20", style: TextStyle(color: Colors.green)),
                        SizedBox(height: 25)
                      ])))
        ]),
      ));
}

class DonutPieChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DonutPieChart(this.seriesList, {this.animate});

  /// Creates a [PieChart] with sample data and no transition.
  factory DonutPieChart.withSampleData() {
    return new DonutPieChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.PieChart(seriesList,
        animate: animate,
        // Configure the width of the pie slices to 60px. The remaining space in
        // the chart will be left as a hole in the center.
        defaultRenderer: new charts.ArcRendererConfig(arcWidth: 60));
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final data = [
      new LinearSales(0, 100),
      new LinearSales(1, 75),
      new LinearSales(2, 25),
      new LinearSales(3, 5),
    ];

    return [
      new charts.Series<LinearSales, int>(
        id: 'Sales',
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample linear data type.
class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
