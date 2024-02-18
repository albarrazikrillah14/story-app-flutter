import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/common/url_strategy.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/data/db/auth_repository.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/routes/location_page_manager.dart';
import 'package:story_app/routes/page_manager.dart';
import 'package:story_app/routes/route_information_parser.dart';
import 'package:story_app/routes/router_delegate.dart';

void main() {
  usePathUrlStrategy();
  runApp(const StoryApp());
}

class StoryApp extends StatefulWidget {
  const StoryApp({Key? key}) : super(key: key);

  @override
  State<StoryApp> createState() => _StoryAppState();
}

class _StoryAppState extends State<StoryApp> {
  late StoryRouteInformationParser storyRouteInformationParser;
  late StoryAppRouterDelegate storyAppRouterDelegate;
  late AuthProvider authProvider;
  late StoriesProvider storiesProvider;
  late LocationPageManager locationPageManager;
  late PageManager pageManager;

  @override
  void initState() {
    storyRouteInformationParser = StoryRouteInformationParser();
    final AuthRepository authRepository = AuthRepository();
    storiesProvider = StoriesProvider(authRepository);
    authProvider = AuthProvider(authRepository);
    storyAppRouterDelegate =
        StoryAppRouterDelegate(authProvider, storiesProvider);
    locationPageManager = LocationPageManager();
    pageManager = PageManager();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => authProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => storiesProvider,
        ),
        ChangeNotifierProvider(create: (context) => locationPageManager),
        ChangeNotifierProvider(create: (context) => pageManager)
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Story App',
        routerDelegate: storyAppRouterDelegate,
        routeInformationParser: storyRouteInformationParser,
        backButtonDispatcher: RootBackButtonDispatcher(),
      ),
    );
  }
}
