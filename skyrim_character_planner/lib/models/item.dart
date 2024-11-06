enum ItemType { race, weapon, armor, magic }

class Item {
  String name;
  ItemType type;

  Item({required this.name, required this.type});
}
