import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:skyrim_character_planner/models/character.dart';
import 'package:skyrim_character_planner/models/item.dart';
import 'package:skyrim_character_planner/screens/character_list.dart';

void main() {
  testWidgets('Deve exibir a lista de personagens corretamente',
      (WidgetTester tester) async {
    final race = Item(name: 'Nord', type: ItemType.race);
    final character = Character(name: 'Ulfric Stormcloak', race: race);

    await tester.pumpWidget(MaterialApp(
      home: CharacterListScreen(characters: [character]),
    ));

    expect(find.text('Ulfric Stormcloak'), findsOneWidget);
    expect(find.text('Race: Nord'), findsOneWidget);
  });

  testWidgets('Deve exibir mensagem de nenhum personagem criado',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: CharacterListScreen(characters: []),
    ));

    expect(find.text('No characters created yet.'), findsOneWidget);
  });
}
