import 'dart:convert';
import 'dart:developer';
import 'dart:math';

import 'package:flutter_app/ConferenceModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Storage {

  static const CONFERENCE_KEY = "conference";

  static Future<ConferenceModel> getMyTracks(
      ConferenceModel conferenceModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    if (keys == null) {
      return null;
    }
    List<ConferenceDayModel> days = conferenceModel.days;
    List<ConferenceDayModel> myDays = new List<ConferenceDayModel>(days.length);
    for(var i = 0; i < myDays.length; i++){
      myDays[i] = new ConferenceDayModel(date: days[i].date, tracks: new List<TrackModel>());
    }
    for (var keyId in keys) {
      var talkJson = prefs.getString(keyId);
      if (talkJson == null) {
        continue;
      }
      var talk = TalkModel.fromJson(json.decode(talkJson));
      var dayId = keyId.split('-')[0];
      print(dayId);
      myDays[int.parse(dayId)-1].tracks[0].talks[talk.position] = talk;
    }

    return ConferenceModel(location: conferenceModel.location, name: conferenceModel.name, days: myDays );
  }


  static Future storeTalk(int dayId, TalkModel talk) async {
    print("Storing: " + talk.title);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String talkJson = jsonEncode(talk.toJson());
    prefs.setString(dayId.toString() + "-" + talk.startTime, talkJson);
  }

  static Future<TalkModel> getTalk(int dayId, String startTime) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String talkJson = prefs.getString(dayId.toString() + "-" + startTime);
    if (talkJson == null) {
      return null;
    }
    return TalkModel.fromJson(json.decode(talkJson));
  }

  static Future<TalkModel> getTalkById(String keyId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String talkJson = prefs.getString(keyId);
    if (talkJson == null) {
      return null;
    }
    return TalkModel.fromJson(json.decode(talkJson));
  }
}
