import 'package:covid_update/model/countrytimeline.dart';
import 'package:covid_update/utils/graph_type.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class CustomGraph extends StatelessWidget {
  final GraphType graphType;
  final List<TimeLine> dataSource;
  final bool isShowBar;

  const CustomGraph({Key key, this.graphType, this.dataSource, this.isShowBar})
      : super(key: key);

  Widget plotGraph(List<TimeLine> dataSource, GraphType graph) {
    if (GraphType.dailyCase == graph) {}

    return SfCartesianChart(
        primaryXAxis: CategoryAxis(
            labelIntersectAction: AxisLabelIntersectAction.multipleRows,

            title: AxisTitle(
              text: setTitleXAxis(graph),
              textStyle: ChartTextStyle(
                  color: Colors.deepOrange,
                  fontFamily: 'Roboto',
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w300)),
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        title: ChartTitle(
            text: returnTitle(graph),
            textStyle: ChartTextStyle(color: Colors.white)),
        //Chart title.
        legend: Legend(isVisible: false),
        palette: returnColorList(graph),
        // Enables the legend.
        tooltipBehavior: TooltipBehavior(enable: true),
        // Enables the tooltip.
        series: isShowBar
            ? <CartesianSeries<TimeLine, String>>[
                ColumnSeries<TimeLine, String>(
                    dataSource: dataSource,
                    xValueMapper: (TimeLine timline, _) =>timline.date,
                    yValueMapper: (TimeLine timline, _) =>
                        returnYAxis(graph, timline),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: false,
                        textStyle: ChartTextStyle(
                            color: Colors.white)) // Enables the data label.
                    )
              ]
            : <LineSeries<TimeLine, String>>[
                LineSeries<TimeLine, String>(
                    dataSource: dataSource,
                    xValueMapper: (TimeLine timline, _) =>
                        timline.date.toString(),
                    yValueMapper: (TimeLine timline, _) =>
                        returnYAxis(graph, timline),
                    dataLabelSettings: DataLabelSettings(
                        isVisible: false,
                        textStyle: ChartTextStyle(
                            color: Colors.white)) // Enables the data label.
                    )
              ]);
  }

  int returnYAxis(GraphType graphType, TimeLine timeLine) {
    if (graphType == GraphType.totalCases) {
      return timeLine.totalCases;
    } else if (graphType == GraphType.totalDeath) {
      return timeLine.totalDeath;
    } else if (graphType == GraphType.dailyCase) {
      return timeLine.newDailyCases;
    }else if (graphType == GraphType.totalRecovery) {
      return timeLine.totalRecoveries;
    } else {
      return timeLine.newDailyDeaths;
    }
  }

  String returnTitle(GraphType graphType) {
    if (graphType == GraphType.totalCases) {
      return "Total Cases Till Now";
    } else if (graphType == GraphType.totalDeath) {
      return "Total Death Till Now";
    } else if (graphType == GraphType.dailyCase) {
      return "Daily Basis Case";
    }else if (graphType == GraphType.totalRecovery) {
      return "Total Recovered";
    } else {
      return "Daily Basis Death";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: plotGraph(dataSource, graphType),
    );
  }

  List<Color> returnColorList(GraphType graphType) {
    if (graphType == GraphType.totalCases) {
      return [
        Colors.green,
      ];
    } else if (graphType == GraphType.totalDeath) {
      return [
        Colors.red,
      ];
    } else if (graphType == GraphType.dailyCase) {
      return [
        Colors.green.shade200,
        Colors.greenAccent.shade400,
        Colors.green,
      ];
    }else if (graphType == GraphType.totalRecovery) {
      return [
        Colors.blue,
      ];
    } else {
      return [
        Colors.red.shade200,
        Colors.redAccent,
        Colors.red,
      ];
    }
  }




  String setTitleXAxis(GraphType graphType) {
    if (graphType == GraphType.totalCases) {
      return "Infected";
    } else if (graphType == GraphType.totalDeath) {
      return "Deaths";
    } else if (graphType == GraphType.dailyCase) {
      return "Infected";
    }
    else if (graphType == GraphType.totalRecovery) {
      return "Recoverd";
    }
    else {
      return "Deaths";
    }
  }
}


