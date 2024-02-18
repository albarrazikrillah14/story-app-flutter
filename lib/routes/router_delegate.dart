import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:story_app/data/local/model/page_configuration.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/screen/auth/login_screen.dart';
import 'package:story_app/screen/auth/register_screen.dart';
import 'package:story_app/screen/detail/detail_screen.dart';
import 'package:story_app/screen/home/home_screen.dart';
import 'package:story_app/screen/map/maps_screen.dart';
import 'package:story_app/screen/splash/splash_screen.dart';
import 'package:story_app/screen/unknown/unknown_screen.dart';
import 'package:story_app/screen/upload/upload_screen.dart';

class StoryAppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  final GlobalKey<NavigatorState> _navigatorKey;
  final AuthProvider authProvider;
  final StoriesProvider storiesProvider;

  StoryAppRouterDelegate(this.authProvider, this.storiesProvider)
      : _navigatorKey = GlobalKey<NavigatorState>() {
    _init();
  }
  void _init() async {
    await Future.delayed(const Duration(seconds: 3));
    isLoggedIn = await authProvider.isLoggedIn();
    notifyListeners();
  }

  List<Page> historyStack = [];
  bool? isLoggedIn;
  bool isRegister = false;
  bool isUpload = false;
  String? storyId;
  bool? isUnknown;
  LatLng? position;
  bool? isMap;
  LatLng? selectedLocation;

  List<Page> get _splashStack => const [
        MaterialPage(
          key: ValueKey("SplashPage"),
          child: SplashScreen(),
        ),
      ];

  List<Page> get _unknownStack => const [
        MaterialPage(
          key: ValueKey('UnknownPage'),
          child: UnknownScreen(),
        ),
      ];

  List<Page> get _loggedInStack => [
        if (isLoggedIn == true)
          MaterialPage(
            key: const ValueKey('HomePage'),
            child: HomeScreen(
              toDetail: (value) {
                storyId = value;
                notifyListeners();
              },
              toUploadScreen: () {
                isUpload = true;
                notifyListeners();
              },
              onLogout: () async {
                await authProvider.logout();
                isLoggedIn = await authProvider.isLoggedIn();
                notifyListeners();
              },
            ),
          ),
        if (storyId != null)
          MaterialPage(
            key: ValueKey('$storyId'),
            child: DetailScreen(
              storyId: storyId!,
              toDetailMap: (LatLng position) {
                this.position = position;
                isMap = true;
                notifyListeners();
              },
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
              toMapPicker: () {
                isMap = true;
                notifyListeners();
              },
              position: selectedLocation,
            ),
          ),
        if (isMap == true)
          MaterialPage(
            key: const ValueKey('Maps-Screen'),
            child: MapsScreen(
              position: position ?? const LatLng(0.0, 0.0),
              onMapScreen: () {
                isMap = false;
                notifyListeners();
              },
            ),
          ),
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
              isLoggedIn = await authProvider.isLoggedIn();
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
    if (isUnknown == true) {
      historyStack = _unknownStack;
    } else if (isLoggedIn == null) {
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

        position = null;
        if (isMap == true) {
          isMap = false;
        } else {
          storyId = null;
          isUpload = false;
        }
        notifyListeners();
        return true;
      },
    );
  }

  @override
  GlobalKey<NavigatorState>? get navigatorKey => _navigatorKey;

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) async {
    if (configuration.isUnknownPage) {
      isUnknown = true;
      isRegister = false;
      storyId = null;
      isUpload = false;
      isMap = false;
    } else if (configuration.isUploadPage) {
      isUpload = true;
      isMap = false;
    } else if (configuration.isRegisterPage) {
      isRegister = true;
      isMap = false;
    } else if (configuration.isHomePage ||
        configuration.isLoginPage ||
        configuration.isSplashPage) {
      isUnknown = false;
      storyId = null;
      isRegister = false;
      isUpload = false;
      isMap = false;
    } else if (configuration.isDetailPage) {
      isUnknown = false;
      isRegister = false;
      storyId = configuration.storyId;
      isUpload = false;
      isMap = false;
    } else if (configuration.mapPicker) {
      isMap = true;
      storyId = null;
    } else if (configuration.mapDetail) {
      isMap = true;
      storyId = storyId;
      isUpload = false;
    } else {}
    notifyListeners();
  }

  @override
  PageConfiguration? get currentConfiguration {
    if (isLoggedIn == null) {
      return PageConfiguration.splash();
    } else if (isRegister == true) {
      return PageConfiguration.register();
    } else if (isLoggedIn == false) {
      return PageConfiguration.login();
    } else if (isUnknown == true) {
      return PageConfiguration.unknown();
    } else if (storyId == null && isUpload == false) {
      return PageConfiguration.home();
    } else if (isUpload == true && isMap == false) {
      return PageConfiguration.upload();
    } else if (storyId != null && isMap == false) {
      return PageConfiguration.detailStory(storyId!);
    } else if (isMap == true && storyId == null) {
      return PageConfiguration.mapPicker();
    } else if (isMap == true && storyId != null) {
      return PageConfiguration.mapDetail(storyId!);
    } else {
      return null;
    }
  }
}
