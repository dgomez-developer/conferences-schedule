import 'dart:convert';

import 'package:flutter_app/ConferenceModel.dart';
import 'package:http/http.dart' as http;

import 'TalkMapper.dart';

//const localhostUrl = "http://10.0.2.2:5000";
const localhostUrl = "https://conferences-schedule-api.herokuapp.com/api/t3chfest/schedule/2020";
//const localhostUrl = "http://localhost:5000/api/t3chfest/schedule/2020";

class API {
  static Future<ConferenceModel> getConference() async {
//    var url = localhostUrl + "/api/t3chfest/schedule/2020";
    var url = localhostUrl;
    var response = await http.get(url);
    var jsonDecoded = json.decode(response.body);
    var conference = ConferenceModel.fromJson(jsonDecoded);
    await TalkMapper.markAsFavourite(conference);
    return conference;
  }
}
