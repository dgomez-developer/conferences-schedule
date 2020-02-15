import 'package:flutter/material.dart';
import 'package:flutter_app/ConferenceModel.dart';
import 'package:flutter_app/Config.dart';
import 'package:flutter_app/JumpingLogo.dart';
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

class _HomeState extends State<Home> with TickerProviderStateMixin {
  ConferenceModel conference;
  int _currentIndex = 0;
  List<Widget> _children;
  AnimationController animationController;
  Animation<double> animation;

  initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(milliseconds: 500), vsync: this);
    animation =
        Tween<double>(begin: 0.0, end: 100.0).animate(animationController)
          ..addListener(() {})
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed)
              animationController.reverse();
            if (status == AnimationStatus.dismissed) {
              animationController.forward();
            }
          });
    animationController.forward();
  }

  @override
  void dispose() {
    if (animationController != null) {
      animationController.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadData(),
      builder: (BuildContext context, AsyncSnapshot<ConferenceModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return (animationController != null)
              ? Scaffold(
                  backgroundColor: Config.theme,
                  body: Center(child: JumpingLogo(animation: animation)))
              : Scaffold(
                  appBar: AppBar(title: Text(conference.name)),
                  body: Center(
                    child:
                        CircularProgressIndicator(backgroundColor: Config.theme),
                  ));
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
          if (animationController != null) {
            animationController.dispose();
            animationController = null;
          }
          return createBottomBar();
        }
      },
    );
  }

  Scaffold createBottomBar() {
    return (conference.days.length > 1)
        ? Scaffold(
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
          )
        : Scaffold(
            body: _children[_currentIndex], // new
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
