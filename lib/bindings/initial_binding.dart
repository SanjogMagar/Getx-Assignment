import 'package:assignment/bindings/firebase_binding.dart';
import 'package:get/get.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    AuthBinding().dependencies();
  }
}