import 'package:freezed_annotation/freezed_annotation.dart';
import '../story.dart';

part 'story_list_response.g.dart';
part 'story_list_response.freezed.dart';

@freezed
class StoryListResponse with _$StoryListResponse {
  factory StoryListResponse({
    required bool error,
    required String message,
    required List<Story> listStory,
  }) = _StoryListResponse;

  factory StoryListResponse.fromJson(Map<String, dynamic> json) =>
      _$StoryListResponseFromJson(json);
}
