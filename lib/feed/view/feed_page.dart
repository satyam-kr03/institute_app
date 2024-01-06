import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  const FeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Page'),
      ),
      body: _buildFeedList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (kDebugMode) {
            print('Add Feed Item');
          } // need to update this
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildFeedList(BuildContext context) {
    final feedItems = <String>[
      'Feed Item 1',
      'Feed Item 2',
      'Feed Item 3',
    ];

    return ListView.builder(
      itemCount: feedItems.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(feedItems[index]),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) =>
                    FeedItemDetailsPage(feedItems[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class FeedItemDetailsPage extends StatelessWidget {
  const FeedItemDetailsPage(this.feedItem, {super.key});
  final String feedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed Item Details'),
      ),
      body: Center(
        child: Text(feedItem),
      ),
    );
  }
}
