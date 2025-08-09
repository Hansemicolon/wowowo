class TranslationModel {
  final String sourceText;
  final String translatedText;
  final String sourceLanguage;
  final String targetLanguage;

  TranslationModel({
    required this.sourceText,
    required this.translatedText,
    required this.sourceLanguage,
    required this.targetLanguage,
  });

  factory TranslationModel.fromJson(Map<String, dynamic> json) {
    return TranslationModel(
      sourceText: json['sourceText'] ?? '',
      translatedText: json['translatedText'] ?? '',
      sourceLanguage: json['sourceLanguage'] ?? '',
      targetLanguage: json['targetLanguage'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sourceText': sourceText,
      'translatedText': translatedText,
      'sourceLanguage': sourceLanguage,
      'targetLanguage': targetLanguage,
    };
  }
}
