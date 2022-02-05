import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:greate_places_app/helpers/db_helpers.dart';
import '../models/place.dart';
import '../helpers/db_helpers.dart';

class Places with ChangeNotifier {
  List<Place> _items = [];
  List<Place> get getPlaces {
    return [..._items];
  }

  void addPlace(String title, File image) {
    final newPlace = Place(
        id: DateTime.now().toString(),
        title: title,
        image: image,
        location: null);
    _items.add(newPlace);
    notifyListeners();
    DBHelpers.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final data = await DBHelpers.getData('user_places');
    print(data);
    _items = data.map((item) {
      return Place(
        id: item['id'],
        title: item['title'],
        location: null,
        image: File(item['image']),
      );
    }).toList();
    notifyListeners();
  }
}
