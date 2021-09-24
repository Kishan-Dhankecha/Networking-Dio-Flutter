import 'dart:developer';

import 'package:dio/dio.dart';

import '../modals/user.dart';
import '../modals/user_info.dart';
import 'logging.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in/api',
      connectTimeout: 5000,
      receiveTimeout: 3000,
    ),
  )..interceptors.add(Logging());

  final _baseUrl = 'https://reqres.in/api';

  Future<User?> getUser({required String id}) async {
    User? user;
    try {
      Response userData = await _dio.get(_baseUrl + '/users/$id');
      log('User Info: ${userData.data}');
      user = User.fromJson(userData.data);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response != null) {
        log('Dio error!');
        log('STATUS: ${e.response?.statusCode}');
        log('DATA: ${e.response?.data}');
        log('HEADERS: ${e.response?.headers}');
      } else {
        // Error due to setting up or sending the request
        log('Error sending request!');
        log(e.message);
      }
    }
    return user;
  }

  Future<UserInfo?> createUser({required UserInfo userInfo}) async {
    UserInfo? retrievedUser;
    try {
      Response response = await _dio.post(
        _baseUrl + '/users',
        data: userInfo.toJson(),
      );
      log('User created: ${response.data}');
      retrievedUser = UserInfo.fromJson(response.data);
    } catch (e) {
      log('Error creating user: $e');
    }
    return retrievedUser;
  }

  Future<UserInfo?> updateUser({
    required UserInfo userInfo,
    required String id,
  }) async {
    UserInfo? updatedUser;
    try {
      Response response = await _dio.put(
        _baseUrl + '/users/$id',
        data: userInfo.toJson(),
      );
      log('User updated: ${response.data}');
      updatedUser = UserInfo.fromJson(response.data);
    } catch (e) {
      log('Error updating user: $e');
    }
    return updatedUser;
  }

  Future<void> deleteUser({required String id}) async {
    try {
      await _dio.delete(_baseUrl + '/users/$id');
      log('User deleted!');
    } catch (e) {
      log('Error deleting user: $e');
    }
  }
}
