import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:infocontract/features/home/presentation/screens/home_screen.dart';

void main() {
  testWidgets('Home screen displays app name', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: HomeScreen()),
    );

    expect(find.text(HomeScreen.appName), findsOneWidget);
  });
}
