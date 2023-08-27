import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Parser {
// Для использования: Parser.fetchAndParse(
//          "https://strengthlevel.com/api/exercises?limit=320&exercise.fields=category,name_url,bodypart,count,aliases,icon_url&standard=yes");
// Это для получения всех упражнений
  static Future<String> fetchContent(String url) async {
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception('Failed to load content');
    }
  }

  static Future<String> parseJSON(String jsonContent) async {
    final Map<String, dynamic> decodedJson = jsonDecode(jsonContent);
    final List<dynamic> data = decodedJson['data'];

    for (final item in data) {
      item.remove('id');
      item.remove('count');
      item.remove('aliases');
      item.remove('name_url');
      //item.remove('category'); //не знаю, нужно ли это поле
    }

    final updatedJsonContent = jsonEncode(data);

    //Весь следующий код для сохранения файла
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/output.json');
    await file.writeAsString(updatedJsonContent);

    debugPrint(
        'File save to  ${file.path}'); //Если через эмулятор запускать, то сохраниться во внутренюю директорию, если запустить через винду, то в документы.
    return updatedJsonContent;
  }

  static Future<void> fetchAndParse(String url) async {
    try {
      final htmlContent = await fetchContent(url);
      parseJSON(
          htmlContent); //Возвращает стрингу со всеми упражнениями в формате JSON
    } catch (e) {
      debugPrint('An error occurred: $e');
    }
  }
}
