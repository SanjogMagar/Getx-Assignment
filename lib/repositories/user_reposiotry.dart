import 'package:assignment/models/user_model.dart';
import 'package:assignment/services/user_services.dart';

class UserRepository {
  final UserServices userServices;

  UserRepository({
    required this.userServices,
  });

  Future<UserModel> fetchUsers({
    required int page,
    int perPage = 5,
  }) async {
    return await userServices.fetchUserData(
      page,
      perPage: perPage,
    );
  }
}