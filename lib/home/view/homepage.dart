// import 'package:flutter/material.dart';
// import 'package:fpdart/fpdart.dart' as fp;
// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:institute_app/clubs/clubs.dart';
// import 'package:institute_app/data/auth/firebase_auth_repo.dart';
// import 'package:institute_app/domain/auth/models/auth_user.dart';
// import 'package:institute_app/feed/feed.dart';
// import 'package:institute_app/profile/profile.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   static const routeName = '/';

//   @override
//   HomePageState createState() => HomePageState();
// }

// class HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   late List<Widget> _pages; // Declare _pages variable

//   @override
//   void initState() {
//     super.initState();
//     final authRepo = FirebaseAuthRepo.instance();
//     final data = GetData(authRepo);
//     _pages = [
//       HomePageContent(getData: data),
//       const FeedPage(),
//       const ClubsPage(),
//       ProfilePage(getData: data),
//     ];
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: Stack(
//           children: [
//             _pages[_currentIndex],
//           ],
//         ),
//         bottomNavigationBar: GNav(
//           backgroundColor: Colors.black,
//           color: Colors.white,
//           rippleColor: Colors.white,
//           activeColor: Colors.white,
//           tabBackgroundColor: Colors.grey.shade800,
//           gap: 5,
//           tabs: const [
//             GButton(
//               icon: Icons.home,
//               text: 'Home',
//             ),
//             GButton(
//               icon: Icons.feed,
//               text: 'Feed',
//             ),
//             GButton(
//               icon: Icons.groups,
//               text: 'Clubs',
//             ),
//             GButton(
//               icon: Icons.account_circle,
//               text: 'Profile',
//             ),
//           ],
//           selectedIndex: _currentIndex,
//           onTabChange: (index) {
//             setState(() {
//               _currentIndex = index;
//             });
//           },
//         ),
//       ),
//     );
//   }
// }

// class HomePageContent extends StatelessWidget {
//   const HomePageContent({required this.getData, super.key});
//   final GetData getData;

//   @override
//   Widget build(BuildContext context) {
//     final authUser = getData.authRepo.getSignedInUser().getOrElse(
//           () => AuthUser(id: '', name: '', email: ''),
//         );
//     return Column(
//       children: [
//         GreetingCard(name: authUser.name),
//         const Expanded(
//           child: Center(
//             child: Text('Home Page Content'),
//           ),
//         ),
//       ],
//     );
//   }
// }

// class GreetingCard extends StatelessWidget {
//   const GreetingCard({required this.name, super.key});
//   final String name;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 50),
//       child: Card(
//         elevation: 4,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(16),
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Welcome, $name !',
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
