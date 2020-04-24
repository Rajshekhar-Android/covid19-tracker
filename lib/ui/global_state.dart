import 'package:covid_update/model/results.dart';
import 'package:covid_update/theme/color.dart';
import 'package:covid_update/utils/calculate_growth.dart';
import 'package:covid_update/widget/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GlobalStatsWidget extends StatelessWidget {
  final Results response;
  const GlobalStatsWidget({Key key, this.response}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return new SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          CustomCard(
            cardTitle: 'Total CASES',
            caseTitle: 'Total',
            currentData: response.totalCases,
            newData: response.totalNewCasesToday,
            percentChange: calculateGrowthPercentage(
                response.totalCases, response.totalNewCasesToday),
            icon: showGrowthIcon(
                response.totalCases, response.totalNewCasesToday),
            cardColor: CardColors.green,
            color: Colors.red,
          ),
          CustomCard(
            cardTitle: 'Recovered CASES',
            caseTitle: 'Recovered',
            currentData: response.totalRecovered,
            newData: 0,
            percentChange: calculateGrowthPercentage(
                response.totalRecovered, 0),
            cardColor: CardColors.blue,
            icon: Icon(
              Icons.arrow_upward,
              color: Colors.green,
            ),
            color: Colors.green,
          ),
          CustomCard(
            cardTitle: 'Death CASES',
            caseTitle: 'Death',
            currentData: response.totalDeaths,
            newData: response.totalNewDeathsToday,
            percentChange: calculateGrowthPercentage(
                response.totalDeaths, response.totalNewDeathsToday),
            cardColor: CardColors.red,
            icon: showGrowthIcon(
                response.totalDeaths, response.totalNewDeathsToday),
            color: Colors.red,
          ),
          CustomCard(
            cardTitle: 'Serious CASES',
            caseTitle: 'Serious',
            currentData: response.totalSeriousCases,
            newData: 0,
            percentChange:
                calculateGrowthPercentage(response.totalSeriousCases, 0),
            cardColor: CardColors.cyan,
            icon: showGrowthIcon(response.totalSeriousCases, 0),
            color: Colors.red,
          ),
        ],
      ),
    );
  }
}
