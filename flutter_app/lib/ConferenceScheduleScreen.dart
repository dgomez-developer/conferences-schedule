import 'package:flutter/material.dart';
import 'package:flutter_app/ConferenceModel.dart';

import 'TrackScreen.dart';

class ConferenceScheduleScreen extends StatefulWidget {
  ConferenceDayModel day;

  ConferenceScheduleScreen({Key key, @required this.day}) : super(key: key);

  @override
  createState() => _ConferencesScheduleScreenState(conference: day);
}

class _ConferencesScheduleScreenState extends State {
  ConferenceDayModel conference;

  _ConferencesScheduleScreenState({@required this.conference});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: conference.tracks.length,
        child: Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: createTabs(),
            ),
          ),
          body: TabBarView(
            children: createTabViews(),
          ),
        ));
  }

  List<Widget> createTabs() {
    var tabs = new List<Widget>();
    for (var track in conference.tracks) {
      tabs.add(Text(track.name));
    }
    return tabs;
  }

  List<Widget> createTabViews() {
    var tabViews = new List<Widget>();
    for (var track in conference.tracks) {
      tabViews.add(TrackScreen(track: track));
    }
    return tabViews;
  }
}
