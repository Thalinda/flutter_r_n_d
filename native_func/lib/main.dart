import 'package:flutter/material.dart';
import 'package:native_func/providers/great_places.dart';
import 'package:native_func/screens/add_place_screen.dart';
import 'package:native_func/screens/places_list.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: PlacesListScreen(),
        routes: {AddPlacesList.routeName: (ctx) => AddPlacesList()},
      ),
    );
  }
}
