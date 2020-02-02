import 'dart:developer';

class ConferenceModel {
  String name;
  String location;
  List<ConferenceDayModel> days;

  ConferenceModel({this.name, this.location, this.days});

  factory ConferenceModel.fromJson(Map<String, dynamic> parsedJson) {
    return ConferenceModel(
        name: parsedJson['name'],
        location: parsedJson['location'],
        days: (parsedJson['days'] as List)
            .map((day) => ConferenceDayModel.fromJson(day))
            .toList());
  }
}

class ConferenceDayModel {
  String date;
  List<TrackModel> tracks;

  ConferenceDayModel({this.date, this.tracks});

  factory ConferenceDayModel.fromJson(Map<String, dynamic> parsedJson) {
    return ConferenceDayModel(
        date: parsedJson['date'],
        tracks: (parsedJson['tracks'] as List)
            .map((track) => TrackModel.fromJson(track))
            .toList());
  }

}

class TrackModel {
  String name;
  String location;
  List<TalkModel> talks;

  TrackModel({this.name, this.location, this.talks});

  factory TrackModel.fromJson(Map<String, dynamic> parsedJson) {
    log(parsedJson['name']);
    return TrackModel(
        name: parsedJson['name'],
        location: parsedJson['location'],
        talks: (parsedJson['talks'] as List)
            .map((talk) => TalkModel.fromJson(talk))
            .toList());
  }
}

class TalkModel {
  int position;
  String speaker;
  String speakerInfo;
  String title;
  String description;
  String startTime;
  String endTime;

  TalkModel(
      {this.position,
      this.speaker,
      this.speakerInfo,
      this.title,
      this.description,
      this.startTime,
      this.endTime});

  factory TalkModel.fromJson(Map<String, dynamic> parsedJson) {
    return TalkModel(
        position: parsedJson['position'],
        speaker: parsedJson['speaker'],
        speakerInfo: parsedJson['speakerInfo'],
        title: parsedJson['title'],
        description: parsedJson['description'],
        startTime: parsedJson['startTime'],
        endTime: parsedJson['endTime']);
  }

  Map<String, dynamic> toJson() => {
        'position': position,
        'speaker': speaker,
        'speakerInfo': speakerInfo,
        'title': title,
        'description': description,
        'startTime': startTime,
        'endTime': endTime,
      };
}
