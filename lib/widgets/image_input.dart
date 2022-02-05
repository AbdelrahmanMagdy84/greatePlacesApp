import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import "package:path_provider/path_provider.dart" as syspaths;

class ImageInput extends StatefulWidget {
  Function saveImage;
  ImageInput(this.saveImage);
  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;
  Future<void> takePicture() async {
    final imageFile = await ImagePicker()
        .pickImage(source: ImageSource.camera, maxWidth: 600);
    if (imageFile == null) {
      return;
    }
    setState(() {
      _storedImage = File(imageFile.path);
    });
    final appDir = await syspaths.getApplicationDocumentsDirectory();
    final fileName = path.basename(imageFile.path);
    final savedImage = await _storedImage!.copy("${appDir.path}/$fileName");
    widget.saveImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration:
              BoxDecoration(border: Border.all(width: 2, color: Colors.grey)),
          alignment: Alignment.center,
          width: 150,
          height: 120,
          child: _storedImage == null
              ? const Text("No image taken")
              : Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Expanded(
            child: TextButton.icon(
                onPressed: takePicture,
                icon: Icon(Icons.camera),
                label: Text("Take a picture")))
      ],
    );
  }
}
