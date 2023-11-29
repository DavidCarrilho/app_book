import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

import '../../domain/entities/book_entity.dart';

class DetailsBookPage extends StatefulWidget {
  final BookEntity book;

  const DetailsBookPage({Key? key, required this.book}) : super(key: key);

  @override
  DetailsBookPageState createState() => DetailsBookPageState();
}

class DetailsBookPageState extends State<DetailsBookPage> {
  bool isDownloading = false;
  bool isDownloaded = false;
  String filePath = "";

  @override
  void initState() {
    super.initState();
    checkIfBookIsDownloaded();
  }

  Future<void> checkIfBookIsDownloaded() async {
    final directory = await getApplicationDocumentsDirectory();
    filePath = '${directory.path}/${widget.book.title}.epub';
    final fileExists = await File(filePath).exists();

    setState(() {
      isDownloaded = fileExists;
    });
  }

  Future<void> downloadBook() async {
    setState(() {
      isDownloading = true;
    });

    if (!await File(filePath).exists()) {
      try {
        await Dio().download(widget.book.downloadUrl, filePath);
        setState(() {
          isDownloaded = true;
        });
      } catch (e) {
        debugPrint('Error downloading book: $e');
      }
    }

    setState(() {
      isDownloading = false;
    });
  }

  void openBook() {
    VocsyEpub.setConfig(
      themeColor: Theme.of(context).primaryColor,
      identifier: "iosBook",
      scrollDirection: EpubScrollDirection.ALLDIRECTIONS,
      allowSharing: true,
      enableTts: true,
      nightMode: true,
    );

    VocsyEpub.locatorStream.listen((locator) {
      debugPrint('LOCATOR: $locator');
    });

    VocsyEpub.open(
      filePath,
      lastLocation: EpubLocator.fromJson({
        "bookId": "bookId",
        "href": "/OEBPS/chapter1.xhtml",
        "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.network(widget.book.coverUrl),
              Text(widget.book.title, style: const TextStyle(fontSize: 24)),
              Text(widget.book.author, style: const TextStyle(fontSize: 18)),
              const SizedBox(height: 16),
              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: isDownloaded ? openBook : downloadBook,
                  child: isDownloading
                      ? const SizedBox(
                          height: 24,
                          width: 24,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 1.8,
                          ),
                        )
                      : Text(isDownloaded ? 'Ler'.toUpperCase() : 'Baixar'.toUpperCase()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
