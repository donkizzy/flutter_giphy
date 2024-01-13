import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_giphy/flutter_giphy.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
          child: MaterialButton(
        onPressed: () {
          FlutterGiphy.showGifPicker(
              context: context,
              searchBarDecoration: const InputDecoration(
                hintText: 'Search Gif',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              apikey: dotenv.env['API_KEY'] ?? '');
        },
        child: const Text('Open Modal'),
      )),
    );
  }
}
