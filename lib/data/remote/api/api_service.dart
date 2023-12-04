import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:story_app/data/db/auth_repository.dart';
import 'package:story_app/data/local/model/auth/login/login_request.dart';
import 'package:story_app/data/local/model/auth/login/login_response.dart';
import 'package:story_app/data/local/model/auth/register/register_request.dart';
import 'package:story_app/data/local/model/auth/register/register_response.dart';
import 'package:story_app/data/local/model/detail/story_detail_response.dart';
import 'package:story_app/data/local/model/list/story_list_request.dart';
import 'package:story_app/data/local/model/list/story_list_response.dart';

class ApiService {
  String? token;
  AuthRepository authRepository;

  ApiService(this.authRepository) {
    init();
  }

  void init() async {
    token = await authRepository.getToken();
  }
  static const String _baseUrl = 'https://story-api.dicoding.dev/v1';

  Future<RegisterResponse> postRegister(RegisterRequest request) async {
    final Map<String, String> requestBody = {
      'name': request.name,
      'email': request.email,
      'password': request.password,
    };

    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(requestBody),
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return RegisterResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to register');
    }
  }

  Future<LoginResponse> postLogin(LoginRequest request) async {
    final Map<String, String> requestBody = {
      'email': request.email,
      'password': request.password,
    };

    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(requestBody),
      );
      return LoginResponse.fromJson(json.decode(response.body));
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<StoryListResponse> getStories(StoryListRequest request) async {
    // final Map<String, int> requestBody = {
    //   'page': request.page,
    //   'size': request.size,
    //   'location': request.location,
    // };
    final response = await http.get(
      Uri.parse('$_baseUrl/stories'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return StoryListResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to get stories');
    }
  }

  Future<StoryDetail> getDetailStory(String id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/stories/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token'
      },
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return StoryDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to get detail story');
    }
  }
}
