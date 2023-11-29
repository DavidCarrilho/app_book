import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/entities/book_entity.dart';
import '../../../external/datasources/get_books_datasource.dart';
import '../book_list_widget.dart';

class FavoritesWidget extends StatefulWidget {
  const FavoritesWidget({Key? key}) : super(key: key);

  @override
  FavoritesWidgetState createState() => FavoritesWidgetState();
}

class FavoritesWidgetState extends State<FavoritesWidget> {
  late Future<List<BookEntity>> futureFavoriteBooks;

  @override
  void initState() {
    super.initState();
    futureFavoriteBooks = fetchFavoriteBooks();
  }

  Future<List<BookEntity>> fetchFavoriteBooks() async {
    final favoritesIds = await Favorites.instance.getFavorites();
    final books = await GetBooksDataSource().call();
    return books.where((book) => favoritesIds.contains(book.id.toString())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookEntity>>(
      future: futureFavoriteBooks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Erro: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return BookListWidgetState().buildBookGridView(snapshot.data!, true);
        } else {
          return const Center(child: Text('Nenhum favorito'));
        }
      },
    );
  }
}

class Favorites {
  Favorites._privateConstructor();

  static final Favorites instance = Favorites._privateConstructor();

  static const _favoritesKey = 'favorites';

  Future<SharedPreferences> get _prefs => SharedPreferences.getInstance();

  Future<Set<String>> getFavorites() async {
    return (await _prefs).getStringList(_favoritesKey)?.toSet() ?? {};
  }

  Future<void> addFavorite(String id) async {
    final favorites = await getFavorites();
    favorites.add(id);
    (await _prefs).setStringList(_favoritesKey, favorites.toList());
  }

  Future<void> removeFavorite(String id) async {
    final favorites = await getFavorites();
    favorites.remove(id);
    (await _prefs).setStringList(_favoritesKey, favorites.toList());
  }

  Future<bool> isFavorite(String id) async {
    final favorites = await getFavorites();
    return favorites.contains(id);
  }
}
