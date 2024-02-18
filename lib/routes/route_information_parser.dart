import 'package:flutter/cupertino.dart';
import 'package:story_app/data/local/model/page_configuration.dart';

class StoryRouteInformationParser
    extends RouteInformationParser<PageConfiguration> {
// StoryRouteInformationParser
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location.toString());
    if (uri.pathSegments.isEmpty) {
      return PageConfiguration.home();
    } else if (uri.pathSegments.length == 1) {
      final first = uri.pathSegments[0].toLowerCase();
      if (first == '') {
        return PageConfiguration.home();
      } else if (first == 'login') {
        return PageConfiguration.login();
      } else if (first == 'register') {
        return PageConfiguration.register();
      } else if (first == 'splash') {
        return PageConfiguration.splash();
      } else if (first == 'upload') {
        return PageConfiguration.upload();
      } else {
        return PageConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 2) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      if (first == 'upload' && second.isNotEmpty) {
        return PageConfiguration.mapPicker();
      } else if (first == 'story' && second.isNotEmpty) {
        final storyId = second.toString();
        return PageConfiguration.detailStory(storyId);
      } else {
        return PageConfiguration.unknown();
      }
    } else if (uri.pathSegments.length == 3) {
      final first = uri.pathSegments[0].toLowerCase();
      final second = uri.pathSegments[1].toLowerCase();
      final third = uri.pathSegments[2].toLowerCase();

      if (first == 'story' && second.isNotEmpty && third.isNotEmpty) {
        final storyid = second.toString();
        return PageConfiguration.mapDetail(storyid);
      } else {
        return PageConfiguration.unknown();
      }
    } else {
      return PageConfiguration.unknown();
    }
  }

// StoryRouteInformationParser
  @override
  RouteInformation? restoreRouteInformation(PageConfiguration configuration) {
    if (configuration.isUnknownPage) {
      return const RouteInformation(location: '/unknown');
    } else if (configuration.isSplashPage) {
      return const RouteInformation(location: '/splash');
    } else if (configuration.isRegisterPage) {
      return const RouteInformation(location: '/register');
    } else if (configuration.isLoginPage) {
      return const RouteInformation(location: '/login');
    } else if (configuration.isUploadPage) {
      return const RouteInformation(location: '/upload');
    } else if (configuration.isHomePage) {
      return const RouteInformation(location: '/');
    } else if (configuration.isDetailPage) {
      return RouteInformation(location: '/story/${configuration.storyId}');
    } else if (configuration.mapPicker) {
      return const RouteInformation(location: '/upload/map');
    } else if (configuration.mapDetail) {
      return RouteInformation(location: '/story/${configuration.storyId}/map');
    } else {
      return null;
    }
  }
}
