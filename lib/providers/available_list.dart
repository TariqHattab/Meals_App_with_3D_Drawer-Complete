import 'package:flutter/material.dart';
import 'package:meals_app_2/dummy_data.dart';
import 'package:meals_app_2/models/meal.dart';

class AvailableList extends ChangeNotifier {
  List<Meal> _availableList = [];
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegeterian': false,
    'vegan': false,
  };
  get filters {
    return _filters;
  }

  setFilters(Map<String, bool> map) {
    _filters = map;
    notifyListeners();
  }

  List<Meal> get availableList {
    _availableList = DUMMY_MEALS.where((meal) {
      if (_filters['gluten'] && !meal.isGlutenFree) {
        return false;
      }
      if (_filters['lactose'] && !meal.isLactoseFree) {
        return false;
      }
      if (_filters['vegeterian'] && !meal.isVegetarian) {
        return false;
      }
      if (_filters['vegan'] && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    return _availableList;
  }
}
