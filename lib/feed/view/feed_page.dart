import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed Page'),
      ),
      body: _buildFeedList(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Add Feed Item'); // need to update this
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildFeedList(BuildContext context) {
    List<String> feedItems = [
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
              MaterialPageRoute(
                builder: (context) => FeedItemDetailsPage(feedItems[index]),
              ),
            );
          },
        );
      },
    );
  }
}

class FeedItemDetailsPage extends StatelessWidget {
  final String feedItem;

  FeedItemDetailsPage(this.feedItem);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Feed Item Details'),
      ),
      body: Center(
        child: Text(feedItem),
      ),
    );
  }
}
