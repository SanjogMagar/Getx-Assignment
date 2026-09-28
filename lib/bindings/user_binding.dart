import 'package:get/get.dart';

import '../controllers/user_controller.dart';
import '../repositories/user_reposiotry.dart';
import '../services/user_services.dart';

class UserBinding extends Bindings {
  @override
  void dependencies() {
    // fenix: true -> if GetX deletes them when a page closes
    // (e.g. after logout), they are re-created automatically.
    Get.lazyPut<UserServices>(
      () => UserServices(),
      fenix: true,
    );

    Get.lazyPut<UserRepository>(
      () => UserRepository(userServices: Get.find<UserServices>()),
      fenix: true,
    );

    Get.lazyPut<UserController>(
      () => UserController(userRepository: Get.find<UserRepository>()),
      fenix: true,
    );
  }
}