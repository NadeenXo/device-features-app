import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../services/image_picker_service.dart';

class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({super.key});

  @override
  State<ImageGalleryScreen> createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  final ImagePickerService _imagePickerService = ImagePickerService();

  final List<XFile> _selectedImages = [];

  // Gets multiple images from the device gallery and displays them in the list.
  Future<void> _pickImages() async {
    final List<XFile> pickedImages = await _imagePickerService
        .pickMultipleImages();

    if (pickedImages.isEmpty) {
      return;
    }

    setState(() {
      _selectedImages.addAll(pickedImages);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Image Gallery'), centerTitle: true),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: _selectedImages.isEmpty
                  ? const Center(
                      child: Text(
                        'No images selected yet.',
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: _selectedImages.length,
                      itemBuilder: (context, index) {
                        final XFile image = _selectedImages[index];

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              File(image.path),
                              height: 220,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _pickImages,
                  icon: const Icon(Icons.photo_library),
                  label: const Text('Pick Image'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
