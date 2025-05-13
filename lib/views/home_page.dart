import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/post.dart';
import 'package:flutter_application_1/services/remote_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post>? posts = [];
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    posts = await RemoteService().getPosts();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Posts"),
      ),
      body:
          isLoaded
              ? ListView.builder(
                itemCount: posts?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(posts![index].title),
                      subtitle: Text(posts![index].body ?? ""),
                    ),
                  );
                },
              )
              : const Center(child: CircularProgressIndicator()),
    );
  }
}
