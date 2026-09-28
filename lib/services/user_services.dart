import 'package:assignment/models/user_model.dart';
import 'package:dio/dio.dart';

class UserServices {
  final Dio _dio = Dio();

  Future<UserModel> fetchUserData(
    int page, {
    int perPage = 5,
  }) async {
    try {
      final response = await _dio.get(
        'https://reqres.in/api/users',
        queryParameters: {
          'page': page,
          'per_page': perPage,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'x-api-key':
                'reqres_32e47dacd4744f009b24358d68f0272d',
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> json = response.data;

        return UserModel.fromJson(json);
      } else {
        throw Exception(
          'Failed to fetch users. Status code: ${response.statusCode}',
        );
      }
    } on DioException catch (e) {
      throw Exception(
        'API Error: ${e.response?.data ?? e.message}',
      );
    } catch (e) {
      throw Exception(
        'Something went wrong: $e',
      );
    }
  }
}