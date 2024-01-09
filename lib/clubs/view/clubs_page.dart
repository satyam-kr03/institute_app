import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class ClubsPage extends StatelessWidget {
  const ClubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final clubData = <Map<String, dynamic>>[
    ];

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
          ElevatedButton(
            onPressed: () => context.go('/clubs/councils'),
            child: const Text('Councils'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/clubs/research'),
            child: const Text('Research Society'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/clubs/tech'),
            child: const Text('Technical Clubs'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/clubs/cult'),
            child: const Text('Cultural Clubs'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/clubs/lit'),
            child: const Text('Literary Clubs'),
          ),
          ElevatedButton(
            onPressed: () => context.go('/clubs/sports'),
            child: const Text('Sports Society'),
          ),

          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ...clubCards,
                ],
              ),
            ),
          ),
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

