import 'package:covid_update/bloc/global_stats_bloc.dart';
import 'package:covid_update/ui/countrylist.dart';
import 'package:covid_update/ui/global_state.dart';
import 'package:covid_update/ui/loadin.dart';
import 'package:covid_update/ui/error.dart';
import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'model/covid_stats_global.dart';
import 'networking/api_response.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GlobalStatsBloc _globalStatsBloc;

  @override
  void initState() {
    super.initState();
    _globalStatsBloc = GlobalStatsBloc();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff232d37),
        appBar: AppBar(
          title: Text("Covid19 Stats"),
        ),
        body: LiquidPullToRefresh(
            onRefresh: () => _globalStatsBloc.fetchCategories(),
            showChildOpacityTransition: true,
            child: ListView(
              children: <Widget>[
                StreamBuilder<Response<CovidStatsGlobal>>(
                    stream: _globalStatsBloc.chuckListStream,
                    builder: (context, snapshot) {
                      debugPrint(
                          "====LOADING::: " + snapshot.hasData.toString());

                      if (snapshot.hasData) {
                        switch (snapshot.data.status) {
                          case Status.LOADING:
                            debugPrint("====LOADING");
                            return Loading(
                                loadingMessage: snapshot.data.message);
                            break;
                          case Status.COMPLETED:
                            debugPrint("====COMPLETED" +
                                snapshot.data.data.results[0].totalCases
                                    .toString());

                            return GlobalStatsWidget(
                                response: snapshot.data.data.results[0]);

                            break;
                          case Status.ERROR:
                            debugPrint("====ERROR");

                            return Error(loadingMessage: "Error");
                            break;
                        }
                      }
                      return Center(
                        child: Container(
                          child: Text("No Data"),
                        ),
                      );
                    }),
              ],
            )),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom:50.0),
          child: FloatingActionButton.extended(

            label: Text("Visit Country"),
            onPressed: () {
              Navigator.push(context,  MaterialPageRoute(
                  builder: (context) => CountryList(

                  )),
              );
            },
            backgroundColor: Colors.red,
            icon: Icon(Icons.map),
          ),
        ));
  }

  @override
  void dispose() {
    _globalStatsBloc.dispose();
    super.dispose();
  }
}
