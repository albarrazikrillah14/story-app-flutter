import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/remote/api/api_service.dart';
import 'package:story_app/provider/auth_provider.dart';
import 'package:story_app/data/db/auth_repository.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/provider/upload_provider.dart';
import 'package:story_app/routes/router_delegate.dart';

void main() => runApp(const StoryApp());

class StoryApp extends StatefulWidget {
  const StoryApp({Key? key}) : super(key: key);

  @override
  State<StoryApp> createState() => _StoryAppState();
}

class _StoryAppState extends State<StoryApp> {
  late StoryAppRouterDelegate storyAppRouterDelegate;
  late AuthProvider authProvider;
  late StoriesProvider storiesProvider;
  late UploadProvider uploadProvider;

  @override
  void initState() {
    final AuthRepository authRepository = AuthRepository();
    storiesProvider = StoriesProvider(ApiService(authRepository));
    authProvider = AuthProvider(authRepository, ApiService(authRepository));

    uploadProvider = UploadProvider(apiService: ApiService(authRepository));

    storyAppRouterDelegate =
        StoryAppRouterDelegate(authRepository, storiesProvider);

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
        ChangeNotifierProvider(
          create: (context) => uploadProvider,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.red,
            accentColor: Colors.black,
            backgroundColor: Colors.white,
          ),
          buttonTheme: const ButtonThemeData(
            buttonColor: Color(0xFFB3005E),
          ),
          iconTheme: const IconThemeData(color: Color(0xFFB3005E)),
        ),
        title: 'StoryApp',
        home: Router(
          routerDelegate: storyAppRouterDelegate,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
      ),
    );
  }
}
