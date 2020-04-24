
class Info {

  String source;

	Info.fromJsonMap(Map<String, dynamic> map): 
		source = map["source"];

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['source'] = source;
		return data;
	}
}
