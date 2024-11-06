import 'item.dart';

class Character {
  String name;
  Item race;
  Item? weapon;
  Item? armor;
  List<Item> magics; 

  Character({
    required this.name,
    required this.race,
    this.weapon,
    this.armor,
    List<Item>? magics,
  }) : magics = magics ?? [];

}