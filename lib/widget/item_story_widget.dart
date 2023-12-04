import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:story_app/data/local/model/story.dart';

Widget itemStoryWidget(BuildContext context, Story story) {
  return Stack(
    children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 2,
        height: 200,
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          width: MediaQuery.of(context).size.width / 2,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
        ),
      ),
      Positioned(
        top: 0,
        left: 4,
        right: 4,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(16)),
          child: CachedNetworkImage(
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
        ),
      ),
      Positioned(
        bottom: 0,
        left: 0,
        right: 0,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2),
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            story.name,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Color(0xFFB3005E),
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
    ],
  );
}
