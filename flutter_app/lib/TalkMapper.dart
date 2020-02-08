import 'package:flutter_app/ConferenceModel.dart';
import 'package:flutter_app/Storage.dart';

class TalkMapper {


  static Future<ConferenceModel> markAsFavourite(ConferenceModel fromServer) async {

    for(var i = 0; i < fromServer.days.length; i++){
      for(var track in fromServer.days[i].tracks){
        for(var talk in track.talks) {
          var storedTalk = await Storage.getTalkById(fromServer.days[i].dayId.toString() + "-" + talk.startTime);
          talk.isFavourite = storedTalk != null && talk.title == storedTalk.title && talk.speaker == storedTalk.speaker;
        }
      }
    }
    return fromServer;
  }


}