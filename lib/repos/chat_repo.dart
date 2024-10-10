import 'dart:developer';

import 'package:ai_dnm/models/chat_message_model.dart';
import 'package:ai_dnm/utils/constants.dart';
import 'package:dio/dio.dart';
import 'dart:convert';


class Aithrepy {
  static Future<String> chatTextGenerationRepo(List<ChatMessageModel> previousMessages) async {
    const apiKey = "AIzaSyAuBwAkhTxcmKUtUCrw4pF8bzD3ZeZEoNA";

    try {
      Dio dio = Dio();
      final response = await dio.post(
        "https://generativelanguage.googleapis.com/v1beta/models/tunedModels/new-therapyv1-durpuxmaryre:generateContent?key=$apiKey",
        options: Options(
          headers: {"Content-Type": "application/json"},
        ),
        data: jsonEncode({
          "contents": previousMessages.map((e) => e.toMap()).toList(),
          "generationConfig": {
            "temperature": 0.9,
            "topP": 1,
            "maxOutputTokens": 2048,
            "responseMimeType": "text/plain"
          },
        }),
      );

      if (response.statusCode! >= 200 && response.statusCode! < 300) {
        return response.data['candidates'].first['content']['parts'].first['text'];
      }
      return '';
    } catch (e) {
      print(e.toString());
      return '';
    }
  }
}