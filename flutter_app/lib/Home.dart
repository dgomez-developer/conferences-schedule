import 'package:flutter/material.dart';
import 'package:flutter_app/ConferenceModel.dart';
import 'package:flutter_app/TalkMapper.dart';
import 'API.dart';
import 'ConferenceScheduleScreen.dart';
import 'MyScheduleScreen.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  ConferenceModel conference;
  int _currentIndex = 0;
  List<Widget> _children;

  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
//    return createBottomBar();
    return FutureBuilder(
      future: loadData(),
      builder: (BuildContext context, AsyncSnapshot<ConferenceModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
              backgroundColor: Colors.blue,
              body: Center(
                 child: CircularProgressIndicator(
                   backgroundColor: Colors.white,
                 ),
               )
          );
        } else {
          conference = snapshot.data;
          _children = new List<Widget>();
          for (var day in conference.days) {
            _children.add(new ConferenceScheduleScreen(
                key: UniqueKey(),
                day: day,
                conferenceName: conference.name,
                showOnlyOneTrack: day.tracks.length < 2));
          }
          return createBottomBar();
        }
      },
    );
  }

  Scaffold createBottomBar() {
    return Scaffold(
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: createTabs(),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.calendar_view_day),
        onPressed: pushMyAgenda,
      ),
    );
  }

  List<BottomNavigationBarItem> createTabs() {
    var tabs = new List<BottomNavigationBarItem>();
    for (var day in conference.days) {
      tabs.add(new BottomNavigationBarItem(
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

  void pushMyAgenda() async {
    var result = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(
          builder: (context) =>
              MyScheduleScreen(key: UniqueKey(), conferenceModel: conference)),
    );
    reloadData();
  }

  Future<ConferenceModel> loadData() {
    return API.getConference();
  }

  void reloadData() {
    API.getConference().then((onValue) {
      setState(() {
        conference = onValue;
        _children = new List<Widget>();
        for (var day in conference.days) {
          _children.add(new ConferenceScheduleScreen(
              key: UniqueKey(),
              day: day,
              conferenceName: conference.name,
              showOnlyOneTrack: day.tracks.length < 2));
        }
      });
    });
  }
}
