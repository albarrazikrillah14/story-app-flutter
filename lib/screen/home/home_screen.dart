import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/db/auth_repository.dart';
import 'package:story_app/data/local/model/list/story_list_request.dart';
import 'package:story_app/data/local/model/story.dart';
import 'package:story_app/data/remote/api/api_service.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:story_app/widget/item_story_widget.dart';

class HomeScreen extends StatelessWidget {
  final Function() logout;
  final Function(Story story) toDetail;

  const HomeScreen({Key? key, required this.logout, required this.toDetail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Story>? list;
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
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xFFB3005E),
                    title: const Text(
                      'Konfirmasi Logout',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24),
                    ),
                    content: const Text(
                      'Apakah Anda yakin ingin logout?',
                      style: TextStyle(color: Colors.white),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          logout();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'YA',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'BATAL',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ],
                  );
                },
              );
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
          child: ChangeNotifierProvider<StoriesProvider>(
            create: (context) => StoriesProvider(ApiService(AuthRepository())),
            child: Consumer<StoriesProvider>(
              builder: (context, storiesProvider, _) {
                final request = StoryListRequest(page: 0, size: 0, location: 0);

                Future.delayed(Duration.zero, () {
                  if (list == null) storiesProvider.fetchAllStories(request);
                  list = storiesProvider.stories;
                });

                if (list == null) {
                  return const Center(child: CircularProgressIndicator());
                } else {
                  return GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.8,
                    padding: const EdgeInsets.all(16),
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 16,
                    children: List.generate(
                      list!.length,
                      (index) => GestureDetector(
                        onTap: () {
                          toDetail(list![index]);
                        },
                        child: itemStoryWidget(context, list![index]),
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          // Add functionality for the FloatingActionButton here
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
