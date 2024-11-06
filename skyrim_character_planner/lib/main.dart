import 'package:flutter/material.dart';
import 'models/character.dart';
import 'models/item.dart';
import 'screens/dashboard.dart';
import 'screens/item_list.dart';
import 'screens/character_list.dart';
import 'screens/create_character.dart';

void main() {
  runApp(SkyrimPlannerApp());
}

class SkyrimPlannerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Skyrim Character Planner',
      theme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black87,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  List<Character> characters = [];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _navigateToCreateCharacter({Item? race}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateCharacterScreen(initialRace: race),
      ),
    );
    if (result != null && result is Character) {
      setState(() {
        characters.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _children = [
      DashboardScreen(characters: characters),
      ItemListScreen(
        itemType: ItemType.race,
        onItemSelected: (item) {
          _navigateToCreateCharacter(race: item);
        },
      ),
      CharacterListScreen(characters: characters),
    ];

    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Characters',
          ),
        ],
      ),
    );
  }
}
