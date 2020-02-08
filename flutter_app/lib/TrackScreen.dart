import 'package:flutter/material.dart';
import 'package:flutter_app/ConferenceModel.dart';
import 'package:flutter_app/Storage.dart';

class TrackScreen extends StatefulWidget {
  final TrackModel track;
  final int dayId;
  final bool refresh;

  TrackScreen(
      {Key key,
      @required this.track,
      @required this.refresh,
      @required this.dayId})
      : super(key: key);

  @override
  createState() => _TrackScreenState(track: track, refresh: refresh, dayId: dayId);
}

class _TrackScreenState extends State {
  final TrackModel track;
  final int dayId;
  final bool refresh;

  _TrackScreenState(
      {@required this.track, @required this.refresh, @required this.dayId});

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
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Text(talk.speaker),
          ),
          Text(talk.startTime + " - " + talk.endTime),
          Divider()
        ],
      ),
      trailing: Opacity(
          opacity: (talk.speaker.isEmpty) ? 0.0 : 1.0,
          child: IconButton(
              icon: Icon((talk.isFavourite) ? Icons.star : Icons.star_border),
              onPressed: () {
                if (talk.isFavourite) {
                  Storage.removeTalk(dayId, talk).then((onValue){
                    setState(() {
                      talk.isFavourite = !talk.isFavourite;
                      if (refresh) {
                        talk.title = "";
                        talk.speaker = "";
                        talk.startTime = "";
                        talk.endTime = "";
                      }
                    });
                  });
                } else {
                  Storage.storeTalk(dayId, talk).then((onValue){
                    setState(() {
                      talk.isFavourite = !talk.isFavourite;
                    });
                  });
                }

              })),
    );

  }
}
