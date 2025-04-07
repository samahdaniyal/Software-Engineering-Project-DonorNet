import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trial_1/main.dart' as app;
import 'package:flutter/material.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Patient Signup Tests', () {
    testWidgets('P_SIGNUP_01 - Successful signup with valid details', (tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sign Up Now'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Patient'));
      await tester.pumpAndSettle();
      
      await tester.enterText(find.byKey(Key('nameField')), 'John Doe');
      await tester.enterText(find.byKey(Key('emailField')), 'johndoe@example.com');
      await tester.enterText(find.byKey(Key('phoneField')), '1234567890');
      await tester.enterText(find.byKey(Key('bloodTypeField')), 'O+');
      await tester.enterText(find.byKey(Key('passwordField')), 'Secure@123');
      
      await tester.tap(find.byKey(Key('submitButton')));
      await tester.pumpAndSettle();
      
      expect(find.text('Login'), findsOneWidget);
    });

    testWidgets('P_SIGNUP_02 - Signup fails with weak password', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Sign Up Now'));
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Patient'));
      await tester.pumpAndSettle();
      
      await tester.enterText(find.byKey(Key('emailField')), 'weakpass@example.com');
      await tester.enterText(find.byKey(Key('passwordField')), 'weakpass');
      
      await tester.tap(find.byKey(Key('submitButton')));
      await tester.pumpAndSettle();
      
      expect(find.text('Password must be 8+ characters with at least 1 number and 1 special character.'), findsOneWidget);
    });

    testWidgets('P_SIGNUP_03 - Signup fails with missing required fields', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Sign Up Now'));
      await tester.pumpAndSettle();
      
      await tester.tap(find.byKey(Key('submitButton')));
      await tester.pumpAndSettle();
      
      expect(find.text('This field is required'), findsWidgets);
    });

    testWidgets('P_SIGNUP_04 - Signup fails with invalid email format', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Sign Up Now'));
      await tester.pumpAndSettle();
      
      await tester.enterText(find.byKey(Key('emailField')), 'invalidemail');
      await tester.tap(find.byKey(Key('submitButton')));
      await tester.pumpAndSettle();
      
      expect(find.text('Invalid email format'), findsOneWidget);
    });

    testWidgets('P_SIGNUP_05 - Signup fails with duplicate email/phone', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Sign Up Now'));
      await tester.pumpAndSettle();
      
      await tester.enterText(find.byKey(Key('emailField')), 'existinguser@example.com');
      await tester.enterText(find.byKey(Key('phoneField')), '1234567890');
      
      await tester.tap(find.byKey(Key('submitButton')));
      await tester.pumpAndSettle();
      
      expect(find.text('Email/Phone already in use'), findsOneWidget);
    });

    testWidgets('P_SIGNUP_06 - Signup with Google account', (tester) async {
      app.main();
      await tester.pumpAndSettle();
      
      await tester.tap(find.text('Sign in using Google Account'));
      await tester.pumpAndSettle();
      
      expect(find.text('Dashboard'), findsOneWidget);
    });
  });
}