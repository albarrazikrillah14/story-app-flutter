import 'package:flutter/material.dart';
import 'package:story_app/data/db/auth_repository.dart';
import 'package:story_app/data/local/model/auth/login/login_request.dart';
import 'package:story_app/data/local/model/auth/register/register_request.dart';
import 'package:story_app/data/local/model/auth/register/register_response.dart';
import 'package:story_app/data/remote/api/api_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthRepository authRepository;
  final ApiService apiService;

  AuthProvider(this.authRepository, this.apiService);

  bool isLoadingLogin = false;
  bool isLoadingLogout = false;
  bool isLoadingRegister = false;

  Future<bool> login(LoginRequest request) async {
    isLoadingLogin = true;
    notifyListeners();

    final result = await apiService.postLogin(request);

    if (result.error == false) {
      await saveToken(result.loginResult!.token);
      await authRepository.login();
    }
    isLoadingLogin = false;
    notifyListeners();

    return !result.error;
  }

  Future<bool> logout() async {
    isLoadingLogout = true;
    notifyListeners();

    final logout = await authRepository.logout();
    if (logout) {
      await authRepository.deleteToken();
    }

    isLoadingLogout = false;
    notifyListeners();

    return logout;
  }

  Future<bool> saveToken(String token) async {
    await authRepository.saveToken(token);
    return true;
  }

  Future<String> getToken() async {
    final token = await authRepository.getToken();

    return token.toString();
  }

  Future<RegisterResponse?> register(RegisterRequest request) async {
  try {
    isLoadingRegister = true;
    notifyListeners();

    final result = await apiService.postRegister(request);

    isLoadingRegister = false;
    notifyListeners();

    return result;
  } catch (e) {
    isLoadingRegister = false;
    notifyListeners();
    
    return null;
  }
}

}
