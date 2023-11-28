import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/book_entity.dart';
import '../../infra/adapters/book_adapter.dart';
import '../../infra/datasources/get_books_datasource.dart';

class GetBooksDataSource implements IGetBooks {
  final Dio _dio = Dio();

  @override
  Future<List<BookEntity>> call() async {
    try {
      final response = await _dio.get('https://escribo.com/books.json');
      return response.data.map<BookEntity>((book) => BookAdapter.fromJson(book)).toList();
    } catch (e) {
      debugPrint('Erro ao buscar: $e');
      return [];
    }
  }
}
