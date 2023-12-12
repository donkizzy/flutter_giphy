import 'package:flutter/material.dart';

/// Flutter Giphy makes it easy fou you be use Giphy in your flutter apps
class FlutterGiphy {
  void showGifPicker({required BuildContext context, InputDecoration? decoration}) {
    showBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      builder: (BuildContext context) {
        return Column(
          children: [
            TextFormField(
              decoration: decoration ??
                  InputDecoration(
                    hintText: 'Search Gif',
                    prefixIcon: Icon(
                      Icons.search,
                      color: Theme.of(context).iconTheme.color,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 10,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(5),
                  ),
                );
              },
             )
          ],
        );
      },
    );
  }
}
