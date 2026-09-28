import 'package:assignment/controllers/firebase_controller.dart';
import 'package:assignment/repositories/firebase_repositroy.dart';
import 'package:assignment/services/firebase_services.dart';
import 'package:get/get.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FirebaseAuthService>(
      FirebaseAuthService(),
      permanent: true,
    );

    Get.put<AuthRepository>(
      AuthRepository(
        authService: Get.find<FirebaseAuthService>(),
      ),
      permanent: true,
    );

    Get.put<AuthController>(
      AuthController(
        authRepository: Get.find<AuthRepository>(),
      ),
      permanent: true,
    );
  }
}