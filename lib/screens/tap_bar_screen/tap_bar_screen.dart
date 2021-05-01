import 'package:flutter/material.dart';
import 'package:meals_app_2/main_drawer.dart';
import 'package:meals_app_2/dummy_data.dart';
import 'package:meals_app_2/models/meal.dart';
import 'package:meals_app_2/screens/categories_screen/categories_screen.dart';
import 'package:meals_app_2/screens/favorites_screen/favorites_screen.dart';

class TapBarScreen extends StatefulWidget {
  final Function toggle;

  const TapBarScreen({Key key, this.toggle}) : super(key: key);
  @override
  _TapBarScreenState createState() => _TapBarScreenState();
}

class _TapBarScreenState extends State<TapBarScreen> {
  var _selectedIndex = 0;
  void _setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List _pages = [
    {"page": CategoriesScreen(), 'title': 'Categories'},
    {"page": FavoritesScreen(), 'title': 'Favorites'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: ValueKey('1'),
      appBar: AppBar(
        title: Text('Choose 2 category'),
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: widget.toggle,
        ),
      ),
      // drawer: widget.toggle(),
      body: _pages[_selectedIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).accentColor,
        onTap: _setIndex,
        type: BottomNavigationBarType.shifting,
        //backgroundColor: Theme.of(context).accentColor,
        //fixedColor: Theme.of(context).primaryColor,
      ),
    );
  }
}
