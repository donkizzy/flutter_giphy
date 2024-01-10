
import 'package:flutter/material.dart';
import 'package:flutter_giphy/flutter_giphy.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: MaterialButton(
          onPressed: (){
            FlutterGiphy.showGifPicker(context: context,apikey: 'YOUR_API_KEY');
          },
          child: const Text('Open Modal'),
        )
      ),
    );
  }
}
