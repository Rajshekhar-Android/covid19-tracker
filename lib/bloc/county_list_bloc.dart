import 'dart:async';

import 'package:covid_update/model/countries_response.dart';
import 'package:covid_update/networking/api_response.dart';
import 'package:covid_update/repo/countrylist_repo.dart';

class CountryListBloc {
  CountryListRepo _globalStatsRepo;
  StreamController _globalStatController;

  StreamSink<Response<Countries>> get chuckListSink =>
      _globalStatController.sink;

  Stream<Response<Countries>> get chuckListStream =>
      _globalStatController.stream;

  CountryListBloc() {
    _globalStatController = StreamController<Response<Countries>>();
    _globalStatsRepo = CountryListRepo();
    fetchCategories();
  }

  fetchCategories() async {
    chuckListSink.add(Response.loading('Getting Global Data.'));
    try {
      Countries chuckCats =
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