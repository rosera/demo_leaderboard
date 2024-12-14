import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;

Future<List<Item>> fetchItems() async {
  final response =
  await http.get(Uri.parse('http://localhost:8080/leaderboard?game=quizzrr'));
  await http.get(Uri.parse('https://quizzrr-glb-api-519033508888.us-central1.run.app/leaderboard?game=quizzrr'));

  print("Status: ${response.statusCode}");

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    return jsonList.map((item) => Item.fromJson(item)).toList();
  } else if (response.statusCode == 404){
    return [];
  } else {
    throw Exception('Failed to fetch items');
  }
}

class Item {
  final String game;
  final String name;
  final int score;

  const Item({
    required this.game,
    required this.name,
    required this.score,
  });

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      game: json['game'] as String,
      name: json['name'] as String,
      score: json['score'] as int,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late Future<List<Item>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = fetchItems();
  }

  Future<void> _refreshItems() async {
    setState(() {
      _itemsFuture = fetchItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Pass a code
    final Map<String, dynamic> params = ModalRoute.of(context)!.settings.arguments
    as Map<String, dynamic>;

    final code = params['param1'];
    final urlCode= params['param2'];

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // title: Text(widget.title),
        title: Text(code.toUpperCase()),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshItems,
        child: FutureBuilder<List<Item>>(
          future: _itemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final items = snapshot.data!;
              return Column(
                children: [
                  const Text("Pull up to refresh",
                    style: TextStyle(
                      fontSize: 18.0,
                     color: Colors.blueGrey,
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index) {
                        final item = items[index];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${index+1}.",
                                    style: const TextStyle(
                                      fontSize: 22.0,
                                    ),
                                  ),

                                  const SizedBox(width:10.0),

                                  Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontSize: 22.0,
                                    ),
                                  ),

                                  const Spacer(),
                                  Text(
                                    "${item.score}",
                                    style: const TextStyle(
                                      fontSize: 22.0,
                                    ),
                                  ),

                                ],

                                // Text('Game: ${item.game}, Score: ${item.score}'),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
