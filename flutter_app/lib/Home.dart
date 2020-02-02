import 'package:flutter/material.dart';
import 'package:flutter_app/ConferenceModel.dart';
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
    API.getConference().then((onValue) {
      setState(() {
        conference = onValue;
        _children = new List<Widget>();
        for(var day in conference.days){
          _children.add(ConferenceScheduleScreen(day: day));
        }
      });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return createBottomBar();
  }

  Scaffold createBottomBar() {
    return Scaffold(
      appBar: AppBar(
        title: Text(conference.name),
      ),
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

  List<BottomNavigationBarItem> createTabs(){
    var tabs = new List<BottomNavigationBarItem>();
    for(var day in conference.days){
      tabs.add(BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text(day.date),
        )
      );
    }
    return tabs;
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void pushMyAgenda() async {
    Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => MyScheduleScreen(conferenceModel: conference)),
    );
  }
}