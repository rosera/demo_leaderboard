import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:core';
import 'model/item_model.dart';
import 'utility/fetch_data.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({super.key, required this.title});

  final String title;

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
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
      // TODO: Add ScrollConfiguration for Web Scroll
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          physics: const BouncingScrollPhysics(),
          dragDevices: {
            PointerDeviceKind.stylus,
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad
          },
        ),
        child: RefreshIndicator(
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
                    const Text("Pull down to refresh",
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
                                    SizedBox(
                                      width: 30,
                                      child: Text(
                                        "${index+1}.",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width:10.0),

                                    SizedBox(
                                      width: 250,
                                      child: Text(
                                        item.name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 22.0,
                                        ),
                                      ),
                                    ),

                                    const Spacer(),
                                    SizedBox(
                                      // width: 0,
                                      child: Text(
                                        "${item.score}",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontSize: 22.0,
                                        ),
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
      ),
    );
  }
}
