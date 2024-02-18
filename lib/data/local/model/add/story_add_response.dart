import 'package:freezed_annotation/freezed_annotation.dart';

part 'story_add_response.g.dart';
part 'story_add_response.freezed.dart';

@freezed
class AddNewStoryResponse with _$AddNewStoryResponse {
  const factory AddNewStoryResponse({
    required bool error,
    required String message,
  }) = _AddNewStoryResponse;

  factory AddNewStoryResponse.fromJson(Map<String, dynamic> json) =>
      _$AddNewStoryResponseFromJson(json);
}
