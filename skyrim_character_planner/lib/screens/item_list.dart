import 'package:flutter/material.dart';
import '../models/item.dart';

class ItemListScreen extends StatefulWidget {
  final ItemType itemType;
  final bool multiSelect;
  final List<Item>? selectedItems;
  final Function(Item)? onItemSelected;

  const ItemListScreen({super.key, 
    required this.itemType,
    this.multiSelect = false,
    this.selectedItems,
    this.onItemSelected,
  });

  @override
  _ItemListScreenState createState() => _ItemListScreenState();
}

class _ItemListScreenState extends State<ItemListScreen> {
  late List<Item> items;
  List<Item> _selectedItems = [];

  @override
  void initState() {
    super.initState();
    items = _getItemsForType(widget.itemType);
    _selectedItems = widget.selectedItems ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select ${widget.itemType.toString().split('.').last}'),
        actions: [
          if (widget.multiSelect)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () => Navigator.pop(context, _selectedItems),
            ),
        ],
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name),
            trailing: widget.multiSelect
                ? Checkbox(
                    value: _selectedItems.contains(item),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          _selectedItems.add(item);
                        } else {
                          _selectedItems.remove(item);
                        }
                      });
                    },
                  )
                : null,
            onTap: () {
              if (widget.multiSelect) {
                setState(() {
                  if (_selectedItems.contains(item)) {
                    _selectedItems.remove(item);
                  } else {
                    _selectedItems.add(item);
                  }
                });
              } else {
                if (widget.onItemSelected != null) {
                  widget.onItemSelected!(item);
                } else {
                  Navigator.pop(context, item);
                }
              }
            },
          );
        },
      ),
    );
  }

  List<Item> _getItemsForType(ItemType type) {
    switch (type) {
      case ItemType.race:
        return [
          Item(name: 'Nord', type: ItemType.race),
          Item(name: 'Imperial', type: ItemType.race),
          Item(name: 'High Elf', type: ItemType.race),
        ];
      case ItemType.weapon:
        return [
          Item(name: 'Sword', type: ItemType.weapon),
          Item(name: 'Bow', type: ItemType.weapon),
          Item(name: 'Battle Axe', type: ItemType.weapon),
        ];
      case ItemType.armor:
        return [
          Item(name: 'Light Armor', type: ItemType.armor),
          Item(name: 'Heavy Armor', type: ItemType.armor),
          Item(name: 'Mage Robes', type: ItemType.armor),
        ];
      case ItemType.magic:
        return [
          Item(name: 'Fireball', type: ItemType.magic),
          Item(name: 'Healing', type: ItemType.magic),
          Item(name: 'Invisibility', type: ItemType.magic),
        ];
    }
  }
}