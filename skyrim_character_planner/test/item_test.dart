import 'package:flutter_test/flutter_test.dart';
import 'package:skyrim_character_planner/models/character.dart';
import 'package:skyrim_character_planner/models/item.dart';

void main() {
  test('Deve criar um personagem com todos os atributos corretamente', () {
    final race = Item(name: 'Nord', type: ItemType.race);
    final weapon = Item(name: 'Sword', type: ItemType.weapon);
    final armor = Item(name: 'Light Armor', type: ItemType.armor);
    final magic = Item(name: 'Fireball', type: ItemType.magic);

    final character = Character(
      name: 'Ulfric Stormcloak',
      race: race,
      weapon: weapon,
      armor: armor,
      magics: [magic],
    );

    expect(character.name, 'Ulfric Stormcloak');
    expect(character.race.name, 'Nord');
    expect(character.weapon?.name, 'Sword');
    expect(character.armor?.name, 'Light Armor');
    expect(character.magics.length, 1);
    expect(character.magics.first.name, 'Fireball');
  });

  test('Deve criar um personagem sem arma, armadura e magia', () {
    final race = Item(name: 'Imperial', type: ItemType.race);

    final character = Character(
      name: 'Titus Mede II',
      race: race,
    );

    expect(character.weapon, null);
    expect(character.armor, null);
    expect(character.magics, isEmpty);
  });
}
