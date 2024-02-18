import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story_app/data/db/auth_repository.dart';
import 'package:story_app/data/local/model/auth/login/login_request.dart';
import 'package:story_app/data/local/model/auth/register/register_request.dart';
import 'package:story_app/data/local/model/story.dart';
import 'package:story_app/data/local/model/upload/story_upload_request.dart';
import 'package:story_app/data/local/model/upload/story_upload_response.dart';
import 'package:story_app/data/remote/api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class StoriesProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  late ApiService apiService;

  StoriesProvider(this.authRepository) {
    apiService = ApiService(authRepository);
  }

  late ResultState _state = ResultState.loading;
  late final List<Story> _stories = [];
  Story _detailStory =
      Story(id: "", name: "", description: "", photoUrl: "", createdAt: "");
  late bool _error;
  String _message = '';
  bool isUploading = false;

  XFile? imageFile;
  String? imagePath;

  ResultState get state => _state;
  List<Story> get stories => _stories;
  Story get detailStory => _detailStory;
  String get message => _message;
  bool get error => _error;

  int? pageItems = 1;
  int sizeItems = 10;

  Future<void> fetchAllStories() async {
    try {
      if (pageItems == 1) {
        _state = ResultState.loading;
        _message = "Loading";
      }

      final result = await apiService.getStories(pageItems!, sizeItems, 1);

      if (result.listStory.length < sizeItems) {
        pageItems = null;
      } else {
        pageItems = pageItems! + 1;
      }
      _state = ResultState.hasData;
      _stories.addAll(result.listStory);
      _message = "Success";
    } catch (e) {
      _state = ResultState.error;
      _message = "No Data";
    } finally {
      notifyListeners();
    }
  }

  Future<void> fetchDetailStory(String id) async {
    _state = ResultState.loading;
    _message = 'Loading';
    notifyListeners();

    final detail = await apiService.getDetailStory(id);
    try {
      if (detail.story.id.isEmpty) {
        _state = ResultState.noData;
        _message = detail.message;
        _error = detail.error;
      } else {
        _state = ResultState.hasData;
        _detailStory = detail.story;
        _error = detail.error;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi Kesalahan Internet';
      _error = detail.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> postLogin(LoginRequest request) async {
    _state = ResultState.loading;
    _message = 'Loading.';
    notifyListeners();

    final login = await apiService.postLogin(request);
    try {
      if (login.error == true) {
        _state = ResultState.error;
        _message = login.message;
        _error = login.error;
      } else {
        _state = ResultState.hasData;
        _message = login.message;
        _error = login.error;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi Kesalahan Internet';
      _error = login.error;
    } finally {
      notifyListeners();
    }
  }

  Future<void> postRegister(RegisterRequest request) async {
    _state = ResultState.loading;
    _message = 'Loading.';
    notifyListeners();

    final register = await apiService.postRegister(request);
    try {
      if (register.error == true) {
        _state = ResultState.error;
        _message = register.message;
        _error = register.error;
      } else {
        _state = ResultState.hasData;
        _message = register.message;
        _error = register.error;
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi Kesalahan Internet';
      _error = register.error;
    } finally {
      notifyListeners();
    }
  }

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

    final response = await apiService.uploadDocument(request);

    if (response.error == false) {
      pageItems = 1;
      await fetchAllStories();
      isUploading = false;
    }

    return response;
  }
}
