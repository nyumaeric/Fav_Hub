import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/favorites.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorite Products'),
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromARGB(255, 97, 95, 95),
      ),
      body: Consumer<Favorites>(
        builder: (context, favorites, child) {
          final items = favorites.items;
          return items.isEmpty
              ? const Center(child: Text('No favorites yet!'))
              : ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Card(
                      child: ListTile(
                        title: Text(item),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            favorites.removeItem(item);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content:
                                      Text('$item removed from favorites')),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
