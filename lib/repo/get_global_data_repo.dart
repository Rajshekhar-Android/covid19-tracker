import 'package:covid_update/model/covid_stats_global.dart';
import 'package:covid_update/networking/api_provider.dart';

class GetGlobalDataRepo {
  var _provider = ApiProvider();

  Future<CovidStatsGlobal> fetchGlobalStats() async {
    final response = await _provider.get("global=stats");
    return CovidStatsGlobal.fromJson(response);
  }
}
