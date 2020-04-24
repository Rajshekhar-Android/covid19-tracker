import 'package:covid_update/model/country_data.dart';
import 'package:covid_update/ui/country_details.dart';
import 'package:flutter/material.dart';

class CountryItemRow extends StatefulWidget {
  final List<CountryData> countryListData;

  CountryItemRow({Key key, this.countryListData}) : super(key: key);
  @override
  _CountryItemRowState createState() => _CountryItemRowState();
}

class _CountryItemRowState extends State<CountryItemRow> {
  Icon _searchIcon = new Icon(Icons.search);
  List<CountryData> _filterdData = List<CountryData>();
  TextEditingController editingController = TextEditingController();


  @override
  void initState() {
    super.initState();

    _filterdData.addAll(widget.countryListData);
  }


  void filterSearchResults(String query) {
    List<CountryData> dummySearchList = List<CountryData>();
    dummySearchList.addAll(widget.countryListData);
    if(query.isNotEmpty) {
      List<CountryData> dummyListData = List<CountryData>();
      dummySearchList.forEach((item) {
        if(item.title.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _filterdData.clear();
        _filterdData.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _filterdData.clear();
        _filterdData.addAll(widget.countryListData);
      });
    }
  }

  Widget countryItemChild(CountryData countryData, int pos) {
    return InkWell(
      onTap: () =>
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      CountryDetails(
                          countryData: countryData))),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        height: 56,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ListTile(
          title: Text(countryData.title,
              style: TextStyle(color: Colors.white, fontSize: 22)),
        ),
        decoration: new BoxDecoration(
            color: pos % 2 == 0
                ? Colors.transparent
                : Color.fromARGB(10, 255, 255, 255)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff232d37),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                debugPrint("====value"+value);
                filterSearchResults(value);
              },
              autofocus: true,
              maxLines: 1,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.w300),
              controller: editingController,
              decoration: InputDecoration(
                  labelText: "",
                  labelStyle:TextStyle(color: Colors.red),
                  hintStyle: TextStyle(color: Colors.red),
                  hintText: "Search",


                  prefixIcon: Icon(Icons.search,color: Colors.red.shade400,),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filterdData.length,
                itemBuilder: (context, pos) {
                  return countryItemChild(_filterdData[pos], pos);
                }),
          ),
        ],
      ),
    );
  }
}

