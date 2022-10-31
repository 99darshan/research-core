import 'package:flutter/material.dart';
import 'package:researchcore/utils/theme_util.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  Future<void> _launchUrl(String url) async {
    Uri parsedUrl = Uri.parse(url);
    if (!await launchUrl(parsedUrl)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About',
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Powered By card
          Expanded(
            flex: 1,
            child: Card(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
              elevation: 2.0,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  //crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                        top: 32.0,
                        bottom: 0.0,
                      ),
                      child: Image.asset(
                        'assets/images/core-ac-logo.png',
                        height: MediaQuery.of(context).size.height * 0.10,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Powered By',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          TextButton(
                            onPressed: () {
                              _launchUrl('https://core.ac.uk/');
                            },
                            child: Text(
                              'Core.ac.uk',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: ThemeUtil.primaryColor),
                            ),
                          ),
                          Text(
                            "Research core is an open sourced app developed with the aim to ease the search for open access research papers. \n \n All the data in the this app are retrieved from core.ac.uk. Core is the world’s largest collection of open access research papers. ",
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1,
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          // Designed By Card
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4.0),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            elevation: 2.0,
            child: Container(
              padding: const EdgeInsets.all(16.0),
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                          text: "Developed By \n",
                          style: Theme.of(context).textTheme.headline6),
                      TextSpan(
                        text: "99darshan ",
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          _launchUrl(
                              'https://github.com/99darshan/research-core');
                        },
                        child: const Text('Github'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _launchUrl('https://twitter.com/99darshan');
                        },
                        child: const Text('Twitter'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _launchUrl('https://www.linkedin.com/in/99darshan/');
                        },
                        child: const Text('LinkedIn'),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
