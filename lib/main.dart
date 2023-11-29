import 'package:flutter/material.dart';

import 'app/modules/book/presenter/pages/book_list_widget.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: BookListWidget(),
      ),
    );
  }
}