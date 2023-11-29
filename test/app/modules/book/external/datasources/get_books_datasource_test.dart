// import 'package:app_book/app/modules/book/domain/entities/book_entity.dart';
// import 'package:app_book/app/modules/book/external/datasources/get_books_datasource.dart';
// import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';

// class MockDio extends Mock implements Dio {}

// void main() {
//   late GetBooksDataSource dataSource;
//   late MockDio mockDio;

//   setUp(() {
//     mockDio = MockDio();
//     dataSource = GetBooksDataSource();
//   });

//   group('GetBooksDataSource Test', () {
//     test('should return a list of BookEntity when the call is successful', () async {
//       // Mock de Response ajustado
//       when(mockDio.get(any)).thenAnswer((_) async => Response(
//           data: [
//             {
//               "id": "1",
//               "title": "Test Book",
//               "author": "Test Author",
//               "coverUrl": "https://test.com/cover.jpg"
//             }
//           ],
//           statusCode: 200,
//           requestOptions: RequestOptions(path: 'https://escribo.com/books.json')));

//       final result = await dataSource.call();

//       expect(result, isA<List<BookEntity>>());
//       expect(result.first.id, equals("1"));
//       expect(result.first.title, equals("Test Book"));
//       expect(result.first.author, equals("Test Author"));
//       expect(result.first.coverUrl, equals("https://test.com/cover.jpg"));
//     });

//     test('should return an empty list when the call is unsuccessful', () async {
//       when(mockDio.get(any)).thenThrow(DioError(requestOptions: RequestOptions(path: 'https://escribo.com/books.json')));

//       final result = await dataSource.call();

//       expect(result, equals([]));
//     });
//   });
// }
