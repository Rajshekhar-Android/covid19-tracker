import 'package:covid_update/model/countries_response.dart';
import 'package:covid_update/networking/api_provider.dart';

class CountryListRepo {
  var _provider = ApiProvider();
  Future<Countries> fetchGlobalStats() async {
    final response = await _provider.get("countryTotals=ALL");

    var rows = response["countryitems"];
    var countryRow = rows[0];
    Map<String, dynamic> decoded = countryRow;
    return Countries.fromJson(decoded);
  }
}
