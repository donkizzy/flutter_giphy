<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

TODO: Put a short description of the package here that helps potential users
know whether this package might be useful for them.

## Features

- Show Gif Picker

## Getting started

TODO: List prerequisites and provide or point to information on how to
start using the package.

## Usage

1. Import the package
   First, you need to import the package into your Dart file:

```dart
import 'package:flutter_giphy/flutter_giphy.dart';
```

2. Show the Gif Picker
    To show the Gif Picker, you need to call the showGifPicker method: This method requires a BuildContext and a Giphy API key. It also has optional parameters for customizing the search bar, loading widget, error widget, and the background color of the bottom sheet.

    ```dart
FlutterGiphy.showGifPicker(
context: context,
apikey: 'your_giphy_api_key',
);
    ```

3. Handle Selected Gift
    To handle the selected gif, you need to pass a callback function to the showGifPicker method. This callback function will be called when the user selects a gif.

    ```dart
FlutterGiphy.showGifPicker(
  context: context,
  apikey: 'your_giphy_api_key',
  onSelected: (GiphyData gif) {
    // Handle the selected gif here
  },
);
    ```

4. Clear Search  You can clear the search input and reset the gif picker to the trending view using the clearSearch method.  

    ```dart
FlutterGiphy.clearSearch();
    ```

Please replace 'your_giphy_api_key' with your actual Giphy API key.

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
