import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:story_app/data/local/model/story.dart';

Widget itemStoryWidget(BuildContext context, Story story) {
  return Card(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: story.photoUrl,
          cacheManager: CacheManager(
            Config(
              story.photoUrl,
              stalePeriod: const Duration(days: 1),
            ),
          ),
          progressIndicatorBuilder: (context, url, progress) {
            return CircularProgressIndicator(
              value: progress.progress,
              strokeWidth: 0.1,
            );
          },
          width: MediaQuery.of(context).size.width,
          height: 175,
          fit: BoxFit.fill,
        ),
        Text(
          story.name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Color(0xFFB3005E),
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        )
      ],
    ),
  );
}
