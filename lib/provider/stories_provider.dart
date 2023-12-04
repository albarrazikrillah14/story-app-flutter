import 'package:flutter/material.dart';
import 'package:story_app/data/local/model/auth/login/login_request.dart';
import 'package:story_app/data/local/model/auth/register/register_request.dart';
import 'package:story_app/data/local/model/list/story_list_request.dart';
import 'package:story_app/data/local/model/list/story_list_response.dart';
import 'package:story_app/data/local/model/story.dart';
import 'package:story_app/data/remote/api/api_service.dart';

enum ResultState { loading, noData, hasData, error }

class StoriesProvider extends ChangeNotifier {
  final ApiService apiService;

  late ResultState _state;
  late List<Story> _stories;
  late Story _detailStory;
  late bool _error;
  String _message = '';

  ResultState get state => _state;
  List<Story> get stories => _stories;
  Story get detailStory => _detailStory;
  String get message => _message;
  bool get error => _error;

  StoriesProvider(this.apiService);

  Future<StoryListResponse> fetchAllStories(StoryListRequest request) async {
    _state = ResultState.loading;
    _message = 'Loading.';
    notifyListeners();
    final list = await apiService.getStories(request);
    try {
      if (list.listStory.isEmpty) {
        _state = ResultState.noData;
        _message = list.message;
        _error = list.error;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _stories = list.listStory;
        _error = list.error;

        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi Kesalahan Internet';
      _error = list.error;
      notifyListeners();
    }

    return list;
  }

  Future<void> fetchDetailStory(String id) async {
    _state = ResultState.loading;
    _message = 'Loading.';
    notifyListeners();

    final detail = await apiService.getDetailStory(id);
    try {
      if (detail.story.id.isEmpty) {
        _state = ResultState.noData;
        _message = detail.message;
        _error = detail.error;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _detailStory = detail.story;
        _error = detail.error;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi Kesalahan Internet';
      _error = detail.error;
      notifyListeners();
    }
  }

  Future<void> postLogin(LoginRequest request) async {
    _state = ResultState.loading;
    _message = 'Loading.';
    notifyListeners();

    final login = await apiService.postLogin(request);

    notifyListeners();
    try {
      if (login.error == true) {
        _state = ResultState.error;
        _message = login.message;
        _error = login.error;
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _message = login.message;
        _error = login.error;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi Kesalahan Internet';
      _error = login.error;
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
        notifyListeners();
      } else {
        _state = ResultState.hasData;
        _message = register.message;
        _error = register.error;
        notifyListeners();
      }
    } catch (e) {
      _state = ResultState.error;
      _message = 'Terjadi Kesalahan Internet';
      _error = register.error;
      notifyListeners();
    }
  }
}
