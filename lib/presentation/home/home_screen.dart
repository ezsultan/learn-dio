import 'package:flutter/material.dart';
import 'package:learndio/dio/dio_cilent.dart';

import '../../model/post_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var requesting = false;
  late DioClient dioClient;
  late Future<Post> post;
  late Future<List<Post>> posts;

  @override
  void initState() {
    super.initState();
    dioClient = DioClient();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (requesting)
                // Getting a resource
                FutureBuilder<Post>(
                  future: post,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Text(
                            'title : ${snapshot.data!.title} \n body : ${snapshot.data!.body}',
                          )
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Text('${snapshot.error}');
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              // Listing all resources
              // FutureBuilder<List<Post>>(
              //   future: posts,
              //   builder: (context, snapshot) {
              //     if (snapshot.hasData) {
              //       return Column(
              //         children: [
              //           Text(
              //             'title : ${snapshot.data![1].title} \n body : ${snapshot.data![1].body}',
              //           )
              //         ],
              //       );
              //     } else if (snapshot.hasError) {
              //       return Text('${snapshot.error}');
              //     }
              //     return const CircularProgressIndicator();
              //   },
              // ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      post = dioClient.fetchPost(1);
                      setState(() {
                        requesting = true;
                      });
                    },
                    child: const Text('Get Data'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      posts = dioClient.fetchPosts();
                      setState(() {
                        requesting = true;
                      });
                    },
                    child: const Text('Get Data(list)'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      post = dioClient.createPost(101, 'title', 'body');
                    },
                    child: Text('Create Data'),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      post = dioClient.updatePost(2, 101, 'tle', 'body');
                      setState(() {
                        requesting = true;
                      });
                    },
                    child: const Text('Update Data'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      dioClient.deletePost(1);
                      setState(() {
                        requesting = true;
                      });
                    },
                    child: const Text('Delete Data'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
