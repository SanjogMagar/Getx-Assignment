import 'package:assignment/controllers/firebase_controller.dart';
import 'package:assignment/repositories/firebase_repositroy.dart';
import 'package:assignment/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';

// Fake controller, so no real Firebase is needed in tests.
class FakeAuthController extends GetxController implements AuthController {
  @override
  final RxBool isLoading = false.obs;

  bool signUpCalled = false;
  String? lastEmail;
  String? lastPassword;

  @override
  AuthRepository get authRepository => throw UnimplementedError();

  @override
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    return false;
  }

  @override
  Future<bool> signUp({
    required String email,
    required String password,
  }) async {
    signUpCalled = true;
    lastEmail = email;
    lastPassword = password;
    return false; // stay on the signup screen
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

  // Opens the signup screen on a big fake phone screen.
  Future<void> openSignupScreen(WidgetTester tester) async {
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(const GetMaterialApp(home: SignupScreen()));
    await tester.pump();
  }

  Future<void> tapSignUp(WidgetTester tester) async {
    await tester.tap(find.text('Sign Up'));
    await tester.pump();
  }

  // Field order on the screen: 0 = email, 1 = password, 2 = confirm password

  // ================= EMAIL =================

  testWidgets('Empty email should return error', (tester) async {
    await openSignupScreen(tester);

    await tapSignUp(tester);

    expect(find.text('Please enter your email'), findsOneWidget);
  });

  testWidgets('Invalid email should return error', (tester) async {
    await openSignupScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'sanjoggmail.com');
    await tapSignUp(tester);

    expect(find.text('Please enter a valid email'), findsOneWidget);
  });

  testWidgets('Valid email should return null', (tester) async {
    await openSignupScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'sanjog@gmail.com');
    await tapSignUp(tester);

    expect(find.text('Please enter your email'), findsNothing);
    expect(find.text('Please enter a valid email'), findsNothing);
  });

  // ================= PASSWORD =================

  testWidgets('Empty password should return error', (tester) async {
    await openSignupScreen(tester);

    await tapSignUp(tester);

    expect(find.text('Please enter a password'), findsOneWidget);
  });

  testWidgets('Short password should return error', (tester) async {
    await openSignupScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tapSignUp(tester);

    expect(find.text('Password must be at least 6 characters'), findsOneWidget);
  });

  testWidgets('Valid password should return null', (tester) async {
    await openSignupScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tapSignUp(tester);

    expect(find.text('Please enter a password'), findsNothing);
    expect(find.text('Password must be at least 6 characters'), findsNothing);
  });

  // ================= CONFIRM PASSWORD =================

  testWidgets('Empty confirm password should return error', (tester) async {
    await openSignupScreen(tester);

    await tapSignUp(tester);

    expect(find.text('Please confirm your password'), findsOneWidget);
  });

  testWidgets('Different confirm password should return error',
      (tester) async {
    await openSignupScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tester.enterText(find.byType(TextFormField).at(2), '654321');
    await tapSignUp(tester);

    expect(find.text('Passwords do not match'), findsOneWidget);
  });

  testWidgets('Same confirm password should return null', (tester) async {
    await openSignupScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tester.enterText(find.byType(TextFormField).at(2), '123456');
    await tapSignUp(tester);

    expect(find.text('Passwords do not match'), findsNothing);
    expect(find.text('Please confirm your password'), findsNothing);
  });

  // ================= SHOW / HIDE PASSWORD =================

  testWidgets('Both password fields should have show / hide icon',
      (tester) async {
    await openSignupScreen(tester);

    expect(find.byIcon(Icons.visibility_off_outlined), findsNWidgets(2));

    await tester.tap(find.byIcon(Icons.visibility_off_outlined).first);
    await tester.pump();

    expect(find.byIcon(Icons.visibility_outlined), findsOneWidget);
    expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
  });

  // ================= SIGN UP =================

  testWidgets('Valid data should call signUp', (tester) async {
    await openSignupScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'sanjog@gmail.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123456');
    await tester.enterText(find.byType(TextFormField).at(2), '123456');
    await tapSignUp(tester);

    expect(authController.signUpCalled, true);
    expect(authController.lastEmail, 'sanjog@gmail.com');
    expect(authController.lastPassword, '123456');
  });

  testWidgets('Wrong data should NOT call signUp', (tester) async {
    await openSignupScreen(tester);

    await tester.enterText(find.byType(TextFormField).at(0), 'sanjoggmail.com');
    await tester.enterText(find.byType(TextFormField).at(1), '123');
    await tester.enterText(find.byType(TextFormField).at(2), '456');
    await tapSignUp(tester);

    expect(authController.signUpCalled, false);
  });
}
