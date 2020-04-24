class CountryData{
  String code;
  String source;
  String title;
  int total_active_cases;
  int total_cases;
  int total_deaths;
  int total_new_cases_today;
  int total_new_deaths_today;
  int total_recovered;
  int total_serious_cases;
  int total_unresolved;

  CountryData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    source = json['source'];
    title = json['title'];
    total_active_cases = json['total_active_cases'];
    total_cases = json['total_cases'];
    total_deaths = json['total_deaths'];
    total_new_cases_today = json['total_new_cases_today'];
    total_new_deaths_today = json['total_new_deaths_today'];
    total_recovered = json['total_recovered'];
    total_serious_cases = json['total_serious_cases'];
    total_unresolved = json['total_unresolved'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['source'] = this.source;
    data['title'] = this.title;
    data['total_active_cases'] = this.total_active_cases;
    data['total_cases'] = this.total_cases;
    data['total_deaths'] = this.total_deaths;
    data['total_new_cases_today'] = this.total_new_cases_today;
    data['total_new_deaths_today'] = this.total_new_deaths_today;
    data['total_recovered'] = this.total_recovered;
    data['total_serious_cases'] = this.total_serious_cases;
    data['total_unresolved'] = this.total_unresolved;
    return data;
  }
}