import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:institute_app/clubs/clubs.dart';
import 'package:institute_app/feed/feed.dart';
import 'package:institute_app/profile/profile.dart';
import 'package:institute_app/domain/auth/models/auth_user.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:institute_app/data/auth/firebase_auth_repo.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  late List<Widget> _pages; // Declare _pages variable

  @override
  void initState() {
    super.initState();
    final FirebaseAuthRepo authRepo = FirebaseAuthRepo.instance();
    final GetData data = GetData(authRepo);
    _pages = [
      HomePageContent(getData: data),
      FeedPage(),
      ClubsPage(),
      ProfilePage(getData: data),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            _pages[_currentIndex],
          ],
        ),
        bottomNavigationBar: GNav(
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
    );
  }
}

class HomePageContent extends StatelessWidget {
  final GetData getData;
  HomePageContent({required this.getData});

  @override
  Widget build(BuildContext context) {
    AuthUser authUser = getData.authRepo.getSignedInUser().getOrElse(() => AuthUser(id: '', name: '', email: ''));
    return Column(
      children: [
        GreetingCard(name: '${authUser.name}'),
        Expanded(
          child: Center(
            child: Text('Home Page Content'),
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
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 50.0),
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
                'Welcome, $name !',
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

