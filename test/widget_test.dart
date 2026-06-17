import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:runbroclassified/main.dart';

void main() {
  testWidgets('Splash screen redirects to onboarding then login screen test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that splash screen is shown initially.
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('Loading...'), findsNothing);

    // Advance 2 seconds to let the splash screen transition to loading screen
    await tester.pump(const Duration(seconds: 2));
    await tester.pump(const Duration(milliseconds: 100));

    // Verify that loading screen is shown.
    expect(find.text('Loading...'), findsOneWidget);

    // Pump and settle to let the loading screen transition to onboarding screen
    await tester.pumpAndSettle();

    // Verify we are on OnboardingScreen (Page 1)
    expect(find.textContaining('Find great deals around you'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Tap "Next" button to go to Page 2 of Onboarding
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Verify we are on OnboardingScreen (Page 2)
    expect(find.textContaining('Discover amazing deals from trusted sellers'), findsOneWidget);
    expect(find.text('Next'), findsOneWidget);

    // Tap "Next" button to go to Page 3 of Onboarding
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    // Verify we are on OnboardingScreen (Page 3)
    expect(find.textContaining('Have questions? Chat in real-time'), findsOneWidget);
    expect(find.text('Get Started'), findsOneWidget);

    // Tap "Get Started" button to navigate to LoginScreen
    await tester.tap(find.text('Get Started'));
    await tester.pumpAndSettle();

    // Verify that we are on LoginScreen
    expect(find.text('Welcome Back!'), findsOneWidget);
    expect(find.text('Enter mobile number'), findsOneWidget);
  });
}
