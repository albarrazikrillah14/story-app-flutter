import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:story_app/data/local/model/upload/story_upload_request.dart';
import 'package:story_app/provider/upload_provider.dart';

class UploadScreen extends StatefulWidget {
  final Function() onUpload;
  const UploadScreen({
    Key? key,
    required this.onUpload,
  }) : super(key: key);

  @override
  State<UploadScreen> createState() => _UploadScreenState();
}

class _UploadScreenState extends State<UploadScreen> {
  final textController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _onUpload() async {
      final provider = context.read<UploadProvider>();
      final imagePath = provider.imagePath;
      final imageFile = provider.imageFile;
      if (imagePath == null || imageFile == null) return;

      final fileName = imageFile.name;
      final bytes = await imageFile.readAsBytes();

      final request = StoryUploadRequest(
          bytes: bytes, fileName: fileName, description: textController.text);

      final result = await provider.upload(request);

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result?.message ?? "")));
    }

    _onGalerryView() async {
      final provider = context.read<UploadProvider>();

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

    _onCameraView() async {
      final provider = context.read<UploadProvider>();
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

    Widget _showImage() {
      final imagepath = context.read<UploadProvider>().imagePath;

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
              await _onCameraView();
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
                context.watch<UploadProvider>().imagePath == null
                    ? IconButton(
                        onPressed: () async {
                          await _onGalerryView();
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 150,
                        ))
                    : _showImage(),
                context.watch<UploadProvider>().imageFile == null
                    ? const SizedBox(
                        height: 8,
                      )
                    : Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          onPressed: () {
                            final uploadRead = context.read<UploadProvider>();

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
                  child: TextFormField(
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
                ),
                const SizedBox(
                  height: 16,
                ),
                context.watch<UploadProvider>().isUploading == true
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            _onUpload();
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
          )),
        ),
      ),
    );
  }
}
