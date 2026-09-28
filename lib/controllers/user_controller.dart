import 'package:assignment/models/user_model.dart';
import 'package:assignment/repositories/user_reposiotry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final UserRepository userRepository;

  UserController({
    required this.userRepository,
  });

  final RxList<UserData> users = <UserData>[].obs;

  final RxBool isLoading = false.obs;

  final RxBool isPaginationLoading = false.obs;

  final RxString errorMessage = ''.obs;

  int currentPage = 1;

  int totalPages = 1;

  final int perPage = 5;

  @override
  void onInit() {
    super.onInit();

    fetchUsers();
  }

  
  // FIRST PAGE
  // ==========================================================

  Future<void> fetchUsers() async {
    try {
      isLoading.value = true;

      errorMessage.value = '';

      final response = await userRepository.fetchUsers(
        page: 1,
        perPage: perPage,
      );

      users.clear();

      users.addAll(response.data ?? []);

      currentPage = response.page ?? 1;

      totalPages = response.totalPages ?? 1;

      debugPrint('========== FIRST PAGE ==========');
      debugPrint('Current Page: $currentPage');
      debugPrint('Total Pages: $totalPages');
      debugPrint('Users: ${users.length}');
      debugPrint('================================');
    } catch (e) {
      errorMessage.value = e.toString();

      debugPrint('FETCH ERROR: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // NEXT PAGE
  // ==========================================================

  Future<void> loadNextPage() async {
    if (isPaginationLoading.value) {
      debugPrint('Pagination already running...');
      return;
    }

    if (currentPage >= totalPages) {
      debugPrint('No more pages available.');
      return;
    }

    try {
      isPaginationLoading.value = true;

      final int nextPage = currentPage + 1;

      debugPrint('========== PAGINATION ==========');
      debugPrint('Requesting page: $nextPage');
      debugPrint('================================');

      final response = await userRepository.fetchUsers(
        page: nextPage,
        perPage: perPage,
      );

      final List<UserData> newUsers =
          response.data ?? [];

      if (newUsers.isNotEmpty) {
        users.addAll(newUsers);
      }

      currentPage = response.page ?? nextPage;

      totalPages =
          response.totalPages ?? totalPages;

      debugPrint('========== PAGE LOADED ==========');
      debugPrint('Current Page: $currentPage');
      debugPrint('Total Pages: $totalPages');
      debugPrint('Total Users: ${users.length}');
      debugPrint('=================================');
    } catch (e) {
      errorMessage.value = e.toString();

      debugPrint('PAGINATION ERROR: $e');
    } finally {
      isPaginationLoading.value = false;
    }
  }

  // ==========================================================
  // REFRESH
  
  Future<void> refreshUsers() async {
    try {
      errorMessage.value = '';

      currentPage = 1;

      totalPages = 1;

      final response = await userRepository.fetchUsers(
        page: 1,
        perPage: perPage,
      );

      users.clear();

      users.addAll(response.data ?? []);

      currentPage = response.page ?? 1;

      totalPages = response.totalPages ?? 1;
    } catch (e) {
      errorMessage.value = e.toString();

      debugPrint('REFRESH ERROR: $e');
    }
  }
}