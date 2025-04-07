import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:trial_1/main.dart'; 

void main() {
  group('Patient Login Tests', () {
    
    testWidgets('PL-02: Successful Login with Email + Password', (WidgetTester tester) async {
      // Load the Login Screen
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Enter registered email and correct password
      await tester.enterText(find.byType(TextField).at(0), 'patient@test.com');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      // Tap on Login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify redirection to Patient Dashboard
      expect(find.byKey(Key('patientDashboard')), findsOneWidget);
    });

    testWidgets('PL-03: Successful Login with Phone + Password', (WidgetTester tester) async {
      // Load the Login Screen
      await tester.pumpWidget(MaterialApp(home: LoginScreen()));

      // Enter registered phone number and correct password
      await tester.enterText(find.byType(TextField).at(0), '+923001234567');
      await tester.enterText(find.byType(TextField).at(1), 'password123');

      // Tap on Login button
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      // Verify redirection to Patient Dashboard
      expect(find.byKey(Key('patientDashboard')), findsOneWidget);
    });

  });
}
