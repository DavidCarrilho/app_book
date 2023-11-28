import 'package:flutter/material.dart';

import 'app/modules/book/presenter/widgets/book_list_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Início'),
        ),
        body: const BookListWidget(),
      ),
    );
  }
}
