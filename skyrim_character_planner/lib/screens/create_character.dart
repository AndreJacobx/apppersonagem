import 'package:flutter/material.dart';
import '../models/character.dart';
import '../models/item.dart';
import 'item_list.dart';

class CreateCharacterScreen extends StatefulWidget {
  final Item? initialRace;

  const CreateCharacterScreen({super.key, this.initialRace});

  @override
  _CreateCharacterScreenState createState() => _CreateCharacterScreenState();
}

class _CreateCharacterScreenState extends State<CreateCharacterScreen> {
  late TextEditingController _nameController;
  Item? _selectedRace;
  Item? _selectedWeapon;
  Item? _selectedArmor;
  List<Item> _selectedMagics = [];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _selectedRace = widget.initialRace;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Character')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Character Name'),
            ),
            const SizedBox(height: 16),
            _buildItemSelection('Race', _selectedRace, ItemType.race),
            _buildItemSelection('Weapon', _selectedWeapon, ItemType.weapon),
            _buildItemSelection('Armor', _selectedArmor, ItemType.armor),
            _buildMagicSelection(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _createCharacter,
              child: const Text('Create Character'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildItemSelection(String label, Item? selectedItem, ItemType type) {
    return ListTile(
      title: Text('$label: ${selectedItem?.name ?? "None"}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _navigateToItemList(type),
    );
  }

  Widget _buildMagicSelection() {
    return ListTile(
      title: Text('Magics: ${_selectedMagics.map((m) => m.name).join(", ")}'),
      trailing: const Icon(Icons.chevron_right),
      onTap: () => _navigateToItemList(ItemType.magic, multiSelect: true),
    );
  }

  void _navigateToItemList(ItemType type, {bool multiSelect = false}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ItemListScreen(
          itemType: type,
          multiSelect: multiSelect,
          selectedItems: type == ItemType.magic ? _selectedMagics : null,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        switch (type) {
          case ItemType.race:
            _selectedRace = result as Item;
            break;
          case ItemType.weapon:
            _selectedWeapon = result as Item;
            break;
          case ItemType.armor:
            _selectedArmor = result as Item;
            break;
          case ItemType.magic:
            _selectedMagics = result as List<Item>;
            break;
        }
      });
    }
  }

  void _createCharacter() {
    if (_nameController.text.isEmpty || _selectedRace == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill in all required fields')),
      );
      return;
    }

    final newCharacter = Character(
      name: _nameController.text,
      race: _selectedRace!,
      weapon: _selectedWeapon,
      armor: _selectedArmor,
      magics: _selectedMagics,
    );

    Navigator.pop(context, newCharacter);
  }
}
