import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/local/model/story.dart';
import 'package:story_app/helper/helper.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:geocoding/geocoding.dart' as geo;

class DetailScreen extends StatefulWidget {
  final String storyId;
  final Function(LatLng position) toDetailMap;

  const DetailScreen(
      {Key? key, required this.storyId, required this.toDetailMap})
      : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late StoriesProvider storiesProvider;

  @override
  void initState() {
    storiesProvider = context.read<StoriesProvider>();
    Future.microtask(() {
      storiesProvider.fetchDetailStory(widget.storyId);
    });
    super.initState();
  }

  Future<String> getAddress(double lat, double lon) async {
    try {
      final info = await geo.placemarkFromCoordinates(lat, lon);
      if (info.isNotEmpty) {
        final place = info[0];
        return '${place.street}';
      }
      return 'Location not available';
    } catch (e) {
      return 'Location not available';
    }
  }

  @override
  Widget build(BuildContext context) {
    late LatLng position;
    return Scaffold(
      backgroundColor: const Color(0xFFB3005E),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB3005E),
        title: const Text(
          'Detail Story',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              if (position.latitude == 0.0 && position.longitude == 0.0) {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Lokasi tidak tersedia")));
              } else {
                widget.toDetailMap(position);
              }
            },
            icon: const Icon(Icons.map),
          ),
        ],
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
          child: ChangeNotifierProvider.value(
            value: storiesProvider,
            child: Consumer<StoriesProvider>(
              builder: (context, storiesProvider, _) {
                if (storiesProvider.state == ResultState.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (storiesProvider.state == ResultState.hasData) {
                  final Story story = storiesProvider.detailStory;
                  position = LatLng(story.lat ?? 0.0, story.lon ?? 0.0);
                  final addressFuture = story.lat != null && story.lon != null
                      ? getAddress(story.lat!, story.lon!)
                      : Future.value('No location data');

                  return SingleChildScrollView(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Icon(
                                    Icons.map,
                                    color: Colors.black,
                                  ),
                                  FutureBuilder<String>(
                                    future: addressFuture,
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const CircularProgressIndicator();
                                      } else if (snapshot.hasError) {
                                        return const Text('Lokasi tidak ada');
                                      } else {
                                        return Text(
                                          snapshot.data.toString(),
                                          softWrap: true,
                                          textAlign: TextAlign.right,
                                        );
                                      }
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                  );
                } else {
                  return Center(
                    child: Text(storiesProvider.message),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
