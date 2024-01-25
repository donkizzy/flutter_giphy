import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_giphy/flutter_giphy.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GiphyData? selectedGift;
  List<GiphyData> fetchTrendingGifs = [];

  @override
  void initState() {
    fetchTrendingGif();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Column(children: [
        if (selectedGift != null)
          Image.network(selectedGift?.images?.original?.url ?? ''),
        Center(
            child: MaterialButton(
          onPressed: () {
            FlutterGiphy.showGifPicker(
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
                apikey: dotenv.env['API_KEY'] ?? '',
                onSelected: (GiphyData value) {
                  setState(() {
                    selectedGift = value;
                  });
                });
          },
          child: const Text('Open Modal'),
        )),
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: fetchTrendingGifs.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              return Image.network(
                  fetchTrendingGifs[index].images?.original?.url ?? '');
            },
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
                crossAxisCount: 2),
          ),
        )
      ]),
    );
  }

  void fetchTrendingGif() async {
    Giphy rawGiphy = Giphy(apiKey: dotenv.env['API_KEY'] ?? '');
    var trendingGifs = await rawGiphy.fetchTrendingGif(
      offset: 0,
    );
    setState(() {
      fetchTrendingGifs.addAll(trendingGifs.data ?? []);
    });
  }

  void showError(dynamic ex) {
    showMessage(ex.toString());
  }

  void showMessage(String text) {
    var alert = AlertDialog(content: Text(text), actions: <Widget>[
      TextButton(
          child: const Text('Ok'),
          onPressed: () {
            Navigator.pop(context);
          })
    ]);
    showDialog(context: context, builder: (BuildContext context) => alert);
  }
}
