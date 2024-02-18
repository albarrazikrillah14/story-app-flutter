import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/local/model/story.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/routes/page_manager.dart';
import 'package:story_app/widget/item_story_widget.dart';

class HomeScreen extends StatefulWidget {
  final Function(String storyId) toDetail;
  final Function() toUploadScreen;
  final Function() onLogout;

  const HomeScreen({
    Key? key,
    required this.toDetail,
    required this.toUploadScreen,
    required this.onLogout,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late StoriesProvider storiesProvider;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    storiesProvider = context.read<StoriesProvider>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent) {
        if (storiesProvider.pageItems != null) {
          storiesProvider.fetchAllStories();
        }
      }
    });

    Future.microtask(() => storiesProvider.fetchAllStories());
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFB3005E),
        appBar: AppBar(
          backgroundColor: const Color(0xFFB3005E),
          title: const Text(
            'Story App',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                widget.onLogout();
              },
              icon: const Icon(
                Icons.logout,
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              color: Colors.white,
            ),
            child: ChangeNotifierProvider.value(
              value: storiesProvider,
              child: Consumer<StoriesProvider>(
                builder: (context, storiesProvider, _) {
                  if (storiesProvider.state == ResultState.loading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (storiesProvider.state == ResultState.hasData) {
                    List<Story> list = storiesProvider.stories;
                    return ListView.builder(
                      controller: scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: list.length +
                          (storiesProvider.pageItems != null ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == list.length &&
                            storiesProvider.pageItems != null) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        } else {
                          final story = list[index];
                          return GestureDetector(
                            onTap: () {
                              widget.toDetail(story.id);
                            },
                            child: itemStoryWidget(context, story),
                          );
                        }
                      },
                    );
                  } else {
                    return const Center(
                      child: Text("No data"),
                    );
                  }
                },
              ),
            ),
          ),
        ),
        floatingActionButton: ChangeNotifierProvider<PageManager>(
          create: (context) => PageManager(),
          child: Consumer<PageManager>(
            builder: (context, pageManager, child) {
              return FloatingActionButton(
                backgroundColor: Colors.black,
                onPressed: () async {
                  final scaffoldMessenger = ScaffoldMessenger.of(context);
                  widget.toUploadScreen();

                  final dataString = await pageManager.waitForResult();

                  scaffoldMessenger.showSnackBar(
                    SnackBar(content: Text(dataString)),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              );
            },
          ),
        ));
  }
}
