class StoryUploadRequest {
  List<int> bytes;
  String fileName;
  String description;
  double? lat;
  double? lon;

  StoryUploadRequest(
      {required this.bytes,
      required this.fileName,
      required this.description,
      this.lat,
      this.lon});
}
