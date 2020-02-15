import 'dart:convert';

import 'package:flutter_app/ConferenceModel.dart';
import 'package:flutter_app/Config.dart';
import 'package:http/http.dart' as http;

import 'TalkMapper.dart';

//const localhostUrl = "http://10.0.2.2:5000";

class API {
  static Future<ConferenceModel> getConference() async {
    var url = Config.endpoint;
    var response = await http.get(url);
    var jsonDecoded = json.decode(response.body);
    var conference = ConferenceModel.fromJson(jsonDecoded);
    await TalkMapper.markAsFavourite(conference);
    return conference;
  }
}
