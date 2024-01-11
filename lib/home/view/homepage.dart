import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Home'),
          ),
          const WelcomeCard(),
          const UpdatesCard(),
          const Padding(
            padding: EdgeInsets.fromLTRB(1, 20, 1, 1),
            child: Text('Explore Resources'
                , style: TextStyle(fontSize: 15) ),
          ),
          const Expanded(
            child: ResourcesGrid(),
          ),
        ],
      ),
    );
  }
}

class WelcomeCard extends StatelessWidget {
  const WelcomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.account_circle_rounded),
              title: Text('Welcome User'),
              subtitle: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}

class UpdatesCard extends StatelessWidget {
  const UpdatesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.calendar_today_rounded),
              title: Text('Upcoming'),
              subtitle: Text('No upcoming events'),
            ),
          ],
        ),
      ),
    );
  }
}

class ResourcesGrid extends StatelessWidget {
  const ResourcesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: resourceData.length,
      itemBuilder: (context, index) {
        final data = resourceData[index];
        return GridItem(data['title'] as String, data['icon'] as IconData, data['url'] as String);
      },
    );
  }
}

class GridItem extends StatelessWidget {
  const GridItem(this.name, this.icon, this.link, {super.key});
  final String name;
  final IconData icon;
  final String link;

  @override
  Widget build(BuildContext context) {
    final label = name;
    final iconData = icon;
    final url = link;

    return InkWell(
      onTap: () {
        launchUrl(Uri.parse(url));
      },
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(iconData, size: 24),
            const SizedBox(height: 8),
            Text(label),
          ],
        ),
      ),
    );
  }
}

final resourceData = <Map<String, dynamic>>[
  {
    'icon': Icons.domain,
    'title': 'OAS',
    'url': 'https://oas.iitmandi.ac.in/',
  },
  {
    'icon': Icons.school,
    'title': 'LMS',
    'url': 'https://lms.iitmandi.ac.in/',
  },
  {
    'icon': Icons.corporate_fare,
    'title': 'Insite',
    'url': 'https://insite.iitmandi.ac.in/',
  },
  {
    'icon': Icons.map,
    'title': 'Map',
    'url': 'https://maps.app.goo.gl/8yN6x44dmjtMk3bGA',
  },
  {
    'icon': Icons.date_range,
    'title': 'Calendar',
    'url': 'https://iitmandi.ac.in/academic_calendar/Annexure%20A-%20Academic%20Calender%20Jan%20June,%202024%20(Even).pdf',
  },
  {
    'icon': Icons.access_time,
    'title': 'Time Table',
    'url': 'https://www.iitmandi.ac.in/files/Timetable_Aug2023.pdf',
  },
  {
    'icon': Icons.book,
    'title': 'Library',
    'url': 'http://library.iitmandi.ac.in/',
  },
  {
    'icon': Icons.public,
    'title': 'SNTC',
    'url': 'https://iitmandi.co.in/',
  },
];
