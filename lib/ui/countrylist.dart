import 'package:covid_update/bloc/county_list_bloc.dart';
import 'package:covid_update/model/countries_response.dart';
import 'package:covid_update/networking/api_response.dart';
import 'package:covid_update/ui/country_item_row.dart';
import 'package:covid_update/ui/error.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';

import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'loadin.dart';

class CountryList extends StatefulWidget {
  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  CountryListBloc _bloc;

  @override
  void initState() {
    _bloc = CountryListBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CountryList"),

      ),
      body: StreamBuilder<Response<Countries>>(
          stream: _bloc.chuckListStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              switch (snapshot.data.status) {
                case Status.LOADING:
                  return Loading(loadingMessage: snapshot.data.message);
                  break;
                case Status.COMPLETED:
                  return CountryItemRow(countryListData: snapshot.data.data.results, );
                  break;
                case Status.ERROR:
                  debugPrint("====ERROR");

                  return Error(loadingMessage: "Error");
                  break;
              }
            }
            return Container();
          })
      ,
    );
  }


  @override
  void didUpdateWidget(CountryList oldWidget) {
    _bloc.dispose();
    super.didUpdateWidget(oldWidget);
  }



}
