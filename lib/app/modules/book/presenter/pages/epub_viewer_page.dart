import 'package:flutter/material.dart';
import 'package:vocsy_epub_viewer/epub_viewer.dart';

class EpubViewerPage extends StatefulWidget {
  final String bookFilePath;

  const EpubViewerPage({Key? key, required this.bookFilePath}) : super(key: key);

  @override
  _EpubViewerPageState createState() => _EpubViewerPageState();
}

class _EpubViewerPageState extends State<EpubViewerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leitor de Livros'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
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
                  widget.bookFilePath,
                  lastLocation: EpubLocator.fromJson({
                    "bookId": "bookId",
                    "href": "/OEBPS/chapter1.xhtml",
                    "locations": {"cfi": "epubcfi(/0!/4/4[simple_book]/2/2/6)"}
                  }),
                );
              },
              child: const Text('Abrir o Livro'),
            ),
          ],
        ),
      ),
    );
  }
}
