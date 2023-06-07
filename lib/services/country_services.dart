import 'dart:convert';

import 'package:covid_tracker/services/utilities/app_url.dart';

import 'package:http/http.dart'as http;

class CountryServices{

Future<List<dynamic>> countriesListApi() async{
  var data;
  final response = await http.get(Uri.parse(AppUrl.countriesList));

  if(response.statusCode == 200){
    data = jsonDecode(response.body);
    return data;
  }
  else{
     throw Exception('Error in fetching Countries List');
    // if (kDebugMode) {
    //   print("nothing found");
    // }
    // return [];
  }

}

}