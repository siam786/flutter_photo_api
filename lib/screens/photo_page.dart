import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;

class PhotoPage extends StatefulWidget {
  const PhotoPage({super.key});

  @override
  State<PhotoPage> createState() => _PhotoPageState();
}

List<Photos> PhotoList = [];

Future<List<Photos>> getPhotoApi() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
  var data = jsonDecode(response.body.toString());
  if (response.statusCode == 200) {
    // PhotoList = [...data];
    for (Map i in data) {
      Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
      PhotoList.add(photos);
    }
    return PhotoList;
  } else {
    return PhotoList;
  }
}

class _PhotoPageState extends State<PhotoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PhotoPage'),
        leading: const Icon(Icons.arrow_back),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPhotoApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return ListView.builder(
                    itemCount: PhotoList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(PhotoList[index].url),
                        ),
                        title: Text(PhotoList[index].id.toString()),
                        subtitle: Text(PhotoList[index].title.toString()),
                      );
                    },
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}

class Photos {
  String title, url;
  int id;
  Photos({required this.title, required this.url, required this.id});
}
