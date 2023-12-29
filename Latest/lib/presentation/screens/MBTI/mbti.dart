import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CheckMbtiPage(),
    );
  }
}

class CheckMbtiPage extends StatelessWidget {
  CheckMbtiPage({Key? key}) : super(key: key);

  final Uri _url = Uri.parse('https://www.16personalities.com/free-personality-test');


Future<void> _launchUrl(url) async {
  if (!await launchUrl(url)) {
    throw Exception('Could not launch $_url');
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(21, 179, 182, 1),
        title: const Text('Check MBTI'),
      ),
      body: Container(
        color: const Color.fromARGB(255, 195, 237, 238),
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.8,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'MBTI Test',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16.0),
                const Text(
                  'The MBTI test can assist students in choosing a career by providing insights into their personality preferences, strengths, and potential areas of interest. By understanding their personality type, students can identify careers that align with their natural inclinations and strengths, making it easier to make informed career choices that are more likely to lead to satisfaction and success in the long term.',
                  style: TextStyle(fontSize: 16.0),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    _launchUrl(_url);
                  },
                  child: const Text('Go to Personality Test'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }



}