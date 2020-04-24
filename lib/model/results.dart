import 'package:covid_update/model/source.dart';

class Results {

	int totalCases;
	int totalRecovered;
	int totalUnresolved;
	int totalDeaths;
	int totalNewCasesToday;
	int totalNewDeathsToday;
	int totalActiveCases;
	int totalSeriousCases;
	Source source;

	Results.fromJson(Map<String, dynamic> json) {
		totalCases = json['total_cases'];
		totalRecovered = json['total_recovered'];
		totalUnresolved = json['total_unresolved'];
		totalDeaths = json['total_deaths'];
		totalNewCasesToday = json['total_new_cases_today'];
		totalNewDeathsToday = json['total_new_deaths_today'];
		totalActiveCases = json['total_active_cases'];
		totalSeriousCases = json['total_serious_cases'];
		source =
		json['source'] != null ? new Source.fromJson(json['source']) : null;
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['total_cases'] = this.totalCases;
		data['total_recovered'] = this.totalRecovered;
		data['total_unresolved'] = this.totalUnresolved;
		data['total_deaths'] = this.totalDeaths;
		data['total_new_cases_today'] = this.totalNewCasesToday;
		data['total_new_deaths_today'] = this.totalNewDeathsToday;
		data['total_active_cases'] = this.totalActiveCases;
		data['total_serious_cases'] = this.totalSeriousCases;
		if (this.source != null) {
			data['source'] = this.source.toJson();
		}
		return data;
	}
}
