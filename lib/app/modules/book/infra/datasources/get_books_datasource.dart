
import '../../domain/entities/book_entity.dart';

abstract class IGetBooks {
  Future<List<BookEntity>> call();
}
