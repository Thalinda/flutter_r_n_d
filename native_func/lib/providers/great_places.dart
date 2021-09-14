import 'dart:io';

import 'package:flutter/cupertino.dart';
import '../models/place.dart';
import '../helpers/db_helpers.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newplace = Place(
        id: DateTime.now().toString(),
        image: image,
        location: '',
        title: title);

    _items.add(newplace);
    notifyListeners();
    DBHelper.insert('user_places', {
      'id': newplace.id,
      'title': newplace.title,
      'image': newplace.image.path
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            image: File(item["image"]),
            location: "null",
            title: item["title"]))
        .toList();
    notifyListeners();
  }
}
