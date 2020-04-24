import 'package:flutter/cupertino.dart';

class CountryTimeLine {
  List<TimeLine> results;

  CountryTimeLine.fromJson(Map<String, dynamic> json) {
    results = new List<TimeLine>();
    for (var jsonData in json.keys) {
      if (jsonData != "stat") {
        json[jsonData]["date"]=jsonData.toString();
        results.add(new TimeLine.fromJson(json[jsonData]));
      }
    }
  }

  CountryTimeLine({this.results});
}

class TimeLine {
  int newDailyCases;
  int newDailyDeaths;
  int totalCases;
  int totalDeath;
  int totalRecoveries;
  String date;

  TimeLine.fromJson(Map<String, dynamic> json) {
    newDailyCases = json['new_daily_cases'];
    newDailyDeaths = json['new_daily_deaths'];
    totalCases = json['total_cases'];
    totalDeath = json['total_deaths'];
    totalRecoveries = json['total_recoveries'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['new_daily_cases'] = this.newDailyCases;
    data['new_daily_deaths'] = this.newDailyDeaths;
    data['total_cases'] = this.totalCases;
    data['total_deaths'] = this.totalDeath;
    data['total_recoveries'] = this.totalRecoveries;
    data['date'] = this.date;

    return data;
  }
}
