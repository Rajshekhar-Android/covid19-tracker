import 'package:covid_update/model/country_data.dart';
import 'package:covid_update/theme/color.dart';
import 'package:covid_update/ui/countrytimeline.dart';
import 'package:covid_update/utils/calculate_growth.dart';
import 'package:covid_update/widget/custom_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryDetails extends StatefulWidget {
  final CountryData countryData;

  const CountryDetails({Key key, this.countryData}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CountryDetailState();
  }
}

class CountryDetailState extends State<CountryDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          widget.countryData.title,
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              CustomCard(
                cardTitle: 'Total CASES',
                caseTitle: 'Total',
                currentData: widget.countryData.total_cases,
                newData: widget.countryData.total_new_cases_today,
                percentChange: calculateGrowthPercentage(
                    widget.countryData.total_cases,
                    widget.countryData.total_new_cases_today),
                icon: showGrowthIcon(widget.countryData.total_cases,
                    widget.countryData.total_new_cases_today),
                cardColor: CardColors.green,
                color: Colors.red,
              ),
              CustomCard(
                cardTitle: 'Recovered CASES',
                caseTitle: 'Recovered',
                currentData: widget.countryData.total_recovered,
                newData: widget.countryData.total_recovered -
                    widget.countryData.total_recovered,
                percentChange: calculateGrowthPercentage(
                    widget.countryData.total_recovered,
                    widget.countryData.total_recovered -
                        widget.countryData.total_recovered),
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
                currentData: widget.countryData.total_deaths,
                newData: widget.countryData.total_new_deaths_today,
                percentChange: calculateGrowthPercentage(
                    widget.countryData.total_deaths,
                    widget.countryData.total_new_deaths_today),
                cardColor: CardColors.red,
                icon: showGrowthIcon(widget.countryData.total_deaths,
                    widget.countryData.total_new_deaths_today),
                color: Colors.red,
              ),
              CustomCard(
                cardTitle: 'Serious CASES',
                caseTitle: 'Serious',
                currentData: widget.countryData.total_serious_cases,
                newData: 0,
                percentChange: calculateGrowthPercentage(
                    widget.countryData.total_serious_cases, 0),
                cardColor: CardColors.cyan,
                icon: showGrowthIcon(widget.countryData.total_deaths, 0),
                color: Colors.red,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Plot"),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CountryTimeLineUi(countryData: widget.countryData)),
          );
        },
        icon: Icon(Icons.scatter_plot),
      ),

    );
  }
}
