import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/translation_model.dart';

class TranslationService {
  static const String _baseUrl = 'https://api.papago.com/v1/papago/n2mt';
  
  Future<TranslationModel> translateText({
    required String text,
    required String sourceLanguage,
    required String targetLanguage,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'X-Naver-Client-Id': dotenv.env['PAPAGO_CLIENT_ID'] ?? '',
          'X-Naver-Client-Secret': dotenv.env['PAPAGO_CLIENT_SECRET'] ?? '',
        },
        body: {
          'source': sourceLanguage,
          'target': targetLanguage,
          'text': text,
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return TranslationModel(
          sourceText: text,
          translatedText: data['message']['result']['translatedText'],
          sourceLanguage: sourceLanguage,
          targetLanguage: targetLanguage,
        );
      } else {
        throw Exception('Failed to translate text');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
} 