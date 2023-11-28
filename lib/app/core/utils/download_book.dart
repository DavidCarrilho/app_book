// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../models/book.dart';

// Future<void> downloadBook(Book book, BuildContext context) async {
//   final status = await Permission.storage.request();
//   if (status.isGranted) {
//     final directory = await getApplicationDocumentsDirectory();
//     final filePath = '${directory.path}/${book.title}.epub';
//     try {
//       await Dio().download(book.downloadUrl, filePath);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Baixado ${book.title}')),
//       );
//     } catch (e) {
//       debugPrint('Erro ao baixar: $e');
//     }
//   } else {
//     debugPrint('Permissão negada');
//   }
// }