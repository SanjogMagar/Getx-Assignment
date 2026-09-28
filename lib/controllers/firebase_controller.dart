import 'package:assignment/repositories/firebase_repositroy.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthRepository authRepository;

  AuthController({
    required this.authRepository,
  });

  final RxBool isLoading = false.obs;

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      await authRepository.login(
        email,
        password,
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString().replaceFirst('Exception: ', ''),
      );

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    try {
      isLoading.value = true;

      await authRepository.signUp(
        email,
        password,
      );

      return true;
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString().replaceFirst('Exception: ', ''),
      );

      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      isLoading.value = true;

      await authRepository.logout();

      Get.offAllNamed('/login');
    } catch (e) {
      Get.snackbar(
        'Logout Failed',
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isLoading.value = false;
    }
  }
}