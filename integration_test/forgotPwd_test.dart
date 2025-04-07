import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trial_1/main.dart'; // Adjust this import based on your app structure

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Forgot Password Test Flow', (tester) async {
    // Launch the app
    await tester.pumpWidget(DonorNetApp());

    // 1. FP-01: User clicks "Forgot Password?" link
    // Navigate to the login screen if needed
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pumpAndSettle();

    // Tap "Forgot Password?"
    await tester.tap(find.text('Forgot Password?'));
    await tester.pumpAndSettle();

    // Verify redirection to Forgot Password screen
    expect(find.text('Forgot Your Password?'), findsOneWidget);

    // 2. FP-02: Submit password reset with a registered email
    await tester.enterText(find.byKey(Key('emailField')), 'user@example.com');
    await tester.tap(find.byKey(Key('sendResetLinkButton')));
    await tester.pumpAndSettle();

    // Verify success message for registered email
    expect(find.text('Password reset link sent to your email.'), findsOneWidget);

    // 3. FP-03: Submit password reset with an unregistered email
    await tester.enterText(find.byKey(Key('emailField')), 'unknown@test.com');
    await tester.tap(find.byKey(Key('sendResetLinkButton')));
    await tester.pumpAndSettle();

    // Verify error message for unregistered email
    expect(find.text('This email is not registered.'), findsOneWidget);

    // 4. FP-04: Submit password reset with an invalid email format
    await tester.enterText(find.byKey(Key('emailField')), 'user@invalid');
    await tester.tap(find.byKey(Key('sendResetLinkButton')));
    await tester.pumpAndSettle();

    // Verify error message for invalid email format
    expect(find.text('Please enter a valid email address.'), findsOneWidget);

    // 5. FP-05: Leave email field blank and submit
    await tester.enterText(find.byKey(Key('emailField')), '');
    await tester.tap(find.byKey(Key('sendResetLinkButton')));
    await tester.pumpAndSettle();

    // Verify error message for empty email field
    expect(find.text('Email is required.'), findsOneWidget);

    // 6. FP-06: Check if the reset link works (simulated test)
    // Simulate clicking on the reset link
    await tester.enterText(find.byKey(Key('emailField')), 'user@example.com');
    await tester.tap(find.byKey(Key('sendResetLinkButton')));
    await tester.pumpAndSettle();

    // Simulate entering a new password
    await tester.enterText(find.byKey(Key('newPasswordField')), 'NewPassword123!');
    await tester.enterText(find.byKey(Key('confirmPasswordField')), 'NewPassword123!');
    await tester.tap(find.byKey(Key('submitNewPasswordButton')));
    await tester.pumpAndSettle();

    // Verify success message for password reset
    expect(find.text('Password updated successfully.'), findsOneWidget);

    // 7. FP-07: Network failure during password reset request
    // Disable network (simulated)
    // You can use packages like 'mockito' or 'flutter_test' for mocking network responses

    // Attempt to submit the reset request again
    await tester.enterText(find.byKey(Key('emailField')), 'user@example.com');
    await tester.tap(find.byKey(Key('sendResetLinkButton')));
    await tester.pumpAndSettle();

    // Verify error message for no internet connection
    expect(find.text('No internet connection. Please try again.'), findsOneWidget);
  });
}
