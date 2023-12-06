import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/data/local/model/upload/story_upload_request.dart';
import 'package:story_app/data/local/model/upload/story_upload_response.dart';
import 'package:story_app/data/remote/api/api_service.dart';

class UploadProvider extends ChangeNotifier {
  final ApiService apiService;

  UploadProvider({required this.apiService});

  XFile? imageFile;
  String? imagePath;

  bool isUploading = false;
  String message = "";

  void setImageFile(XFile? value) {
    imageFile = value;
    notifyListeners();
  }

  void setImagePath(String? value) {
    imagePath = value;
    notifyListeners();
  }

  void removeImage() {
    imageFile = null;
    imagePath = null;
    notifyListeners();
  }

  Future<StoryUploadResponse?> upload(StoryUploadRequest request) async {
    isUploading = true;
    notifyListeners();

    final response = apiService.uploadDocument(request);

    isUploading = false;
    notifyListeners();

    return response;
  }
}
