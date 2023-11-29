
import '../../domain/entities/book_entity.dart';

abstract class IGetBooksDataSource {
  Future<List<BookEntity>> call();
}
