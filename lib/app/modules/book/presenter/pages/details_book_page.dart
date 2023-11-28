import 'dart:io';

import 'package:app_book/app/modules/book/domain/entities/book_entity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'epub_viewer_page.dart';

class DetailsBookPage extends StatefulWidget {
  final BookEntity book;

  const DetailsBookPage({Key? key, required this.book}) : super(key: key);

  @override
  _DetailsBookPageState createState() => _DetailsBookPageState();
}

class _DetailsBookPageState extends State<DetailsBookPage> {
  bool isDownloading = false;
  bool isDownloaded = false;
  String filePath = "";

  Future<void> downloadBook() async {
    setState(() {
      isDownloading = true;
    });

    final directory = await getApplicationDocumentsDirectory();
    filePath = '${directory.path}/${widget.book.title}.epub';

    if (!await File(filePath).exists()) {
      try {
        await Dio().download(widget.book.downloadUrl, filePath);
        setState(() {
          isDownloaded = true;
        });
      } catch (e) {
        debugPrint('Erro ao baixar: $e');
      }
    }

    setState(() {
      isDownloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(widget.book.coverUrl),
            Text(widget.book.title, style: const TextStyle(fontSize: 24)),
            Text(widget.book.author, style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 16),
            if (isDownloading)
              const Center(child: CircularProgressIndicator())
            else if (!isDownloaded)
              ElevatedButton(
                onPressed: downloadBook,
                child: const Text('Baixar o livro'),
              ),
            if (isDownloaded)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => EpubViewerPage(bookFilePath: filePath),
                    ),
                  );
                },
                child: const Text('Ler o livro'),
              ),
          ],
        ),
      ),
    );
  }
}
