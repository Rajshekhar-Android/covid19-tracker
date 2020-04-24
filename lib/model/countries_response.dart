import 'package:covid_update/model/country_data.dart';
import 'package:flutter/cupertino.dart';

class Countries {
  List<CountryData> results;
  Countries.fromJson(Map<String, dynamic> json) {
    results = new List<CountryData>();
    for (var jsonData in json.keys) {
      if (jsonData != "stat") {
        debugPrint("========json+"+json[jsonData].runtimeType.toString());

        results.add(new CountryData.fromJson(json[jsonData]));
      }
    }
  }

  Countries({this.results});



}
