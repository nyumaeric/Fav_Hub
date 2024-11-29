import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Favorites extends ChangeNotifier {
  final List<String> _items = [];

  Favorites() {
    _loadFavorites();
  }

  List<String> get items => _items;

  void addItem(String item) async {
    if (!_items.contains(item)) {
      _items.add(item);
      notifyListeners();
      await _saveFavorites();
    }
  }

  void removeItem(String item) async {
    _items.remove(item);
    notifyListeners();
    await _saveFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedItems = prefs.getStringList('favorites') ?? [];
    _items.addAll(savedItems);
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', _items);
  }
}
