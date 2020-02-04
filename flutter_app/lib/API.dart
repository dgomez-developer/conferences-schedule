import 'dart:convert';

import 'package:flutter_app/ConferenceModel.dart';
import 'package:http/http.dart' as http;

//const localhostUrl = "http://10.0.2.2:5000";
const localhostUrl = "https://api.myjson.com/bins/ew6cu";

class API {

  static Future<ConferenceModel> getConference() async {
//    var url = localhostUrl + "/api/t3chfest/schedule/2020";
    var url = localhostUrl;
    var response = await http.get(url);
    var jsonDecoded = json.decode(response.body);
    return ConferenceModel.fromJson(jsonDecoded);
  }
}
