import 'dart:convert';

import 'package:covid_tracker/models/world_states_model.dart';
import 'package:covid_tracker/services/utilities/app_url.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart'as http;

class StateServices{

Future<WorldStateModel> fetchWorldStatesRecord() async{
  final response = await http.get(Uri.parse(AppUrl.worldStatesApi));

  if(response.statusCode == 200){
    var data = jsonDecode(response.body);
    return WorldStateModel.fromJson(data);
  }
  else{
    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

     throw Exception('Error in fetching world states');

    //  return WorldStateModel();
    
  }

}

}