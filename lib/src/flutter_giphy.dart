import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

/// Flutter Giphy makes it easy fou you be use Giphy in your flutter apps
class FlutterGiphy {

  static void showGifPicker(
      {required BuildContext context, InputDecoration? decoration,}) {
    showModalBottomSheet(
      context: context,
      constraints: BoxConstraints(
        maxHeight: MediaQuery
            .of(context)
            .size
            .height * 0.8,
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
                      color: Theme
                          .of(context)
                          .iconTheme
                          .color,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
            ),
            const SizedBox(height: 10,),
            Expanded(
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 20,
                      margin: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),

                    );
                  },
                ),
            ),
          ],
        );
      },
    );
  }
}
