import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_upload_response.g.dart';
part 'story_upload_response.freezed.dart';

@freezed
class StoryUploadResponse with _$StoryUploadResponse {
  factory StoryUploadResponse({
    required bool error,
    required String message,
  }) = _StoryUploadResponse;

  factory StoryUploadResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryUploadResponseFromJson(json);
}
