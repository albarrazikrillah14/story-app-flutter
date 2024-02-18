import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/local/model/upload/story_upload_request.dart';
import 'package:story_app/provider/stories_provider.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:story_app/routes/location_page_manager.dart';

class UploadScreen extends StatefulWidget {
  final Function() onUpload;
  final Function() toMapPicker;
  final LatLng? position;

  const UploadScreen({
    Key? key,
    required this.onUpload,
    required this.toMapPicker,
    this.position,
  }) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final textController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late LatLng selectedLocation;
  late String location;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    location = '';
    if (widget.position != null) {
      getLocation();
      setState(() {});
    }
  }

  void getLocation() async {
    final info = await geo.placemarkFromCoordinates(
        widget.position?.latitude ?? 0.0, widget.position?.longitude ?? 0.0);

    final place = info[0];
    final street = place.street!;
    location = street;
  }

  @override
  Widget build(BuildContext context) {
    onUpload() async {
      final provider = context.read<StoriesProvider>();
      final imagePath = provider.imagePath;
      final imageFile = provider.imageFile;
      if (imagePath == null || imageFile == null) return;

      final fileName = imageFile.name;
      final bytes = await imageFile.readAsBytes();

      final request = StoryUploadRequest(
        bytes: bytes,
        fileName: fileName,
        description: textController.text,
        lat: selectedLocation.latitude,
        lon: selectedLocation.longitude,
      );
      await provider.upload(request);
      provider.removeImage();
    }

    onGalerryView() async {
      final provider = context.read<StoriesProvider>();

      final isMacOS = defaultTargetPlatform == TargetPlatform.macOS;
      final isLinux = defaultTargetPlatform == TargetPlatform.linux;

      if (isMacOS || isLinux) return;

      final ImagePicker picker = ImagePicker();

      final XFile? pickedFile =
          await picker.pickImage(source: ImageSource.gallery);

      if (pickedFile != null) {
        provider.setImageFile(pickedFile);
        provider.setImagePath(pickedFile.path);
      }
    }

    onCameraView() async {
      final provider = context.read<StoriesProvider>();
      final ImagePicker picker = ImagePicker();

      final isAndroid = defaultTargetPlatform == TargetPlatform.android;
      final isiOS = defaultTargetPlatform == TargetPlatform.iOS;
      final isNotMobile = !(isAndroid || isiOS);
      if (isNotMobile) return;

      final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
      );

      if (pickedFile != null) {
        provider.setImageFile(pickedFile);
        provider.setImagePath(pickedFile.path);
      }
    }

    Widget showImage() {
      final imagepath = context.read<StoriesProvider>().imagePath;

      return kIsWeb
          ? Image.network(
              imagepath.toString(),
              fit: BoxFit.fill,
              height: 400,
            )
          : Image.file(
              File(imagepath.toString()),
              fit: BoxFit.fill,
              height: 400,
            );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFB3005E),
      appBar: AppBar(
        backgroundColor: const Color(0xFFB3005E),
        title: const Text(
          'Upload Story',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () async {
              await onCameraView();
            },
            icon: const Icon(
              Icons.add_a_photo_outlined,
              color: Colors.black,
            ),
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
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                context.watch<StoriesProvider>().imagePath == null
                    ? IconButton(
                        onPressed: () async {
                          await onGalerryView();
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 150,
                        ))
                    : showImage(),
                context.watch<StoriesProvider>().imageFile == null
                    ? const SizedBox(
                        height: 8,
                      )
                    : Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            final uploadRead = context.read<StoriesProvider>();

                            uploadRead.removeImage();
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                      ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: textController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Deskripsi tidak boleh kosong';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          labelText: 'Deskripsi...',
                          border: OutlineInputBorder(),
                        ),
                        maxLines: 5,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(16)),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(location.isNotEmpty
                                  ? location
                                  : "Pilih Lokasi Anda"),
                              IconButton(
                                onPressed: () async {
                                  widget.toMapPicker();
                                  final locationManager =
                                      context.read<LocationPageManager>();
                                  var result =
                                      await locationManager.waitForResult();
                                  setState(() async {
                                    selectedLocation = result;

                                    final info =
                                        await geo.placemarkFromCoordinates(
                                            selectedLocation.latitude,
                                            selectedLocation.longitude);

                                    final place = info[0];
                                    final street = place.street!;
                                    location = street;
                                  });
                                },
                                icon: const Icon(Icons.location_city),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      context.watch<StoriesProvider>().isUploading == true
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  onUpload();
                                  widget.onUpload();
                                }
                              },
                              child: SizedBox(
                                height: 60,
                                width: MediaQuery.of(context).size.width,
                                child: const Center(
                                  child: Text(
                                    'UPLOAD',
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
