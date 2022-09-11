import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWedgit extends StatefulWidget {
  const ImagePickerWedgit(
    this.pickedImagefn, {
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  final void Function(File pickedImage) pickedImagefn;
  final String? imageUrl;
  static File? imageHolder;

  @override
  State<ImagePickerWedgit> createState() => _ImagePickerWedgitState();
}

class _ImagePickerWedgitState extends State<ImagePickerWedgit> {
  dynamic _pickedImage;
  void _pickImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage!.path.isNotEmpty) {
      setState(() {
        _pickedImage = File(pickedImage.path);
      });
      widget.pickedImagefn(_pickedImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (widget.imageUrl != null)
          Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Image.network(widget.imageUrl as String),
              ),
              const Text(
                "image",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
        Column(
          children: [
            CircleAvatar(
              backgroundImage:
                  _pickedImage != null ? FileImage(_pickedImage) : null,
              radius: 20,
              backgroundColor: Colors.black,
            ),
            const Text(
              "new image",
              style: TextStyle(fontSize: 10),
            )
          ],
        ),
        TextButton.icon(
          icon: const Icon(Icons.image),
          onPressed: _pickImage,
          label: const Text("Add image"),
        ),
      ],
    );
  }
}
