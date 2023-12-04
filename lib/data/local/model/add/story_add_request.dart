import 'dart:io';

class StoryAddRequest {
  String description;
  File photo;
  double? lat;
  double? lon;

  StoryAddRequest({
    required this.description,
    required this.photo,
    this.lat,
    this.lon,
  });
}
