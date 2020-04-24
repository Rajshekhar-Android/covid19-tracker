import 'package:covid_update/model/results.dart';

class CovidStatsGlobal {

	List<Results> results;
	String stat;

	CovidStatsGlobal({this.results, this.stat});

	CovidStatsGlobal.fromJson(Map<String, dynamic> json) {
		if (json['results'] != null) {
			results = new List<Results>();
			json['results'].forEach((v) {
				results.add(new Results.fromJson(v));
			});
		}
		stat = json['stat'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.results != null) {
			data['results'] = this.results.map((v) => v.toJson()).toList();
		}
		data['stat'] = this.stat;
		return data;
	}
}
