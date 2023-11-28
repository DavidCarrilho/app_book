import 'package:app_book/app/modules/book/domain/entities/book_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../external/datasources/get_books_datasource.dart';
import '../pages/details_book_page.dart';

class BookListWidget extends StatefulWidget {
  const BookListWidget({super.key});

  @override
  _BookListWidgetState createState() => _BookListWidgetState();
}

class _BookListWidgetState extends State<BookListWidget> {
  late Future<List<BookEntity>> futureBooks;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    futureBooks = GetBooksDataSource().call();
  }

  Future<void> downloadBook(BookEntity book) async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/${book.title}.epub';
      try {
        await _dio.download(book.downloadUrl, filePath);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Baixado ${book.title}')),
        );
      } catch (e) {
        debugPrint('Erro ao baixar: $e');
      }
    } else {
      debugPrint('Permissão negada');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BookEntity>>(
      future: futureBooks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final book = snapshot.data![index];
              return ListTile(
                title: Text(book.title),
                subtitle: Text(book.author),
                leading: Image.network(book.coverUrl),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailsBookPage(book: book),
                    ),
                  );
                },
              );
            },
          );
        } else {
          return const Text('Nenhum livro encontrado');
        }
      },
    );
  }
}