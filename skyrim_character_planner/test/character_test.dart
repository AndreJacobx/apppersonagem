import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skyrim_character_planner/screens/create_character.dart';

void main() {
  testWidgets(
      'Deve navegar para a tela de seleção de item e retornar ao criar personagem',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CreateCharacterScreen(),
    ));

    expect(find.text('Race: None'), findsOneWidget);

    await tester.tap(find.text('Race: None'));
    await tester.pumpAndSettle();

    expect(find.text('Select race'), findsOneWidget);

    await tester.tap(find.text('Nord'));
    await tester.pumpAndSettle();

    expect(find.text('Race: Nord'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'Ulfric Stormcloak');

    await tester.tap(find.text('Create Character'));
    await tester.pumpAndSettle();

    expect(find.text('Race: Nord'), findsOneWidget);
    expect(find.text('Name: Ulfric Stormcloak'), findsOneWidget);
  });
}
