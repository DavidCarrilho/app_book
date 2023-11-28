import '../../domain/entities/book_entity.dart';

class BookAdapter extends BookEntity {
  BookAdapter({
    required super.id,
    required super.title,
    required super.author,
    required super.coverUrl,
    required super.downloadUrl,
  });

  factory BookAdapter.fromJson(Map<String, dynamic> json) {
    return BookAdapter(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      coverUrl: json['cover_url'] as String,
      downloadUrl: json['download_url'] as String,
    );
  }
}
