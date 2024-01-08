import 'package:about/about.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  const About({super.key});

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          MarkdownPageListTile(
            filename: 'README.md',
            title: Text('View Readme'),
            icon: Icon(Icons.all_inclusive),
          ),
          MarkdownPageListTile(
            filename: 'CHANGELOG.md',
            title: Text('View Changelog'),
            icon: Icon(Icons.view_list),
          ),
          MarkdownPageListTile(
            filename: 'LICENSE.md',
            title: Text('View License'),
            icon: Icon(Icons.description),
          ),
          MarkdownPageListTile(
            filename: 'CONTRIBUTING.md',
            title: Text('Contributing'),
            icon: Icon(Icons.share),
          ),
          MarkdownPageListTile(
            filename: 'CODE_OF_CONDUCT.md',
            title: Text('Code of conduct'),
            icon: Icon(Icons.sentiment_satisfied),
          ),
          LicensesPageListTile(
            title: Text('Open source Licenses'),
            icon: Icon(Icons.favorite),
          ),
        ]),
      ),
    );
  }
}
