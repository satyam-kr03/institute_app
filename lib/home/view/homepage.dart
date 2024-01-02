import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:institute_app/clubs/clubs.dart';
import 'package:institute_app/feed/feed.dart';
import 'package:institute_app/profile/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomePageContent(name: 'James'),
    FeedPage(),
    ClubsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            _pages[_currentIndex],
          ],
        ),
        bottomNavigationBar: //Container(
        //color: Colors.black,
        /*child:*/ //Padding(
        //padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          rippleColor: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 5,
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
            ),
            GButton(
              icon: Icons.feed,
              text: 'Feed',
            ),
            GButton(
              icon: Icons.groups,
              text: 'Clubs',
            ),
            GButton(
              icon: Icons.account_circle,
              text: 'Profile',
            ),
          ],
          selectedIndex: _currentIndex,
          onTabChange: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ),
      //),//
    );
    //);
  }
}

class HomePageContent extends StatelessWidget {
  final String name;

  HomePageContent({required this.name});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GreetingCard(name: name),
        Expanded(
          child: Center(
            child: Text('Grid UI to be implemented here'),
          ),
        ),
      ],
    );
  }
}

class GreetingCard extends StatelessWidget {
  final String name;

  GreetingCard({required this.name});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Container(
          padding: EdgeInsets.all(16.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome, $name!',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
