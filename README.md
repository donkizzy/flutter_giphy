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

## Flutter Giphy

<a href="https://opensource.org/licenses/MIT">  
    <img src="https://img.shields.io/badge/License-MIT-red.svg"  
      alt="License: MIT" />  
  </a>

Fetch,Search and Share Gifs from Giphy in your Flutter app.

## Features

- Show Gif Picker
- Search Gifs
- Full control over the Gif Picker look and feel
- Support for building Custom UI for the Gif Picker

## Getting started

### 1. Depend on it

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  flutter_giphy: latest-version
```

### 2. Install it

```dart
$ pub
get
```

## Usage

1.Import the package
First, you need to import the package into your Dart file:

```dart
import 'package:flutter_giphy/flutter_giphy.dart';
```

###1. Using the bottomSheet

To use the bottomSheet widget in your app, you need to call the showGifPicker method: This method
requires a BuildContext and a Giphy API key. It also has optional parameters for customizing the
search bar, loading widget, error widget, and the background color of the bottom sheet so that you
can customize the bottom sheet to match your UI.

To handle the selected gif, you need to pass a callback function to the showGifPicker method. This
callback function will be called when the user selects a gif.

```dart
FlutterGiphy.showGifPicker
(
context: context,
apikey: 'your_giphy_api_key',
onSelected: (GiphyData gif) {
// Handle the selected gif here
},
);
```

### 2. Clear Search

You can clear the search input and reset the gif picker to the trending view using the clearSearch
method.

```dart
FlutterGiphy.clearSearch
();
```

```dart
 FlutterGiphy.showGifPicker
(
context: context,
searchBarDecoration: InputDecoration(
hintText: 'Search Gif',
prefixIcon: const Icon(
Icons.search,
color: Colors.white,
),
border: const OutlineInputBorder(
borderRadius: BorderRadius.all(Radius.circular(5)),
),
suffixIcon: InkWell(
onTap: () {
FlutterGiphy.clearSearch();
},
child: const Icon(
Icons.clear,
color: Colors.black,
)),
),
apikey: 'your_giphy_api_key',
onSelected: (GiphyData value) {
setState(() {
selectedGif = value;
});
});
```

Please replace 'your_giphy_api_key' with your actual Giphy API key.

## Fetching GIFs with Giphy class

The `Giphy` class provides methods to fetch GIFs from the Giphy API. Here's how you can use it:

### 1. Initialize the Giphy class

You need to initialize the Giphy class with your Giphy API key

```dart

Giphy giphy = Giphy(apiKey: 'your_giphy_api_key', language: GiphyLanguage.English);
```

language is an optional paramater thats allowes changing the requests lanaguage, here is a list of
languages supported [here](https://developers.giphy.com/docs/optional-settings/#language-support)

Please replace 'your_giphy_api_key' with your actual Giphy API key.

### 2. Fetch GIFs

You can fetch trending GIFs using the `fetchTrendingGif` anmd `searchGif` method:

`offset` Specifies the starting position of the results.
Default: “0”
Maximum: “4999”

```dart

var trendingGifs = await
giphy.fetchTrendingGif
(
offset
:
0
);
```

This method returns a GiphyResponse object that contains a list of GiphyData objects. Each GiphyData
object represents a GIF.

### 3. Display the GIFs

You can display the fetched GIFs in your Flutter app. Here's an example of how to display the GIFs
in a GridView:

```dart
 void fetchTrendingGif() async {
  Giphy rawGiphy = Giphy(apiKey: 'your_giphy_api_key');
  var trendingGifs = await rawGiphy.fetchTrendingGif(offset: 0);
  setState(() {
    fetchTrendingGifs.addAll(trendingGifs.data ?? []);
  });
}


GridView.builder
(
itemCount: trendingGifs.data.length,
itemBuilder: (context, index) {
return Image.network(trendingGifs.data[index].images.original.url);
},
gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
);
```

This will create a grid view with 2 columns that displays the trending GIFs.

### 4. Error Handling

If there's an error while fetching the GIFs, the fetchTrendingGif method will throw an exception.
You should catch and handle this exception:

```dart
try {
var trendingGifs = await giphy.fetchTrendingGif(offset: 0);
} catch (e) {
print('Failed to fetch GIFs: $e');
}
```

This will print an error message if there's an error while fetching the GIFs.

## Additional information

TODO: Tell users more about the package: where to find more information, how to
contribute to the package, how to file issues, what response they can expect
from the package authors, and more.
