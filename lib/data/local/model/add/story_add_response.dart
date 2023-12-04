class AddNewStoryResponse {
  bool error;
  String message;

  AddNewStoryResponse({
    required this.error,
    required this.message,
  });

  factory AddNewStoryResponse.fromJson(Map<String, dynamic> json) =>
      AddNewStoryResponse(
        error: json["error"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
      };
}
