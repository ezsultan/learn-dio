import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:learndio/common/constant.dart';
import 'package:learndio/model/post_model.dart';

class DioClient {
  // dio instance
  final Dio dio = Dio();

  // get a resource
  Future<Post> fetchPost(int postId) async {
    try {
      final response = await dio.get(
        Constant.baseUrl + Constant.post + '/$postId',
      );
      debugPrint(response.toString());
      return Post.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint('Status code: ${e.response?.statusCode.toString()}');
      throw Exception('Failed to load post: $postId');
    }
  }

  // get list resources
  Future<List<Post>> fetchPosts() async {
    try {
      final response = await dio.get(Constant.baseUrl + Constant.post);
      debugPrint(response.toString());
      return Post.listFromJson(response.data);
    } on DioError catch (e) {
      debugPrint('Status code: ${e.response?.statusCode.toString()}');
      throw Exception('Failed to load posts');
    }
  }

  // create data
  Future<Post> createPost(
    int userId,
    String title,
    String body,
  ) async {
    try {
      final response = await dio.post(
        Constant.baseUrl + Constant.post,
        data: {
          'userId': userId,
          'title': title,
          'body': body,
        },
      );
      debugPrint(response.toString());
      return Post.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint('Status code: ${e.response?.statusCode.toString()}');
      throw Exception('Failed to create post');
    }
  }

  // update data
  Future<Post> updatePost(
    int postId,
    int userId,
    String title,
    String body,
  ) async {
    try {
      final response = await dio.put(
        Constant.baseUrl + Constant.post + '/$postId',
        data: {
          'userId': userId,
          'title': title,
          'body': body,
        },
      );
      debugPrint(response.toString());
      return Post.fromJson(response.data);
    } on DioError catch (e) {
      debugPrint('Status code: ${e.response?.statusCode.toString()}');
      throw Exception('Failed to update post: $postId');
    }
  }

  // delete data
  Future<void> deletePost(int postId) async {
    try {
      final response = await dio.delete(
        Constant.baseUrl + Constant.post + '/$postId',
      );
      debugPrint('delete succes');
    } on DioError catch (e) {
      debugPrint('Status code: ${e.response?.statusCode.toString()}');
      throw Exception('Failed to delete post: $postId');
    }
  }
}
