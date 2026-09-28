import 'package:assignment/controllers/user_controller.dart';
import 'package:assignment/models/user_model.dart';
import 'package:assignment/repositories/user_reposiotry.dart';
import 'package:assignment/services/user_services.dart';
import 'package:flutter_test/flutter_test.dart';

// Fake API (no internet needed): 3 pages, 5 users per page, like reqres.in
class FakeUserServices extends UserServices {
  bool shouldFail = false;
  final List<int> requestedPages = [];
  final List<int> requestedPerPage = [];

  @override
  Future<UserModel> fetchUserData(int page, {int perPage = 5}) async {
    requestedPages.add(page);
    requestedPerPage.add(perPage);

    if (shouldFail) {
      throw Exception('No internet');
    }

    return UserModel.fromJson({
      'page': page,
      'per_page': perPage,
      'total': 15,
      'total_pages': 3,
      'data': List.generate(perPage, (i) {
        final id = (page - 1) * perPage + i + 1;
        return {
          'id': id,
          'email': 'user$id@test.com',
          'first_name': 'First$id',
          'last_name': 'Last$id',
          'avatar': 'https://reqres.in/img/faces/$id-image.jpg',
        };
      }),
    });
  }
}

void main() {
  late FakeUserServices fakeServices;
  late UserController controller;

  setUp(() {
    fakeServices = FakeUserServices();
    controller = UserController(
      userRepository: UserRepository(userServices: fakeServices),
    );
  });

  // ================= FIRST PAGE =================

  test('First page should load 5 users', () async {
    await controller.fetchUsers();

    expect(controller.users.length, 5);
    expect(controller.currentPage, 1);
    expect(controller.totalPages, 3);
  });

  test('User should have first name, last name and email', () async {
    await controller.fetchUsers();

    expect(controller.users.first.firstName, 'First1');
    expect(controller.users.first.lastName, 'Last1');
    expect(controller.users.first.email, 'user1@test.com');
  });

  test('API should be called with page 1 and per_page 5', () async {
    await controller.fetchUsers();

    expect(fakeServices.requestedPages, [1]);
    expect(fakeServices.requestedPerPage, [5]);
  });

  test('Loader should be false after loading', () async {
    await controller.fetchUsers();

    expect(controller.isLoading.value, false);
  });

  // ================= PAGINATION =================

  test('Next page should add 5 more users', () async {
    await controller.fetchUsers();
    await controller.loadNextPage();

    expect(controller.users.length, 10);
    expect(controller.currentPage, 2);
    expect(controller.users.last.firstName, 'First10');
  });

  test('Should not load more after last page', () async {
    await controller.fetchUsers();
    await controller.loadNextPage();
    await controller.loadNextPage();
    await controller.loadNextPage(); // no page 4

    expect(controller.users.length, 15);
    expect(controller.currentPage, 3);
    expect(fakeServices.requestedPages, [1, 2, 3]);
  });

  test('Pagination loader should be false after loading', () async {
    await controller.fetchUsers();
    await controller.loadNextPage();

    expect(controller.isPaginationLoading.value, false);
  });

  // ================= PULL TO REFRESH =================

  test('Refresh should go back to first page', () async {
    await controller.fetchUsers();
    await controller.loadNextPage();
    await controller.refreshUsers();

    expect(controller.users.length, 5);
    expect(controller.currentPage, 1);
  });

  // ================= ERROR =================

  test('API error should set error message and no users', () async {
    fakeServices.shouldFail = true;

    await controller.fetchUsers();

    expect(controller.users.isEmpty, true);
    expect(controller.errorMessage.value.isNotEmpty, true);
    expect(controller.isLoading.value, false);
  });
}
