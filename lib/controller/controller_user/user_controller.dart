import 'package:dio/dio.dart';
import 'package:stockwatch_app/model/user_model.dart';

class UserServices {
  Dio dio = Dio();
  final String baseUrl = 'http://192.168.18.17:2000/stock';

  Future<User> loginUser(email, password) async {
    try {
      Response response = await dio.post(
        '$baseUrl/login',
        data: {'email': email, 'password': password},
      );

      if (response.statusCode == 200) {
        return User.fromJson(response.data['user']);
      } else {
        throw Exception('Failed to login');
      }
    } on DioException catch (e) {
      throw Exception('Login failed: ${e.message}');
    }
  }

  Future<User> register(String username, String email, String password) async {
    try {
      Response response = await dio.post(
        '$baseUrl/register',
        data: {'username': username, 'email': email, 'password': password},
      );

      if (response.statusCode == 201) {
        return User.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to register');
      }
    } on DioException catch (e) {
      throw Exception('Registration failed: ${e.message}');
    }
  }
}
