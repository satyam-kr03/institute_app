import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ResourcesGrid extends StatelessWidget {
  const ResourcesGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(8),
      sliver: SliverGrid.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        itemCount: resourceData.length,
        itemBuilder: (context, index) {
          final data = resourceData[index];
          return GridItem(
            data['title'] as String,
            data['icon'] as IconData,
            data['url'] as String,
          );
        },
      ),
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
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(8),
        onTap: () {
          launchUrl(Uri.parse(link));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(height: 8),
            Text(
              name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
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
    'url':
        'https://iitmandi.ac.in/academic_calendar/Annexure%20A-%20Academic%20Calender%20Jan%20June,%202024%20(Even).pdf',
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
