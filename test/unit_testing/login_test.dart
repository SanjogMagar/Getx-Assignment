import 'package:assignment/controllers/firebase_controller.dart';
import 'package:assignment/repositories/firebase_repositroy.dart';
import 'package:assignment/views/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

// Fake controller, so no real Firebase is needed in tests.
class FakeAuthController extends GetxController implements AuthController {
  @override
  final RxBool isLoading = false.obs;

  bool loginCalled = false;
  String? lastEmail;
  String? lastPassword;

  @override
  AuthRepository get authRepository => throw UnimplementedError();

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    loginCalled = true;
    lastEmail = email;
    lastPassword = password;
    return false; // stay on the login screen
  }

  @override
  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    return false;
  }

  @override
  Future<void> logout() async {}
}

void main() {
  late FakeAuthController authController;

  setUp(() {
    authController = FakeAuthController();
    Get.put<AuthController>(authController);
  });

  tearDown(() {
    Get.reset();
  });

  // Opens the login screen on a big fake phone screen.
  Future<void> openLoginScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const GetMaterialApp(home: LoginScreen()));
    await tester.pump();
  }

  Future<void> tapLogin(WidgetTester tester) async {
    await tester.tap(find.text('Login'));
    await tester.pump();
  }

  // ================= EMAIL =================

  testWidgets('Empty email should return error', (tester) async {
    await openLoginScreen(tester);

    await tapLogin(tester);

    expect(find.text('Please enter your email'), findsOneWidget);
  });

  testWidgets('Invalid email should return error', (tester) async {
    await openLoginScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'sanjoggmail.com');
    await tapLogin(tester);

    expect(find.text('Please enter a valid email'), findsOneWidget);
  });

  testWidgets('Valid email should return null', (tester) async {
    await openLoginScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'sanjog@gmail.com');
    await tapLogin(tester);

    expect(find.text('Please enter your email'), findsNothing);
    expect(find.text('Please enter a valid email'), findsNothing);
  });

  // ================= PASSWORD =================

  testWidgets('Empty password should return error', (tester) async {
    await openLoginScreen(tester);

    await tapLogin(tester);

    expect(find.text('Please enter your password'), findsOneWidget);
  });

  testWidgets('Short password should return error', (tester) async {
    await openLoginScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tapLogin(tester);

    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
  });

  testWidgets('Valid password should return null', (tester) async {
    await openLoginScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tapLogin(tester);

    expect(find.text('Please enter your password'), findsNothing);
    expect(find.text('Password must be at least 6 characters'), findsNothing);
  });

  // ================= SHOW / HIDE PASSWORD =================

  testWidgets('Password show / hide icon should toggle', (tester) async {
    await openLoginScreen(tester);

    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);

    await tester.tap(find.byIcon(Icons.visibility_off_outlined));
    await tester.pump();

    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
  });

  // ================= LOGIN =================

  testWidgets('Valid email and password should call login', (tester) async {
    await openLoginScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'sanjog@gmail.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tapLogin(tester);

    expect(authController.loginCalled, true);
    expect(authController.lastEmail, 'sanjog@gmail.com');
    expect(authController.lastPassword, '123456');
  });

  testWidgets('Wrong input should NOT call login', (tester) async {
    await openLoginScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'sanjoggmail.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tapLogin(tester);

    expect(authController.loginCalled, false);
  });
}
