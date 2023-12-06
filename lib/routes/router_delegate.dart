import 'package:flutter/material.dart';
import 'package:story_app/data/db/auth_repository.dart';
import 'package:story_app/data/local/model/story.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/screen/auth/login_screen.dart';
import 'package:story_app/screen/auth/register_screen.dart';
import 'package:story_app/screen/detail/detail_screen.dart';
import 'package:story_app/screen/home/home_screen.dart';
import 'package:story_app/screen/splash/splash_screen.dart';
import 'package:story_app/screen/upload/upload_screen.dart';

class StoryAppRouterDelegate extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthRepository authRepository;
  final StoriesProvider storiesProvider;

  StoryAppRouterDelegate(this.authRepository, this.storiesProvider)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }
  void _init() async {
    await Future.delayed(const Duration(seconds: 3));
    isLoggedIn = await authRepository.isLoggedIn();
    notifyListeners();
  }

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool isUpload = false;
  Story? story;

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey("SplashPage"),
          child: SplashScreen(),
        ),
      ];

  List<Page> get _loggedInStack => [
        if (isLoggedIn == true)
          MaterialPage(
            key: const ValueKey('HomePage'),
            child: HomeScreen(
              logout: () async {
                await authRepository.logout();
                isLoggedIn = await authRepository.isLoggedIn();
                notifyListeners();
              },
              toDetail: (value) {
                story = value;
                notifyListeners();
              },
              toUploadScreen: () {
                isUpload = true;
                notifyListeners();
              },
            ),
          ),
        if (story != null)
          MaterialPage(
            key: ValueKey('StoryDetail-$story'),
            child: DetailScreen(
              story: story!,
            ),
          ),
        if (isUpload)
          MaterialPage(
            key: const ValueKey('UploadPage'),
            child: UploadScreen(
              onUpload: () {
                isUpload = false;
                notifyListeners();
              },
            ),
          )
      ];
  List<Page> get _loggedOutStack => [
        MaterialPage(
          key: const ValueKey('LoginPage'),
          child: LoginScreen(
            toRegisterScreen: () {
              isRegister = true;
              notifyListeners();
            },
            onLogin: () async {
              isLoggedIn = await authRepository.isLoggedIn();
              notifyListeners();
            },
          ),
        ),
        if (isRegister == true)
          MaterialPage(
            key: const ValueKey('RegisterPage'),
            child: RegisterScreen(
              toLoginScreen: () {
                isRegister = false;
                notifyListeners();
              },
            ),
          )
      ];
  @override
  Widget build(BuildContext context) {
    if (isLoggedIn == null) {
      historyStack = _splashStack;
    } else if (isLoggedIn == true) {
      historyStack = _loggedInStack;
    } else {
      historyStack = _loggedOutStack;
    }
    return Navigator(
      pages: historyStack,
      onPopPage: (route, result) {
        final didPop = route.didPop(result);
        if (!didPop) return false;

        isRegister = false;
        isUpload = false;
        story = null;
        notifyListeners();
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(configuration) {
    throw UnimplementedError();
  }
}
