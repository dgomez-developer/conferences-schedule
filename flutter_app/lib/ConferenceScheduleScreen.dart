import 'package:flutter/material.dart';
import 'package:flutter_app/ConferenceModel.dart';

import 'TrackScreen.dart';

class ConferenceScheduleScreen extends StatefulWidget {

  final ConferenceDayModel day;
  final bool showOnlyOneTrack;

  ConferenceScheduleScreen({Key key, @required this.day, @required this.showOnlyOneTrack}) : super(key: key);

  @override
  createState() => _ConferencesScheduleScreenState(conference: day, showOnlyOneTrack: showOnlyOneTrack);
}

class _ConferencesScheduleScreenState extends State {

  final ConferenceDayModel conference;
  final bool showOnlyOneTrack;

  _ConferencesScheduleScreenState({@required this.conference, @required this.showOnlyOneTrack});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: conference.tracks.length, child: createScreen());
  }

  Scaffold createScreen() {
    if (showOnlyOneTrack) {
      return Scaffold(
          body: TabBarView(
        children: createTabViews(),
      ));
    } else {
      return Scaffold(
          appBar: AppBar(
            title: TabBar(
              tabs: createTabs(),
            ),
          ),
          body: TabBarView(
            children: createTabViews(),
          ));
    }
  }

  List<Widget> createTabs() {
    var tabs = new List<Widget>();
    for (var track in conference.tracks) {
      tabs.add(new Text(track.name));
    }
    return tabs;
  }

  List<Widget> createTabViews() {
    var tabViews = new List<Widget>();
    for (var track in conference.tracks) {
      tabViews.add(new TrackScreen(
          key: UniqueKey(), track: track, dayId: conference.dayId));
    }
    return tabViews;
  }
}
