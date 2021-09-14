import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as syspaths;

class ImageInput extends StatefulWidget {
  const ImageInput({Key? key, required this.selectImage}) : super(key: key);
  final Function selectImage;

  @override
  _ImageInputState createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _storedImage;

  Future<void> _takePicture() async {
    final picker = ImagePicker();
    try {
      final image = await picker.pickImage(source: ImageSource.camera);

      setState(() {
        _storedImage = File(image!.path);
      });
      final appDir = await syspaths.getApplicationDocumentsDirectory();
      final temporyPath = path.basename(_storedImage!.path);
      final savedImage =
          await _storedImage!.copy('${appDir.path}/$temporyPath');
      widget.selectImage(savedImage);
    } catch (e) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: Text("Error Accord while trying get image"),
                content: Text(e.toString()),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close I see it"))
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: _storedImage != null
              ? Image.file(
                  _storedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text("select image"),
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.5,
          height: 150,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextButton.icon(
            onPressed: _takePicture,
            icon: Icon(Icons.camera),
            label: Text(
              "Take",
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
