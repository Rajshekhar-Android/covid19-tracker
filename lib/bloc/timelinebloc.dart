import 'dart:async';

import 'package:covid_update/model/countrytimeline.dart';
import 'package:covid_update/networking/api_response.dart';
import 'package:covid_update/repo/timelineerepo.dart';

class CountryTimeLineBloc{
  CountryTimeLineRepo _countryTimeLineRepo;
  StreamController _streamController;

  StreamSink<Response<CountryTimeLine>> get timeLineListSink =>
      _streamController.sink;

  Stream<Response<CountryTimeLine>> get chuckListStream =>
      _streamController.stream;

  CountryTimeLineBloc(String countyCode) {
    _streamController = StreamController<Response<CountryTimeLine>>();
    _countryTimeLineRepo = CountryTimeLineRepo();
    fetchTimeLine(countyCode);
  }
  fetchTimeLine(String countryCode) async {
    timeLineListSink.add(Response.loading('Getting Global Data.'));
    try {
      CountryTimeLine chuckCats =
      await _countryTimeLineRepo.fetchGlobalStats(countryCode);
      timeLineListSink.add(Response.completed(chuckCats));
    } catch (e) {
      timeLineListSink.add(Response.error(e.toString()));
      print(e);
    }
  }

  dispose() {
    _streamController?.close();
  }
}