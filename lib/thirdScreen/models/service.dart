import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia_app/thirdScreen/models/user_model.dart';

class MyService {
  late Dio _dio;
  // List<UserModel> user = [];
  Future<void> init() async {
    _dio = Dio();
  }

  MyService() {
    init();
  }
  Future<List<UserModel>> getUser({required int page}) async {
    try {
      String url = 'https://reqres.in/api/users?page=$page';
      final response = await _dio.get(url);
      if (response.statusCode == 200) {
        final List data = response.data['data'];
        debugPrint(response.data['data'].toString());
        final user = data.map((e) => UserModel.fromJson(e)).toList();
        return user;
      } else {
        throw 'get informations failed';
      }
    } catch (e) {
      rethrow;
    }
  }
}
