import 'package:story_app/data/local/model/story.dart';

class StoryDetail {
  bool error;
  String message;
  Story story;

  StoryDetail({
    required this.error,
    required this.message,
    required this.story,
  });

  factory StoryDetail.fromJson(Map<String, dynamic> json) => StoryDetail(
        error: json["error"],
        message: json["message"],
        story: Story.fromJson(json["story"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "story": story.toJson(),
      };
}
