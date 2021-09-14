import 'dart:io';
import 'package:flutter/material.dart';
import 'package:native_func/providers/great_places.dart';
import 'package:native_func/widget/image_input.dart';
import 'package:native_func/widget/place_input.dart';
import 'package:provider/provider.dart';

class AddPlacesList extends StatefulWidget {
  const AddPlacesList({Key? key}) : super(key: key);
  static String routeName = '/add-place';

  @override
  _AddPlacesListState createState() => _AddPlacesListState();
}

class _AddPlacesListState extends State<AddPlacesList> {
  final _titlecontroler = TextEditingController();
  late File _pickedImage;
  void _selectImage(File pickedimage) {
    _pickedImage = pickedimage;
  }

  void _savedPlace() {
    // ignore: unnecessary_null_comparison
    if (_titlecontroler.text.isEmpty || _pickedImage == null) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return new AlertDialog(
              actions: [
                TextButton(
                    onPressed: () => {Navigator.of(context).pop()},
                    child: Text("Okay"))
              ],
              title: new Text("Please Give both data"),
              content: new Text("Please select both image and title"),
            );
          });
      return null;
    }

    Provider.of<GreatPlaces>(context, listen: false)
        .addPlace(_titlecontroler.text, _pickedImage);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New Place"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  TextField(
                    controller: _titlecontroler,
                    decoration: InputDecoration(labelText: 'Title'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  ImageInput(
                    selectImage: _selectImage,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  PlaceInput()
                ],
              ),
            ),
          )),
          ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                  elevation: 0,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap),
              onPressed: _savedPlace,
              icon: Icon(Icons.add),
              label: Text("Add Place"))
        ],
      ),
    );
  }
}
