import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:trial_1/main.dart'; // Adjust path as needed

void main() {
  testWidgets('Patient signup flow navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(); // Let initial frame build

    print('App loaded');
    
    await tester.pumpAndSettle();  // Ensure everything is rendered

    // Debug the widget tree
    debugDumpApp();

    // Find and tap the signup button (use the correct button type if not ElevatedButton)
    final signupButton = find.byType(ElevatedButton);  // Adjust if it's another button type
    expect(signupButton, findsOneWidget);
    await tester.tap(signupButton);
    await tester.pumpAndSettle();

    print('Tapped Patient Sign Up');

    // Fill in patient form
    await tester.enterText(find.byKey(const Key('nameField')), 'Samah');
    await tester.enterText(find.byKey(const Key('emailField')), 'samah@example.com');
    await tester.enterText(find.byKey(const Key('passwordField')), 'password123');

    await tester.pump(const Duration(milliseconds: 500));
    print('Filled patient basic info');

    await tester.dragUntilVisible(
      find.byKey(const Key('genderDropdown')),
      find.byType(SingleChildScrollView),
      const Offset(0, 200),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('genderDropdown')));
    await tester.pump();
    await tester.tap(find.text('Female').last);
    await tester.pump();

    print('Selected patient gender');

    await tester.dragUntilVisible(
      find.byKey(const Key('maritalStatusDropdown')),
      find.byType(SingleChildScrollView),
      const Offset(0, 200),
    );
    await tester.tap(find.byKey(const Key('maritalStatusDropdown')));
    await tester.pump();
    await tester.tap(find.text('Single').last);
    await tester.pump();

    print('Selected patient marital status');

    await tester.dragUntilVisible(
      find.widgetWithText(ElevatedButton, 'CONTINUE'),
      find.byType(SingleChildScrollView),
      const Offset(0, 300),
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'CONTINUE'));
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Medical Information'), findsOneWidget);
    print('Patient navigation success');
  });

  testWidgets('Donor signup flow navigation', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    await tester.pump(); // Initial frame

    print('App loaded');

    await tester.pumpAndSettle();  // Ensure everything is rendered

    // Debug the widget tree
    debugDumpApp();

    // Find and tap the donor signup button (adjust if it's a different type of button)
    final donorSignupButton = find.byType(ElevatedButton);  // Use the correct type
    expect(donorSignupButton, findsOneWidget);
    await tester.tap(donorSignupButton);
    await tester.pumpAndSettle();

    print('Tapped Donor Sign Up');

    // Fill in donor form
    await tester.enterText(find.byKey(const Key('nameField')), 'Ali');
    await tester.enterText(find.byKey(const Key('emailField')), 'ali@example.com');
    await tester.enterText(find.byKey(const Key('passwordField')), 'donorpass123');

    await tester.pump(const Duration(milliseconds: 500));
    print('Filled donor basic info');

    await tester.dragUntilVisible(
      find.byKey(const Key('genderDropdown')),
      find.byType(SingleChildScrollView),
      const Offset(0, 200),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byKey(const Key('genderDropdown')));
    await tester.pump();
    await tester.tap(find.text('Male').last);
    await tester.pump();

    print('Selected donor gender');

    await tester.dragUntilVisible(
      find.byKey(const Key('bloodTypeDropdown')),
      find.byType(SingleChildScrollView),
      const Offset(0, 200),
    );
    await tester.tap(find.byKey(const Key('bloodTypeDropdown')));
    await tester.pump();
    await tester.tap(find.text('O+').last);
    await tester.pump();

    print('Selected blood type');

    await tester.dragUntilVisible(
      find.widgetWithText(ElevatedButton, 'CONTINUE'),
      find.byType(SingleChildScrollView),
      const Offset(0, 300),
    );
    await tester.tap(find.widgetWithText(ElevatedButton, 'CONTINUE'));
    await tester.pump(const Duration(seconds: 2));

    expect(find.text('Donation Preferences'), findsOneWidget);
    print('Donor navigation success');
  });
}
