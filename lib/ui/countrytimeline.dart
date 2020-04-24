import 'dart:math';

import 'package:covid_update/bloc/timelinebloc.dart';
import 'package:covid_update/model/country_data.dart';
import 'package:covid_update/model/countrytimeline.dart';
import 'package:covid_update/networking/api_response.dart';
import 'package:covid_update/ui/error.dart';
import 'package:covid_update/utils/graph_type.dart';
import 'package:covid_update/widget/custom_graph.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'loadin.dart';

class CountryTimeLineUi extends StatefulWidget {
  final CountryData countryData;

  const CountryTimeLineUi({Key key, this.countryData}) : super(key: key);

  @override
  _CountryTimeLineState createState() => _CountryTimeLineState();
}

class _CountryTimeLineState extends State<CountryTimeLineUi> {
  CountryTimeLineBloc _countryTimeLineBloc;

  @override
  void initState() {
    _countryTimeLineBloc = CountryTimeLineBloc(widget.countryData.code);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plot"),
      ),
      backgroundColor: Color(0xff232d37),
      body: SingleChildScrollView(
        child: StreamBuilder<Response<CountryTimeLine>>(
            stream: _countryTimeLineBloc.chuckListStream,
            builder: (context, snapshot) {
              debugPrint("====LOADING::: " + snapshot.hasData.toString());

              if (snapshot.hasData) {
                switch (snapshot.data.status) {
                  case Status.LOADING:
                    debugPrint("====LOADING");
                    return Loading(loadingMessage: snapshot.data.message);
                    break;
                  case Status.COMPLETED:
                    return Column(
                      children: <Widget>[

                        Row(
                          children: <Widget>[

                          Flexible(
                            flex: 1,
                            child: CustomGraph(
                              graphType: GraphType.totalCases,
                              dataSource: snapshot.data.data.results,
                              isShowBar: false,
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: CustomGraph(
                              graphType: GraphType.dailyCase,
                              dataSource: snapshot.data.data.results,
                              isShowBar: true,
                            ),
                          ),
                        ],),
                        Row(
                          children: <Widget>[
                            Flexible(
                              flex: 1,
                              child: CustomGraph(
                                graphType: GraphType.totalDeath,
                                dataSource: snapshot.data.data.results,
                                isShowBar: false,
                              ),
                            ),
                            Flexible(
                              flex: 1,
                              child: CustomGraph(
                                graphType: GraphType.dailydeath,
                                dataSource: snapshot.data.data.results,
                                isShowBar: true,
                              ),
                            ),


                          ],
                        ),
                        CustomGraph(
                            graphType: GraphType.totalRecovery,
                            dataSource: snapshot.data.data.results,
                            isShowBar: false,
                          ),



                      ],
                    );

                    break;
                  case Status.ERROR:
                    return Error(loadingMessage: "Error");
                    break;
                }
              }
              return Center(
                child: Container(
                  child: Text("No Data"),
                ),
              );
            }),
      ),
    );
  }

  Widget totalDeath(List<TimeLine> results) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        title: ChartTitle(
            text: 'Total Death Till Now',
            textStyle: ChartTextStyle(color: Colors.white)),
        //Chart title.
        legend: Legend(isVisible: false),
        // Enables the legend.
        tooltipBehavior: TooltipBehavior(enable: true),
        // Enables the tooltip.
        series: <LineSeries<TimeLine, String>>[
          LineSeries<TimeLine, String>(
              dataSource: results,
              xValueMapper: (TimeLine timline, _) => timline.date.toString(),
              yValueMapper: (TimeLine timline, _) => timline.totalDeath,
              dataLabelSettings:
                  DataLabelSettings(isVisible: false) // Enables the data label.
              )
        ]);
  }

  Widget totalDailyCases(List<TimeLine> results) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        title: ChartTitle(
            text: ' Daily bases cases Till Now',
            textStyle: ChartTextStyle(color: Colors.white)),
        palette: <Color>[
          Colors.green,
          Colors.greenAccent,
          Colors.lightGreenAccent,
        ],
        //Chart title.
        legend: Legend(isVisible: false),
        // Enables the legend.
        tooltipBehavior: TooltipBehavior(enable: true),
        // Enables the tooltip.
        series: <CartesianSeries<TimeLine, String>>[
          ColumnSeries<TimeLine, String>(
              dataSource: results,
              xValueMapper: (TimeLine timline, _) => timline.date.toString(),
              yValueMapper: (TimeLine timline, _) => timline.newDailyCases,
              dataLabelSettings:
                  DataLabelSettings(isVisible: false) // Enables the data label.
              )
        ]);
  }

  Widget newDailyDeath(List<TimeLine> results) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        title: ChartTitle(
            text: 'Daily Deaths Till Now',
            textStyle: ChartTextStyle(color: Colors.white)),
        //Chart title.
        legend: Legend(isVisible: false),
        // Enables the legend.
        tooltipBehavior: TooltipBehavior(enable: true),
        palette: <Color>[
          Colors.red,
          Colors.redAccent,
          Colors.red,
        ],
        // Enables the tooltip.
        series: <CartesianSeries<TimeLine, String>>[
          ColumnSeries<TimeLine, String>(
              dataSource: results,
              xValueMapper: (TimeLine timline, _) => timline.date.toString(),
              yValueMapper: (TimeLine timline, _) => timline.newDailyDeaths,
              dataLabelSettings:
                  DataLabelSettings(isVisible: false) // Enables the data label.
              )
        ]);
  }

  Widget totalCases(List<TimeLine> results) {
    return SfCartesianChart(
        primaryXAxis: CategoryAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          majorGridLines: MajorGridLines(width: 0),
        ),
        title: ChartTitle(
            text: 'Total Cases Till Now',
            textStyle: ChartTextStyle(color: Colors.white)),
        //Chart title.
        legend: Legend(isVisible: false),
        // Enables the legend.
        tooltipBehavior: TooltipBehavior(enable: true),
        // Enables the tooltip.
        series: <LineSeries<TimeLine, String>>[
          LineSeries<TimeLine, String>(
              dataSource: results,
              xValueMapper: (TimeLine timline, _) => timline.date.toString(),
              yValueMapper: (TimeLine timline, _) => timline.totalCases,
              dataLabelSettings: DataLabelSettings(
                  isVisible: false,
                  textStyle: ChartTextStyle(
                      color: Colors.white)) // Enables the data label.
              )
        ]);
  }
}
