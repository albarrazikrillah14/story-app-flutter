import 'package:freezed_annotation/freezed_annotation.dart';
import '../story.dart';

part 'story_detail_response.g.dart';
part 'story_detail_response.freezed.dart';

@freezed
class StoryDetail with _$StoryDetail {
  factory StoryDetail({
    required bool error,
    required String message,
    required Story story,
  }) = _StoryDetail;

  factory StoryDetail.fromJson(Map<String, dynamic> json) =>
      _$StoryDetailFromJson(json);
}
