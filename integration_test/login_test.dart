import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:trial_1/main.dart';  // Replace with actual entry file

void main() {
  testWidgets('PL-02: Successful login with Email + Password', (WidgetTester tester) async {
    // Load the Login Screen
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Enter valid email
    await tester.enterText(find.byKey(Key('emailField')), 'patient@test.com');

    // Enter correct password
    await tester.enterText(find.byKey(Key('passwordField')), 'CorrectPass@123');

    // Tap on Login button
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pumpAndSettle();

    // Verify redirection to Patient Dashboard
    expect(find.byKey(Key('patientDashboard')), findsOneWidget);
  });

  testWidgets('PL-03: Successful login with Phone + Password', (WidgetTester tester) async {
    // Load the Login Screen
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Enter valid phone number
    await tester.enterText(find.byKey(Key('phoneField')), '+923001234567');

    // Enter correct password
    await tester.enterText(find.byKey(Key('passwordField')), 'CorrectPass@123');

    // Tap on Login button
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pumpAndSettle();

    // Verify redirection to Patient Dashboard
    expect(find.byKey(Key('patientDashboard')), findsOneWidget);
  });

  testWidgets('Error Handling: Invalid Credentials', (WidgetTester tester) async {
    // Load the Login Screen
    await tester.pumpWidget(MaterialApp(home: LoginScreen()));

    // Enter incorrect email
    await tester.enterText(find.byKey(Key('emailField')), 'wrong@test.com');

    // Enter incorrect password
    await tester.enterText(find.byKey(Key('passwordField')), 'WrongPass!123');

    // Tap on Login button
    await tester.tap(find.byKey(Key('loginButton')));
    await tester.pumpAndSettle();

    // Verify error message appears
    expect(find.text('Invalid credentials. Please try again.'), findsOneWidget);
  });
}