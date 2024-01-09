import 'package:flutter/material.dart';


class ClubsPage extends StatelessWidget {
  const ClubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Club data
    final clubData = <Map<String, dynamic>>[
      {
        'icon': Icons.code,
        'title': 'KamandPrompt',
        'subtitle': 'Programming Club',
      },
      {
        'icon': Icons.electric_bolt,
        'title': 'Robotronics',
        'subtitle': 'Robotics Club',
      },
      {
        'icon': Icons.music_note,
        'title': 'Music Society',
        'subtitle': 'Music Club',
      },
    ];

    // Map club data to ClubCard widgets
    final List<Widget> clubCards = clubData.map((data) {
      return ClubCard(
        icon: data['icon'] as IconData,
        title: data['title'] as String,
        subtitle: data['subtitle'] as String,
      );
    }).toList();

    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Clubs'),
          ),
          ...clubCards,
        ],
      ),
    );
  }
}

class ClubCard extends StatefulWidget {

  const ClubCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    super.key,
  });

  final IconData icon;
  final String title;
  final String subtitle;

  @override
  ClubCardState createState() => ClubCardState();
}

class ClubCardState extends State<ClubCard> {
  bool isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(widget.icon),
              title: Text(widget.title),
              subtitle: Text(widget.subtitle),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: Text(isSubscribed ? 'Subscribed' : 'Subscribe'),
                  onPressed: () {
                    setState(() {
                      isSubscribed = !isSubscribed;
                    });
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

