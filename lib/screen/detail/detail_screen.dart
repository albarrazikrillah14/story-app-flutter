import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:story_app/data/local/model/story.dart';
import 'package:story_app/helper/helper.dart';

class DetailScreen extends StatelessWidget {
  final Story story;

  const DetailScreen({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB3005E),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB3005E),
        title: Text(
          story.name.toUpperCase(),
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16)),
                  child: CachedNetworkImage(
                    imageUrl: story.photoUrl,
                    cacheManager: CacheManager(Config(
                      story.photoUrl,
                      stalePeriod: const Duration(days: 1),
                    )),
                    progressIndicatorBuilder: (context, url, progress) {
                      return CircularProgressIndicator(
                        value: progress.progress,
                        strokeWidth: 0.1,
                      );
                    },
                    width: MediaQuery.of(context).size.width,
                    height: 400,
                    fit: BoxFit.fill,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        story.name.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.map,
                            color: Colors.black,
                          ),
                          Text('(${story.lat}, ${story.lon})')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.create,
                            color: Colors.black,
                          ),
                          Text(DateHelper().formatDate(story.createdAt))
                        ],
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        story.description,
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
