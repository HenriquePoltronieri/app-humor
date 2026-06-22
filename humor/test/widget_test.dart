import 'package:flutter_test/flutter_test.dart';

import 'package:humor/main.dart';

void main() {
  testWidgets('MoodApp renders mood buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MoodApp());

    expect(find.text('Feliz'), findsOneWidget);
    expect(find.text('Triste'), findsOneWidget);
    expect(find.text('Animado'), findsOneWidget);
    expect(find.text('Calmo'), findsOneWidget);
    expect(find.text('Bravo'), findsOneWidget);
  });

  testWidgets('Tapping a mood button changes selected mood',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MoodApp());

    await tester.tap(find.text('Triste'));
    await tester.pumpAndSettle();

    expect(find.text('Triste'), findsWidgets);
  });
}
