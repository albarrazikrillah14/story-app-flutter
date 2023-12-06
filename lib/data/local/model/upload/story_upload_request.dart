class StoryUploadRequest {
  List<int> bytes;
  String fileName;
  String description;

  StoryUploadRequest(
      {required this.bytes, required this.fileName, required this.description});
}
