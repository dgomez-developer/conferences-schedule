import 'package:flutter/material.dart';
import 'package:flutter_app/ConferenceModel.dart';
import 'package:flutter_app/Storage.dart';

class TrackScreen extends StatefulWidget {

  TrackModel track;
  int dayId;

  TrackScreen({Key key, @required this.track, @required this.dayId})
      : super(key: key);

  @override
  createState() => _TrackScreenState(track: track, dayId: dayId);
}

class _TrackScreenState extends State {

  TrackModel track;
  int dayId;

  _TrackScreenState({@required this.track, @required this.dayId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: track.talks.length,
        itemBuilder: (context, index) {
          return createCard(track.talks[index]);
        },
      ),
    );
  }


  Widget createCard(TalkModel talk) {
    return ListTile(
      title: Text(talk.title),
      subtitle: Text(talk.speaker),
      trailing: IconButton(
          icon: Icon(Icons.star_border),
          onPressed: () {
            Storage.storeTalk(dayId, talk);
            setState(() {
              Icon(Icons.star);
            });
          }
      ),
    );
  }

}