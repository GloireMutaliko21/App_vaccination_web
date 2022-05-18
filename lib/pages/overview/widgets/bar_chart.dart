/// Bar chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:v_connect_web/API/Sources/data_source.dart';
import 'package:v_connect_web/constants/style.dart';

class SimpleBarChart extends StatefulWidget {
  final seriesList;
  final animate;

  SimpleBarChart(this.seriesList, {this.animate});

  /// Creates a [BarChart] with sample data and no transition.
  factory SimpleBarChart.withSampleData() {
    return new SimpleBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  _SimpleBarChartState createState() => _SimpleBarChartState();

  /// Create one series with sample hard coded data.
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final data = [
      new OrdinalSales('1', 4),
      new OrdinalSales('2', 2),
      new OrdinalSales('3', 8),
      new OrdinalSales('4', 6),
      new OrdinalSales('5', 3),
      new OrdinalSales('6', 7),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Sales',
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(active.withOpacity(.9)),
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

// late var m1;
// late var m2;
// late var m3;
// late var m4;
// late var m5;
// late var m6;
List list2 = <dynamic>[];

class _SimpleBarChartState extends State<SimpleBarChart> {
  List list = <dynamic>[];

  Future<void> getStat() async {
    await DataSource.getInstance
        .getCurrentData(params: {"event": "FIND_STAT"}).then((data) {
      setState(() {
        list = data;
        print(list);
      });
    }).catchError((onError) {
      print(onError);
    });
  }

  @override
  void initState() {
    super.initState();
    getStat();
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      widget.seriesList,
      animate: widget.animate,
    );
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
