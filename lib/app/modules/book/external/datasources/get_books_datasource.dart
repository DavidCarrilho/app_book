import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/book_entity.dart';
import '../../infra/adapters/book_adapter.dart';
import '../../infra/datasources/get_books_datasource.dart';

class GetBooksDataSource implements IGetBooksDataSource {
  final Dio _dio = Dio();

  @override
  Future<List<BookEntity>> call() async {
    try {
      final response = await _dio.get('https://escribo.com/books.json');
      List<dynamic> data = response.data is List ? response.data : [];
      return data.map<BookEntity>((book) => BookAdapter.fromJson(book)).toList();
    } catch (e) {
      debugPrint('Erro ao buscar: $e');
      return [];
    }
  }
}
