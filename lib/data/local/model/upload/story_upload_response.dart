import 'dart:convert';

class StoryUploadResponse {
  final bool error;
  final String message;

  StoryUploadResponse({
    required this.error,
    required this.message,
  });

  factory StoryUploadResponse.fromMap(Map<String, dynamic> map) {
    return StoryUploadResponse(
      error: map['error'] ?? false,
      message: map['message'] ?? '',
    );
  }

  factory StoryUploadResponse.fromJson(String source) =>
      StoryUploadResponse.fromMap(json.decode(source));
}
