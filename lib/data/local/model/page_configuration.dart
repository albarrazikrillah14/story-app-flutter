class PageConfiguration {
  final bool unknown;
  final bool register;
  final bool? loggedIn;
  final String? storyId;
  final bool upload;
  final bool mapPicker;
  final bool mapDetail;

  PageConfiguration.splash()
      : unknown = false,
        register = false,
        loggedIn = null,
        storyId = null,
        upload = false,
        mapPicker = false,
        mapDetail = false;

  PageConfiguration.login()
      : unknown = false,
        register = false,
        loggedIn = false,
        storyId = null,
        upload = false,
        mapPicker = false,
        mapDetail = false;

  PageConfiguration.register()
      : unknown = false,
        register = true,
        loggedIn = false,
        storyId = null,
        upload = false,
        mapPicker = false,
        mapDetail = false;

  PageConfiguration.home()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        upload = false,
        mapPicker = false,
        mapDetail = false;

  PageConfiguration.detailStory(String id)
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = id,
        upload = false,
        mapPicker = false,
        mapDetail = false;

  PageConfiguration.upload()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        upload = true,
        mapPicker = false,
        mapDetail = false;

  PageConfiguration.mapPicker()
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = null,
        upload = true,
        mapPicker = true,
        mapDetail = false;

  PageConfiguration.mapDetail(String id)
      : unknown = false,
        register = false,
        loggedIn = true,
        storyId = id,
        upload = true,
        mapPicker = false,
        mapDetail = true;

  PageConfiguration.unknown()
      : unknown = true,
        register = false,
        loggedIn = null,
        storyId = null,
        upload = false,
        mapPicker = false,
        mapDetail = false;

  bool get isSplashPage =>
      !unknown &&
      !register &&
      loggedIn == null &&
      storyId == null &&
      !upload &&
      !mapPicker &&
      !mapDetail;

  bool get isLoginPage =>
      !unknown &&
      !register &&
      loggedIn == false &&
      storyId == null &&
      !upload &&
      !mapPicker &&
      !mapDetail;

  bool get isRegisterPage =>
      !unknown &&
      register &&
      loggedIn == false &&
      storyId == null &&
      !upload &&
      !mapPicker &&
      !mapDetail;

  bool get isHomePage =>
      !unknown &&
      !register &&
      loggedIn == true &&
      storyId == null &&
      !upload &&
      !mapPicker &&
      !mapDetail;

  bool get isDetailPage =>
      !unknown &&
      !register &&
      loggedIn == true &&
      storyId != null &&
      !upload &&
      !mapPicker &&
      !mapDetail;

  bool get isUploadPage =>
      !unknown &&
      !register &&
      loggedIn == true &&
      storyId == null &&
      upload &&
      !mapPicker &&
      !mapDetail;

  bool get isMapPicker =>
      !unknown &&
      !register &&
      loggedIn == true &&
      storyId == null &&
      upload &&
      mapPicker &&
      !mapDetail;

  bool get isMapDetail =>
      !unknown &&
      !register &&
      loggedIn == true &&
      storyId != null &&
      upload &&
      !mapPicker &&
      mapDetail;

  bool get isUnknownPage =>
      unknown &&
      !register &&
      loggedIn == null &&
      storyId == null &&
      !upload &&
      !mapPicker &&
      !mapDetail;
}
