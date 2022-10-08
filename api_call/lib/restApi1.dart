import 'dart:convert';
import 'package:api_call/Models/post_model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

// ! Api Calling function

Future<List<PostModel>> getPostApi() async {
  print("get Api Function Called");
  const urlOfApi = 'https://jsonplaceholder.typicode.com/posts';
  final response = await http.get(Uri.parse(urlOfApi));
  final data = jsonDecode(response.body.toString());

  print(data);

  if (response.statusCode == 200) {
    allPosts.clear();
    for (Map i in data) {
      allPosts.add(PostModel.fromJson(i));
    }
    return allPosts;
  } else {
    return allPosts;
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

List<PostModel> allPosts = [];

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: const Text("Rest Api App"),
          ),
          body: const MainApiApp()),
    );
  }
}

class MainApiApp extends StatefulWidget {
  const MainApiApp({super.key});

  @override
  State<MainApiApp> createState() => _MainApiAppState();
}

class _MainApiAppState extends State<MainApiApp> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: FutureBuilder(
            future: getPostApi(),
            builder: (context, snapshot) {
              if (!(snapshot.hasData)) {
                return const Text("Loading...");
              } else {
                return ListView.builder(
                  itemCount: allPosts.length,
                  itemBuilder: ((context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Card(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              "Title",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(allPosts[index].title.toString()),
                            const Text(
                              "Description",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(allPosts[index].body.toString()),
                          ],
                        ),
                      ),
                    );
                  }),
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
