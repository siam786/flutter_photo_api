import 'package:api/models/post_data.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<PostModel> UserList = [];

Future<List<PostModel>> getPostApi() async {
  final response =
      await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
  //var data = postdata.fromJson(response.body);
  var data = postModelFromJson(response.body);
  if (response.statusCode == 200) {
    UserList = [...data];
    return UserList;
  } else {
    return UserList;
  }
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('home'),
          leading: const Icon(Icons.arrow_back),
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                future: getPostApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(
                          backgroundColor: Color(0xff000000),
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xfffd7013))),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: UserList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Title'),
                                  Text(UserList[index].title),
                                  const Text('Body'),
                                ]),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
        ));
  }
}
