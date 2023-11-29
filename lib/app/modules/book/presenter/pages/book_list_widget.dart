import 'package:flutter/material.dart';

import '../../domain/entities/book_entity.dart';
import '../../external/datasources/get_books_datasource.dart';
import 'details_book_page.dart';
import 'widgets/favorites_widget.dart';

class BookListWidget extends StatefulWidget {
  const BookListWidget({super.key});

  @override
  BookListWidgetState createState() => BookListWidgetState();
}

class BookListWidgetState extends State<BookListWidget> {
  late Future<List<BookEntity>> futureBooks;
  late Future<Set<String>> futureFavorites;

  @override
  void initState() {
    super.initState();
    futureBooks = GetBooksDataSource().call();
  }

  Future<List<BookEntity>> fetchFavoriteBooks() async {
    final favoritesIds = await futureFavorites;
    final books = await futureBooks;
    return books.where((book) => favoritesIds.contains(book.id.toString())).toList();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Estante Virtual'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Livros'),
              Tab(text: 'Favoritos'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            FutureBuilder<List<BookEntity>>(
              future: futureBooks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                  return buildBookGridView(snapshot.data!, false);
                } else {
                  return const Center(child: Text('Nenhum livro encontrado'));
                }
              },
            ),
            const FavoritesWidget(),
          ],
        ),
      ),
    );
  }

  GridView buildBookGridView(List<BookEntity> books, bool isFavoritesPage) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.5,
      ),
      itemCount: books.length,
      itemBuilder: (context, index) {
        final book = books[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => DetailsBookPage(book: book),
              ),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 120.0,
                      width: 80.0,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(0, 3),
                          ),
                        ],
                        image: DecorationImage(
                          image: NetworkImage(book.coverUrl),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: FutureBuilder<bool>(
                        future: Favorites.instance.isFavorite(book.id.toString()),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          } else {
                            final isFavorite = snapshot.data ?? false;
                            return InkWell(
                              onTap: () async {
                                if (isFavorite) {
                                  await Favorites.instance.removeFavorite(book.id.toString());
                                  futureFavorites = Favorites.instance.getFavorites();
                                } else {
                                  await Favorites.instance.addFavorite(book.id.toString());
                                  futureFavorites = Favorites.instance.getFavorites();
                                }
                                setState(() {
                                  futureFavorites = Favorites.instance.getFavorites();
                                  futureBooks = GetBooksDataSource().call();
                                });
                              },
                              child: Container(
                                height: 30,
                                width: 20,
                                decoration: BoxDecoration(
                                  color: isFavorite ? Colors.red : Colors.white,
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(20.0),
                                    bottomLeft: Radius.circular(20.0),
                                  ),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  book.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  book.author,
                  style: const TextStyle(
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
