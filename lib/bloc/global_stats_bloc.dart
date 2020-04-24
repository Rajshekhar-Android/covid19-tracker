import 'dart:async';

import 'package:covid_update/model/covid_stats_global.dart';
import 'package:covid_update/networking/api_response.dart';
import 'package:covid_update/repo/get_global_data_repo.dart';

class GlobalStatsBloc {
  GetGlobalDataRepo _globalStatsRepo;
  StreamController _globalStatController;

  StreamSink<Response<CovidStatsGlobal>> get chuckListSink =>
      _globalStatController.sink;

  Stream<Response<CovidStatsGlobal>> get chuckListStream =>
      _globalStatController.stream;

  GlobalStatsBloc() {
    _globalStatController = StreamController<Response<CovidStatsGlobal>>();
    _globalStatsRepo = GetGlobalDataRepo();
    fetchCategories();
  }

  fetchCategories() async {
    chuckListSink.add(Response.loading('Getting Global Data.'));
    try {
      CovidStatsGlobal chuckCats =
      await _globalStatsRepo.fetchGlobalStats();
      chuckListSink.add(Response.completed(chuckCats));
    } catch (e) {
      chuckListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _globalStatController?.close();
  }
}