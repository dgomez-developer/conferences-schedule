import 'package:flutter/material.dart';

import 'ConferenceModel.dart';
import 'ConferenceScheduleScreen.dart';
import 'Storage.dart';

class MyScheduleScreen extends StatefulWidget {
  final ConferenceModel conferenceModel;

  MyScheduleScreen({Key key, @required this.conferenceModel}) : super(key: key);

  @override
  createState() => _MyScheduleScreenState(conference: conferenceModel);
}

class _MyScheduleScreenState extends State {
  final ConferenceModel conference;
  ConferenceModel myConference;
  List<Widget> _children;
  int _currentIndex = 0;

  _MyScheduleScreenState({@required this.conference});

  initState() {
    super.initState();
    Storage.getMyTracks(conference).then((onValue) {
      setState(() {
        myConference = onValue;
        if (myConference == null) {
          return;
        }
        _children = new List<Widget>();
        for (var day in myConference.days) {
          _children.add(new ConferenceScheduleScreen(
              key: UniqueKey(), day: day, showOnlyOneTrack: true));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return createBottomBar();
  }

  Scaffold createBottomBar() {
    return (_children != null)
        ? Scaffold(
            appBar: AppBar(
              title: Text("my track"),
            ),
            body: _children[_currentIndex], // new
            bottomNavigationBar: BottomNavigationBar(
              onTap: onTabTapped, // new
              currentIndex: _currentIndex, // new
              items: createTabs(),
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text("my track"),
            ),
            body: Center(
              child: Text('Start creating your track'),
            ));
  }

  List<BottomNavigationBarItem> createTabs() {
    var tabs = new List<BottomNavigationBarItem>();
    for (var day in conference.days) {
      tabs.add(BottomNavigationBarItem(
        icon: Icon(Icons.calendar_today),
        title: Text(day.date),
      ));
    }
    return tabs;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
