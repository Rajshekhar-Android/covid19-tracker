import 'package:covid_update/model/countrytimeline.dart';
import 'package:covid_update/networking/api_provider.dart';

class CountryTimeLineRepo{
  var _provider = ApiProvider();

  Future<CountryTimeLine> fetchGlobalStats(String countryCode) async {
    final response = await _provider.get("countryTimeline="+countryCode);
    var rows = response["timelineitems"];
    var countryRow = rows[0];
    Map<String, dynamic> decoded = countryRow;
    return CountryTimeLine.fromJson(decoded);
  }
}