import 'dart:convert';

import 'package:api_call/Models/post_model/photos_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class PhotoApiScreen extends StatefulWidget {
  const PhotoApiScreen({super.key});

  @override
  State<PhotoApiScreen> createState() => _PhotoApiScreenState();
}

class _PhotoApiScreenState extends State<PhotoApiScreen> {
  List<PhotosModel> allPhotos = [];

  Future<List<PhotosModel>> getPhotos() async {
    final response = await http
        .get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    final data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        PhotosModel photo =
            PhotosModel(title: i["title"], id: i["id"], url: i["url"]);
        allPhotos.add(photo);
      }
      return allPhotos;
    } else {
      return allPhotos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Photos Api call"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPhotos(),
                // builder: (context, snapshot) {
                  builder: (context, AsyncSnapshot snapshot){
                  if (!snapshot.hasData) {
                    return const Text("Loading . . . ");
                  } else {
                    return ListView.builder(
                      itemCount: allPhotos.length,
                      itemBuilder: ((context, index) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage:
                                // NetworkImage(allPhotos[index].url.toString()),
                                NetworkImage(snapshot.data[index].url.toString())
                          ),
                          // title: Text(allPhotos[index].title.toString()),
                          title: Text(snapshot.data[index].title.toString()),
                          subtitle:
                              const Text("Hello This is Shahzaneer Ahmed! "),
                        );
                      }),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
