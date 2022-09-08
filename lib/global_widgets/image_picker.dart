import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerWedgit extends StatefulWidget {
  const ImagePickerWedgit(
    this.pickedImagefn, {
    Key? key,
  }) : super(key: key);

  final void Function(File pickedImage) pickedImagefn;

  @override
  State<ImagePickerWedgit> createState() => _ImagePickerWedgitState();
}

class _ImagePickerWedgitState extends State<ImagePickerWedgit> {
  dynamic _pickedImage;
  void _pickImage() async {
    // ignore: invalid_use_of_visible_for_testing_member
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery );
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
        CircleAvatar(
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
          radius: 20,
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