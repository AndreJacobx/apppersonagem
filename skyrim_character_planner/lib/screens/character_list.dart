import 'package:flutter/material.dart';
import '../models/character.dart';

class CharacterListScreen extends StatelessWidget {
  final List<Character> characters;

  const CharacterListScreen({super.key, required this.characters});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Characters')),
      body: characters.isEmpty
          ? const Center(child: Text('No characters created yet.'))
          : ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  title: Text(character.name),
                  subtitle: Text('Race: ${character.race.name}'),
                  onTap: () {
                    _showCharacterDetails(context, character);
                  },
                );
              },
            ),
    );
  }

  void _showCharacterDetails(BuildContext context, Character character) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(character.name),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Race: ${character.race.name}'),
                Text('Weapon: ${character.weapon?.name ?? "None"}'),
                Text('Armor: ${character.armor?.name ?? "None"}'),
                Text(
                    'Magics: ${character.magics.map((m) => m.name).join(", ") ?? "None"}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
